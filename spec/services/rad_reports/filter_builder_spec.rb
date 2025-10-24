require 'rails_helper'

RSpec.describe RadReports::FilterBuilder, type: :service do
  let(:join_builder) { RadReports::JoinBuilder.new(model_class, joins) }
  let(:filter_builder) { described_class.new(model_class, join_builder) }

  describe '#call' do
    subject(:filter_definitions) { filter_builder.call(filters) }

    context 'with no filters' do
      let(:model_class) { Division }
      let(:joins) { nil }
      let(:filters) { [] }

      it 'returns empty array' do
        expect(filter_definitions).to eq []
      end
    end

    context 'with simple column filter' do
      let(:model_class) { Division }
      let(:joins) { nil }
      let(:filters) do
        [{ 'column' => 'name', 'type' => 'RadSearch::SearchFilter' }]
      end

      it 'builds filter definition' do
        expect(filter_definitions.length).to eq 1
        expect(filter_definitions.first[:column]).to eq 'name'
      end
    end

    context 'with association column path' do
      let(:model_class) { Division }
      let(:joins) { ['owner'] }
      let(:filters) do
        [{ 'column' => 'owner.email', 'type' => 'RadSearch::SearchFilter' }]
      end

      it 'converts association path to table path' do
        expect(filter_definitions.first[:column]).to eq 'owner_users.email'
      end
    end

    context 'with nested association column path' do
      let(:model_class) { Division }
      let(:joins) { %w[owner owner.user_status] }
      let(:filters) do
        [{ 'column' => 'owner.user_status.name', 'type' => 'RadSearch::SearchFilter' }]
      end

      it 'converts nested association path to table path' do
        expect(filter_definitions.first[:column]).to eq 'owner_user_status_user_statuses.name'
      end
    end

    context 'with filter type specified' do
      let(:model_class) { Division }
      let(:joins) { nil }
      let(:filters) do
        [{ 'column' => 'created_at', 'type' => 'RadSearch::DateFilter' }]
      end

      it 'constantizes the type' do
        expect(filter_definitions.first[:type]).to eq RadSearch::DateFilter
      end
    end

    context 'with SearchFilter type' do
      let(:model_class) { Division }
      let(:joins) { nil }
      let!(:user_1) { create :user }
      let!(:user_2) { create :user }
      let(:filters) do
        [{ 'column' => 'owner_id', 'type' => 'RadSearch::SearchFilter' }]
      end

      it 'generates options from association' do
        expect(filter_definitions.first[:options]).to be_an(Array)
        expect(filter_definitions.first[:options]).to include(user_1, user_2)
      end
    end

    context 'with label for regular filter' do
      let(:model_class) { Division }
      let(:joins) { nil }
      let(:filters) do
        [{ 'column' => 'name', 'label' => 'Division Name', 'type' => 'RadSearch::SearchFilter' }]
      end

      it 'sets input_label' do
        expect(filter_definitions.first[:input_label]).to eq 'Division Name'
      end
    end

    context 'with label for DateFilter' do
      let(:model_class) { Division }
      let(:joins) { nil }
      let(:filters) do
        [{ 'column' => 'created_at', 'type' => 'RadSearch::DateFilter', 'label' => 'Created' }]
      end

      it 'sets start and end labels' do
        expect(filter_definitions.first[:start_input_label]).to eq 'Created Start'
        expect(filter_definitions.first[:end_input_label]).to eq 'Created End'
      end

      it 'does not set input_label' do
        expect(filter_definitions.first[:input_label]).to be_nil
      end
    end

    context 'with EqualsFilter on integer column' do
      let(:model_class) { Division }
      let(:joins) { nil }
      let(:filters) do
        [{ 'column' => 'divisions.id', 'type' => 'RadSearch::EqualsFilter' }]
      end

      it 'dynamically sets data_type to :integer' do
        expect(filter_definitions.first[:data_type]).to eq :integer
      end
    end

    context 'with EqualsFilter on string column' do
      let(:model_class) { Division }
      let(:joins) { nil }
      let(:filters) do
        [{ 'column' => 'divisions.name', 'type' => 'RadSearch::EqualsFilter' }]
      end

      it 'dynamically sets data_type to :string' do
        expect(filter_definitions.first[:data_type]).to eq :string
      end
    end

    context 'with EnumFilter on base model' do
      let(:model_class) { Division }
      let(:joins) { nil }
      let(:filters) do
        [{ 'column' => 'division_status', 'type' => 'RadSearch::EnumFilter' }]
      end

      it 'sets klass and column' do
        expect(filter_definitions.first[:klass]).to eq Division
        expect(filter_definitions.first[:column]).to eq :division_status
      end
    end

    context 'with EnumFilter on joined model' do
      let(:model_class) { Division }
      let(:joins) { ['owner'] }
      let(:filters) do
        [{ 'column' => 'owner.timezone', 'type' => 'RadSearch::EnumFilter' }]
      end

      it 'cannot find model for aliased table' do
        # Current limitation: EnumFilter doesn't support joined associations
        # because it cannot map aliased table names back to model classes
        expect(filter_definitions.first[:klass]).to be_nil
        expect(filter_definitions.first[:column]).to eq 'owner_users.timezone'
      end
    end

    context 'with multiple filters' do
      let(:model_class) { Division }
      let(:joins) { ['owner'] }
      let(:filters) do
        [
          { 'column' => 'name', 'label' => 'Division Name', 'type' => 'RadSearch::SearchFilter' },
          { 'column' => 'owner.email', 'type' => 'RadSearch::LikeFilter', 'label' => 'Owner Email' },
          { 'column' => 'created_at', 'type' => 'RadSearch::DateFilter', 'label' => 'Created' }
        ]
      end

      it 'builds all filter definitions' do
        expect(filter_definitions.length).to eq 3
      end

      it 'correctly processes first filter' do
        expect(filter_definitions[0][:column]).to eq 'name'
        expect(filter_definitions[0][:input_label]).to eq 'Division Name'
      end

      it 'correctly processes second filter' do
        expect(filter_definitions[1][:column]).to eq 'owner_users.email'
        expect(filter_definitions[1][:type]).to eq RadSearch::LikeFilter
        expect(filter_definitions[1][:input_label]).to eq 'Owner Email'
      end

      it 'correctly processes third filter' do
        expect(filter_definitions[2][:column]).to eq 'created_at'
        expect(filter_definitions[2][:type]).to eq RadSearch::DateFilter
        expect(filter_definitions[2][:start_input_label]).to eq 'Created Start'
        expect(filter_definitions[2][:end_input_label]).to eq 'Created End'
      end
    end

    context 'with filter on non-existent foreign key' do
      let(:model_class) { Division }
      let(:joins) { nil }
      let(:filters) do
        [{ 'column' => 'nonexistent_id', 'type' => 'RadSearch::SearchFilter' }]
      end

      it 'returns empty options' do
        expect(filter_definitions.first[:options]).to eq []
      end
    end

    context 'with complete filter configuration' do
      let(:model_class) { Division }
      let(:joins) { %w[owner category] }
      let!(:category) { create :category }
      let(:filters) do
        [
          {
            'column' => 'owner.email',
            'type' => 'RadSearch::LikeFilter',
            'label' => 'Owner Email'
          },
          {
            'column' => 'category_id',
            'label' => 'Category',
            'type' => 'RadSearch::SearchFilter'
          },
          {
            'column' => 'created_at',
            'type' => 'RadSearch::DateFilter',
            'label' => 'Created Date'
          },
          {
            'column' => 'division_status',
            'type' => 'RadSearch::EnumFilter'
          },
          {
            'column' => 'divisions.id',
            'type' => 'RadSearch::EqualsFilter'
          }
        ]
      end

      it 'builds all filters correctly' do
        expect(filter_definitions.length).to eq 5

        expect(filter_definitions[0][:column]).to eq 'owner_users.email'
        expect(filter_definitions[0][:type]).to eq RadSearch::LikeFilter
        expect(filter_definitions[0][:input_label]).to eq 'Owner Email'

        expect(filter_definitions[1][:column]).to eq 'category_id'
        expect(filter_definitions[1][:input_label]).to eq 'Category'
        expect(filter_definitions[1][:options]).to include(category)

        expect(filter_definitions[2][:column]).to eq 'created_at'
        expect(filter_definitions[2][:type]).to eq RadSearch::DateFilter
        expect(filter_definitions[2][:start_input_label]).to eq 'Created Date Start'
        expect(filter_definitions[2][:end_input_label]).to eq 'Created Date End'

        expect(filter_definitions[3][:column]).to eq :division_status
        expect(filter_definitions[3][:klass]).to eq Division
        expect(filter_definitions[3][:type]).to eq RadSearch::EnumFilter

        expect(filter_definitions[4][:column]).to eq 'divisions.id'
        expect(filter_definitions[4][:type]).to eq RadSearch::EqualsFilter
        expect(filter_definitions[4][:data_type]).to eq :integer
      end
    end
  end
end
