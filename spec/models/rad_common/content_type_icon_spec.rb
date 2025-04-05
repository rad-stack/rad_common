require 'rails_helper'

RSpec.describe RadCommon::ContentTypeIcon do
  describe '#icon' do
    subject { described_class.new(content_type).icon }

    context 'when content is a known type' do
      let(:content_type) { 'application/msword' }

      it { is_expected.to eq('fa-file-word') }
    end

    context 'when content is not a known type' do
      let(:content_type) { 'application' }

      it { is_expected.to eq('fa-paperclip') }
    end
  end
end
