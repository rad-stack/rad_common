require 'rails_helper'

RSpec.describe 'Schema standards' do
  it 'enforces boolean, jsonb, and array column standards' do
    violations = []

    ActiveRecord::Base.connection.tables.each do |table|
      ActiveRecord::Base.connection.columns(table).each do |column|
        next unless invalid_boolean_schema?(column) || invalid_jsonb_schema?(column) ||
                    invalid_array_schema?(column)

        violations << "#{table}.#{column.name}: type: #{column.type}, null: #{column.null}, default: #{column.default}"
      end
    end

    expect(violations).to be_empty, "schema standards violations:\n#{violations.join("\n")}"
  end

  def invalid_boolean_schema?(column)
    return false if column.array?
    return false unless column.type == :boolean

    column.null || column.default.blank?
  end

  def invalid_jsonb_schema?(column)
    return false unless column.type == :jsonb

    column.null || column.default.nil?
  end

  def invalid_array_schema?(column)
    return false unless column.array?

    column.null || column.default.nil?
  end
end
