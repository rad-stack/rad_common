require 'rails_helper'

describe User, type: :model do
  let(:user) { create :user }
  let(:app) { FirebaseApp.new }

  describe '#firebase_device_tokens', :vcr do
    subject { user.firebase_device_tokens(app) }

    let(:tokens) do
      %w[eKUEUPDWW3I:APA91bHdhnsF7bGr8BOz3NcFWJrr1nBrjJDa1Uz-GWmrBC0_YD63asWukwmTn3LBKtZS7stiluDybaBgV4bH0M_AuizdWztyeMeVrrCeNlcPEnkXKln5sjolgH1WOtB6NBpQTc3hR_9F
         dQUulxDx3sk:APA91bGO1YR0b95FMCeIh2FamYYGJyR7LymRziH7Kq9i2GubkOicRcWAuposSVOUi7ZJlRxEwzi6aoK9kUnWUAUEmtJ9svs0WyTyUnjViTtTNoBS6yQZjebeo-ZP-dfr69-OELLBCvxc
         cy2w20Xdg60:APA91bFdlYH0yzzYVmhXl1yp58KM_547ce_hXtEUtURh9CwHHDLynqVjff082bmzO56nsJ5Isz0RmYws6IVOs2VP94DZwrXC5knzKHPkgHP8r5diEqyFmJWnweFanRf5xk0iORnzjIzb]
    end

    before { allow_any_instance_of(described_class).to receive(:firebase_reference).and_return('users/id5') }

    it { is_expected.to eq tokens }
  end
end
