module LLM
  module Tools
    class GenerateReportConfiguration < Base
      def description
        'Creates a new custom report with the specified configuration. ' \
          'This should be called after gathering all necessary information about the report requirements. ' \
          'Returns success with report URL or validation errors.'
      end

      def required_params
        %i[name model_name columns]
      end

      def parameters
        {
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
                    description: 'The full select path (e.g., "users.name" or "division.name")'
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
                    description: 'Filter class name (e.g., "RadSearch::BooleanFilter", "RadSearch::DateRangeFilter", "RadSearch::TextFilter")'
                  },
                  data_type: {
                    type: 'string',
                    description: 'Data type of the column (e.g., "boolean", "date", "string", "integer")'
                  }
                },
                required: %w[column label type]
              }
            }
          }
        }
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

        config[:columns].each do |col|
          next if col['formula'].present?

          column_name = col['name']
          select_path = col['select']
          next unless select_path && model_name

          discovery = RadReports::ColumnDiscovery.new(model_name, config[:joins])
          found_col = discovery.all_columns.find { |c| c[:name] == column_name }

          if found_col
            default_formula = RadReports::FormulaRegistry.default_for_column_type(found_col[:type])
            col['formula'] = default_formula if default_formula
          end
        end

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
            "SUCCESS! Custom report '#{name}' has been created successfully. View it at: #{report_url}"
          else
            errors = report.errors.full_messages.join(', ')
            "VALIDATION_ERROR: The report could not be created due to the following errors: #{errors}. " \
              'Please fix these issues and try again.'
          end
        end
    end
  end
end
