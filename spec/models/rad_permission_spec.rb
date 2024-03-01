require 'rails_helper'

RSpec.describe RadPermission do
  let(:user) { create :admin }

  describe 'label' do
    subject { described_class.new(permission).label }

    let(:permission) { 'read_division' }

    it { is_expected.to eq 'Read Division' }
  end

  describe 'user_categories' do
    subject { described_class.user_categories(user).map(&:first) }

    let(:result) { %w[Admin Division User] }

    it { is_expected.to eq result }
  end

  describe 'short_label' do
    subject { described_class.new(permission).short_label('Division') }

    let(:permission) { 'read_division' }

    it { is_expected.to eq 'Read' }
  end

  describe 'tooltip' do
    subject { described_class.new(permission).tooltip }

    context 'with defined tooltip' do
      let(:permission) { 'admin' }

      it { is_expected.to eq 'Ability to do everything in the system.' }
    end

    context 'with default create tooltip' do
      let(:permission) { 'create_division' }

      it { is_expected.to eq 'Create new divisions' }
    end

    context 'with default read tooltip' do
      let(:permission) { 'read_division' }

      it { is_expected.to eq 'Read divisions' }
    end

    context 'with default update tooltip' do
      let(:permission) { 'update_division' }

      it { is_expected.to eq 'Update existing divisions' }
    end

    context 'with default edit tooltip' do
      let(:permission) { 'edit_division' }

      it { is_expected.to eq 'Update existing divisions' }
    end

    context 'with default destroy tooltip' do
      let(:permission) { 'destroy_division' }

      it { is_expected.to eq 'Delete divisions' }
    end

    context 'with default delete tooltip' do
      let(:permission) { 'delete_division' }

      it { is_expected.to eq 'Delete divisions' }
    end

    context 'with default manage tooltip' do
      let(:permission) { 'manage_division' }

      it { is_expected.to eq 'Manage (read/create/update/delete) divisions' }
    end

    context 'with default non-crud tooltip' do
      let(:permission) { 'foo_division' }

      it { is_expected.to be_blank }
    end
  end
end
