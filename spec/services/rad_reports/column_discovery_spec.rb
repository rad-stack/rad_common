require 'rails_helper'

RSpec.describe RadReports::ColumnDiscovery, type: :service do
  let(:discovery) { described_class.new(model_name, joins) }

  describe '#initialize' do
    subject(:discovery) { described_class.new('User', ['divisions']) }

    it 'sets model_name' do
      expect(discovery.model_name).to eq 'User'
    end

    it 'sets joins' do
      expect(discovery.joins).to eq ['divisions']
    end
  end

  describe '#all_columns' do
    subject(:columns) { discovery.all_columns }

    context 'with blank model name' do
      let(:model_name) { nil }
      let(:joins) { nil }

      it 'returns empty array' do
        expect(columns).to eq []
      end
    end

    context 'with empty model name' do
      let(:model_name) { '' }
      let(:joins) { nil }

      it 'returns empty array' do
        expect(columns).to eq []
      end
    end

    context 'with invalid model name' do
      let(:model_name) { 'NonExistentModel' }
      let(:joins) { nil }

      it 'returns empty array' do
        expect(columns).to eq []
      end
    end

    context 'with valid model without joins' do
      let(:model_name) { 'Division' }
      let(:joins) { [] }

      it 'returns array of column definitions' do
        expect(columns).to be_an(Array)
        expect(columns).not_to be_empty
      end

      it 'includes regular database columns' do
        column_names = columns.map { |c| c[:name] }
        expect(column_names).to include('id', 'name', 'owner_id')
      end

      it 'includes correct column types' do
        id_column = columns.find { |c| c[:name] == 'id' }
        expect(id_column[:type]).to eq :integer

        name_column = columns.find { |c| c[:name] == 'name' }
        expect(name_column[:type]).to eq :string
      end

      it 'includes table information' do
        column = columns.first
        expect(column[:table]).to eq 'divisions'
        expect(column[:table_label]).to eq 'Division'
      end

      it 'does not include association information for base model' do
        column = columns.first
        expect(column[:association]).to be_nil
        expect(column[:association_label]).to be_nil
      end

      it 'marks foreign key columns' do
        owner_id_column = columns.find { |c| c[:name] == 'owner_id' }
        expect(owner_id_column[:is_foreign_key]).to be true
      end

      it 'marks enum columns' do
        status_column = columns.find { |c| c[:name] == 'division_status' }
        expect(status_column[:is_enum]).to be true
      end

      it 'includes attachment columns' do
        column_names = columns.map { |c| c[:name] }
        expect(column_names).to include('logo', 'icon')

        logo_column = columns.find { |c| c[:name] == 'logo' }
        expect(logo_column[:type]).to eq :attachment
      end
    end

    context 'with model that has rich text' do
      let(:model_name) { 'Attorney' }
      let(:joins) { [] }

      it 'includes rich text columns' do
        column_names = columns.map { |c| c[:name] }
        expect(column_names).to include('notes')

        notes_column = columns.find { |c| c[:name] == 'notes' }
        expect(notes_column[:type]).to eq :rich_text
      end
    end

    context 'with single level join' do
      let(:model_name) { 'Division' }
      let(:joins) { ['owner'] }

      it 'includes base model columns' do
        column_names = columns.map { |c| c[:name] }
        expect(column_names).to include('id', 'name')
      end

      it 'includes joined model columns' do
        column_names = columns.map { |c| c[:name] }
        expect(column_names).to include('email', 'first_name', 'last_name')
      end

      it 'marks joined columns with association information' do
        email_column = columns.find { |c| c[:name] == 'email' && c[:association].present? }
        expect(email_column).not_to be_nil
        expect(email_column[:association]).to eq 'owner'
        expect(email_column[:association_label]).to eq 'Owner'
        expect(email_column[:table]).to eq 'users'
        expect(email_column[:table_label]).to eq 'User'
      end
    end

    context 'with nested joins' do
      let(:model_name) { 'Division' }
      let(:joins) { ['owner.user_status'] }

      it 'includes nested association columns' do
        column_names = columns.map { |c| c[:name] }
        expect(column_names).to include('name')

        status_name_column = columns.find do |c|
          c[:name] == 'name' && c[:association] == 'owner.user_status'
        end

        expect(status_name_column).not_to be_nil
        expect(status_name_column[:association_label]).to eq 'Owner → User Status'
        expect(status_name_column[:table]).to eq 'user_statuses'
      end
    end

    context 'with multiple joins' do
      let(:model_name) { 'Division' }
      let(:joins) { %w[owner category] }

      it 'includes columns from all joins' do
        column_names = columns.map { |c| c[:name] }

        # Base model
        base_name = columns.find { |c| c[:name] == 'name' && c[:association].nil? }
        expect(base_name).not_to be_nil

        # Owner (User) columns
        expect(column_names).to include('email')

        # Category columns - check for category_id in base or name in category
        category_name = columns.find { |c| c[:name] == 'name' && c[:association] == 'category' }
        expect(category_name).not_to be_nil
      end

      it 'properly attributes columns to their associations' do
        email_column = columns.find { |c| c[:name] == 'email' && c[:association] == 'owner' }
        expect(email_column).not_to be_nil

        category_name_column = columns.find { |c| c[:name] == 'name' && c[:association] == 'category' }
        expect(category_name_column).not_to be_nil
      end
    end

    context 'with array column type' do
      let(:model_name) { 'Division' }
      let(:joins) { [] }

      it 'identifies array columns' do
        tags_column = columns.find { |c| c[:name] == 'tags' }
        expect(tags_column[:type]).to eq 'array'
      end
    end

    context 'with excluded columns' do
      let(:model_name) { 'User' }
      let(:joins) { [] }

      it 'excludes default sensitive columns' do
        column_names = columns.map { |c| c[:name] }
        expect(column_names).not_to include('encrypted_password')
        expect(column_names).not_to include('reset_password_token')
        expect(column_names).not_to include('otp_secret')
      end
    end

    context 'with global column exclusions' do
      let(:model_name) { 'User' }
      let(:joins) { [] }

      before do
        allow(RadConfig).to receive(:custom_reports_config).and_return(
          excluded_columns: %w[email phone]
        )
      end

      it 'excludes globally configured columns' do
        column_names = columns.map { |c| c[:name] }
        expect(column_names).not_to include('email')
        expect(column_names).not_to include('phone')
      end
    end

    context 'with model-specific column exclusions' do
      let(:model_name) { 'User' }
      let(:joins) { [] }

      before do
        allow(RadConfig).to receive(:custom_reports_config).and_return(
          model_column_exclusions: {
            'User' => %w[mobile_phone office_phone]
          }
        )
      end

      it 'excludes model-specific columns' do
        column_names = columns.map { |c| c[:name] }
        expect(column_names).not_to include('mobile_phone')
        expect(column_names).not_to include('office_phone')
      end
    end

    context 'with invalid join path' do
      let(:model_name) { 'Division' }
      let(:joins) { ['nonexistent_association'] }

      it 'includes base model columns' do
        column_names = columns.map { |c| c[:name] }
        expect(column_names).to include('name')
      end

      it 'does not fail on invalid join' do
        expect { columns }.not_to raise_error
      end
    end
  end

  describe '#columns_by_table' do
    subject(:grouped_columns) { discovery.columns_by_table }

    context 'with single model' do
      let(:model_name) { 'Division' }
      let(:joins) { [] }

      it 'returns hash grouped by table information' do
        expect(grouped_columns).to be_a(Hash)
        expect(grouped_columns.keys.first).to be_a(Hash)
      end

      it 'groups all base columns under same key' do
        expect(grouped_columns.keys.length).to be >= 1

        base_key = grouped_columns.keys.find { |k| k[:table] == 'divisions' }
        expect(base_key).not_to be_nil
        expect(grouped_columns[base_key]).to be_an(Array)
        expect(grouped_columns[base_key].length).to be > 1
      end

      it 'includes correct table metadata' do
        base_key = grouped_columns.keys.find { |k| k[:table] == 'divisions' }
        expect(base_key[:table]).to eq 'divisions'
        expect(base_key[:label]).to eq 'Division'
        expect(base_key[:class_label]).to eq 'Division'
        expect(base_key[:association]).to be_nil
      end
    end

    context 'with joins' do
      let(:model_name) { 'Division' }
      let(:joins) { %w[owner category] }

      it 'groups columns by their table and association' do
        expect(grouped_columns.keys.length).to be >= 3

        division_key = grouped_columns.keys.find { |k| k[:table] == 'divisions' }
        expect(division_key).not_to be_nil

        users_key = grouped_columns.keys.find { |k| k[:table] == 'users' }
        expect(users_key).not_to be_nil

        categories_key = grouped_columns.keys.find { |k| k[:table] == 'categories' }
        expect(categories_key).not_to be_nil
      end

      it 'includes association label for joined tables' do
        users_key = grouped_columns.keys.find { |k| k[:table] == 'users' }
        expect(users_key[:label]).to eq 'Owner'
        expect(users_key[:association]).to eq 'owner'

        categories_key = grouped_columns.keys.find { |k| k[:table] == 'categories' }
        expect(categories_key[:label]).to eq 'Category'
        expect(categories_key[:association]).to eq 'category'
      end

      it 'includes correct columns for each table' do
        division_key = grouped_columns.keys.find { |k| k[:table] == 'divisions' }
        division_columns = grouped_columns[division_key]
        division_column_names = division_columns.map { |c| c[:name] }
        expect(division_column_names).to include('name')

        users_key = grouped_columns.keys.find { |k| k[:table] == 'users' }
        user_columns = grouped_columns[users_key]
        user_column_names = user_columns.map { |c| c[:name] }
        expect(user_column_names).to include('email')
      end
    end

    context 'with nested joins' do
      let(:model_name) { 'Division' }
      let(:joins) { ['owner.user_status'] }

      it 'uses association label for nested joins' do
        status_key = grouped_columns.keys.find { |k| k[:table] == 'user_statuses' }
        expect(status_key).not_to be_nil
        expect(status_key[:label]).to eq 'Owner → User Status'
        expect(status_key[:association]).to eq 'owner.user_status'
      end
    end

    context 'with blank model' do
      let(:model_name) { nil }
      let(:joins) { nil }

      it 'returns empty hash' do
        expect(grouped_columns).to eq({})
      end
    end
  end

  describe '#column_exists?' do
    let(:model_name) { 'Division' }
    let(:joins) { ['owner'] }
    subject(:column_exists) { discovery.column_exists?(column_reference) }

    context 'with blank column reference' do
      let(:column_reference) { nil }

      it 'returns false' do
        expect(column_exists).to be false
      end
    end

    context 'with empty column reference' do
      let(:column_reference) { '' }

      it 'returns false' do
        expect(column_exists).to be false
      end
    end

    context 'with valid base model column' do
      let(:column_reference) { 'name' }

      it 'returns true' do
        expect(column_exists).to be true
      end
    end

    context 'with valid joined column' do
      let(:column_reference) { 'owner.email' }

      it 'returns true' do
        expect(column_exists).to be true
      end
    end

    context 'with invalid column name' do
      let(:column_reference) { 'nonexistent_column' }

      it 'returns false' do
        expect(column_exists).to be false
      end
    end

    context 'with invalid association' do
      let(:column_reference) { 'nonexistent_association.name' }

      it 'returns false' do
        expect(column_exists).to be false
      end
    end

    context 'with valid column but wrong association' do
      let(:column_reference) { 'owner.nonexistent_column' }

      it 'returns false' do
        expect(column_exists).to be false
      end
    end

    context 'with nested joins' do
      let(:joins) { ['owner.user_status'] }
      let(:column_reference) { 'owner.user_status.name' }

      it 'returns true for nested association columns' do
        expect(column_exists).to be true
      end
    end

    context 'with table name instead of association' do
      let(:column_reference) { 'users.email' }

      it 'returns true when referencing by table name' do
        expect(column_exists).to be true
      end
    end
  end
end
