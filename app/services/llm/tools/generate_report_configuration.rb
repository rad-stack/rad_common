module LLM
  module Tools
    class GenerateReportConfiguration < Base
      PARAM_SCHEMA = {
        type: 'object',
        properties: {
          name: {
            type: 'string',
            description: 'Name for the custom report'
          },
          description: {
            type: 'string',
            description: 'Optional description of what the report shows'
          },
          model_name: {
            type: 'string',
            description: 'The base model name for the report (e.g., "User", "Company")'
          },
          joins: {
            type: 'array',
            description: 'Array of association paths to join (e.g., ["division", "division.company"])',
            items: { type: 'string' }
          },
          columns: {
            type: 'array',
            description: 'Array of column configurations',
            items: {
              type: 'object',
              properties: {
                name: {
                  type: 'string',
                  description: 'Column name from the database'
                },
                label: {
                  type: 'string',
                  description: 'Human-readable label for the column'
                },
                select: {
                  type: 'string',
                  description: 'The full select path (e.g., "users.name" or "division.name"). ' \
                               'NOT required for calculated columns.'
                },
                sortable: {
                  type: 'boolean',
                  description: 'Whether this column can be sorted by users (default: false). ' \
                               'Must be false for calculated columns.'
                },
                is_calculated: {
                  type: 'boolean',
                  description: 'Set to true for calculated columns that combine multiple database columns. ' \
                               'These columns do not have a "select" field.'
                },
                formula: {
                  type: 'array',
                  description: 'Optional array of transformations to apply to the column value',
                  items: {
                    type: 'object',
                    properties: {
                      type: {
                        type: 'string',
                        description: 'Formula type (e.g., YES_NO, FORMAT_DATE, UPPER, TRUNCATE, ARRAY_JOIN)'
                      },
                      params: {
                        type: 'object',
                        description: 'Formula parameters (e.g., {"format": "%m/%d/%Y"} for FORMAT_DATE)'
                      }
                    }
                  }
                }
              },
              required: %w[name label]
            }
          },
          filters: {
            type: 'array',
            description: 'Array of filter configurations for the report',
            items: {
              type: 'object',
              properties: {
                column: {
                  type: 'string',
                  description: 'Column path to filter on (e.g., "users.active")'
                },
                label: {
                  type: 'string',
                  description: 'Human-readable label for the filter'
                },
                type: {
                  type: 'string',
                  description: 'Filter class name (e.g., "RadSearch::BooleanFilter", "RadSearch::LikeFilter")'
                }
              },
              required: %w[column label type]
            }
          }
        }
      }.freeze

      def description
        'Creates a new custom report with the specified configuration. ' \
          'This should be called after gathering all necessary information about the report requirements. ' \
          'Supports both regular columns (with "select" field) and calculated columns (with "is_calculated": true). ' \
          'Returns success with report URL or validation errors.'
      end

      def required_params
        %i[name model_name columns]
      end

      def parameters
        PARAM_SCHEMA
      end

      def call
        name = retrieve_argument(:name)
        description = retrieve_argument(:description)
        model_name = retrieve_argument(:model_name)

        config = {
          joins: retrieve_argument(:joins) || [],
          columns: retrieve_argument(:columns) || [],
          filters: retrieve_argument(:filters) || []
        }.compact

        config[:columns].each { |col| apply_default_formula(col, model_name, config[:joins]) }

        configuration = RadReports::ConfigurationBuilder.build(
          { columns: config[:columns], filters: config[:filters], joins: config[:joins] }
        )
        create_report(name, description, model_name, configuration)
      rescue StandardError => e
        "ERROR: An error occurred while creating the report: #{e.message}. " \
        'Please check the configuration and try again.'
      end

      private

        def create_report(name, description, model_name, configuration)
          report = CustomReport.new(
            name: name,
            description: description,
            report_model: model_name,
            configuration: configuration
          )

          if report.save
            report_url = Rails.application.routes.url_helpers.custom_report_path(report)
            "SUCCESS! Custom report '#{name}' has been created successfully. View it at: #{report_url} " \
              "With Report ID #{report.id}"
          else
            errors = report.errors.full_messages.join(', ')
            "VALIDATION_ERROR: The report could not be created due to the following errors: #{errors}. " \
              'Please fix these issues and try again.'
          end
        end

        def apply_default_formula(column, model_name, joins)
          # Skip default formulas for calculated columns or columns that already have formulas
          if column['formula'].present? || column['is_calculated'] || column['select'].blank? || model_name.blank?
            return
          end

          discovery = RadReports::ColumnDiscovery.new(model_name, joins)
          found_col = discovery.all_columns.find { |c| c[:name] == column['name'] }

          return if found_col.blank?

          default_formula = RadReports::FormulaRegistry.default_for_column_type(found_col[:type])
          column['formula'] = default_formula if default_formula
        end
    end
  end
end
