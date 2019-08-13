require 'rails_helper'
require 'csv'

RSpec.describe UsersCsv, type: :service do
  describe '.generate' do
    let(:user) { create :user, external: false, current_sign_in_at: Time.current }
    let(:csv) { described_class.generate([user]) }

    before do
      described_class.headers.each { |heading| expect(csv).to include(heading) }
    end

    it 'generates a CSV' do
      expect(csv).to include(user.to_s)
      expect(csv).to include(user.email)
      expect(csv).to include(ApplicationController.helpers.format_datetime(user.current_sign_in_at))
      expect(csv).to include(ApplicationController.helpers.format_date(user.created_at))
      expect(csv).to include(user.user_status.to_s)
      expect(csv).to include(user.security_roles.map(&:name).join('/'))
      expect(csv).to include('No')
    end
  end
end
