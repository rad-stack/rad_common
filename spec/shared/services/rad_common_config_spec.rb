require 'rails_helper'
require 'json_schemer'

RSpec.describe 'config/rad_common.yml' do
  let(:config_path) { Rails.root.join('config/rad_common.yml') }

  let(:schema_path) do
    app_schema = Rails.root.join('config/rad_common.schema.json')
    return app_schema if File.exist?(app_schema)

    Pathname.new(Gem.loaded_specs['rad_common'].full_gem_path)
            .join('lib/application_template/rad_common.schema.json')
  end

  let(:schema) do
    JSONSchemer.schema(File.read(schema_path),
                       meta_schema: 'https://json-schema.org/draft/2020-12/schema')
  end

  it 'validates against rad_common.schema.json' do
    raw = YAML.load_file(config_path, aliases: true, permitted_classes: [Symbol])
    data = JSON.parse(raw.to_json)
    errors = schema.validate(data).to_a

    messages = errors.map do |e|
      "  #{e['data_pointer']} (#{e['type']}): #{e['data'].inspect[0..120]}"
    end

    expect(errors).to be_empty,
                      "config/rad_common.yml has #{errors.size} schema violation(s) " \
                      "against #{schema_path}:\n#{messages.join("\n")}"
  end
end
