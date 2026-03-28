require 'rails_helper'

RSpec.describe LLM::Tools::Base do
  let(:test_tool_class) do
    Class.new(described_class) do
      def description
        'A test tool'
      end

      def parameters
        {
          type: 'object',
          properties: {
            **self.class.id_parameter(:user),
            **self.class.id_parameter(:project, description: 'Custom project description')
          }
        }
      end
    end
  end

  describe '#positive_id' do
    subject(:tool) { test_tool_class.new(params: { arguments: arguments }) }

    context 'with a positive integer' do
      let(:arguments) { { user_id: 123 } }

      it 'returns the value' do
        expect(tool.positive_id(:user_id)).to eq(123)
      end
    end

    context 'with zero' do
      let(:arguments) { { user_id: 0 } }

      it 'returns nil' do
        expect(tool.positive_id(:user_id)).to be_nil
      end
    end

    context 'with a negative number' do
      let(:arguments) { { user_id: -1 } }

      it 'returns nil' do
        expect(tool.positive_id(:user_id)).to be_nil
      end
    end

    context 'with nil' do
      let(:arguments) { { user_id: nil } }

      it 'returns nil' do
        expect(tool.positive_id(:user_id)).to be_nil
      end
    end

    context 'with a string number' do
      let(:arguments) { { user_id: '42' } }

      it 'converts and returns the value' do
        expect(tool.positive_id(:user_id)).to eq(42)
      end
    end

    context 'with missing parameter' do
      let(:arguments) { {} }

      it 'returns nil' do
        expect(tool.positive_id(:user_id)).to be_nil
      end
    end
  end

  describe '.id_parameter' do
    it 'generates parameter schema with default description' do
      result = described_class.id_parameter(:user)

      expect(result).to eq(
        user_id: {
          type: 'integer',
          description: 'The user ID (from mentioned entities if available)'
        }
      )
    end

    it 'generates parameter schema with custom description' do
      result = described_class.id_parameter(:project, description: 'Filter by project')

      expect(result).to eq(
        project_id: {
          type: 'integer',
          description: 'Filter by project'
        }
      )
    end

    it 'can be merged into properties hash' do
      tool = test_tool_class.new(params: {})
      properties = tool.parameters[:properties]

      expect(properties).to include(:user_id, :project_id)
      expect(properties[:user_id][:type]).to eq('integer')
      expect(properties[:project_id][:description]).to eq('Custom project description')
    end
  end
end
