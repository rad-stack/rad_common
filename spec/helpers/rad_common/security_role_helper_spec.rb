require 'rails_helper'

describe RadCommon::SecurityRoleHelper do
  let(:security_fields) do
    [{ label: 'Update Notes', permission: 'update_note' },
     { label: 'Manage Role Assignments', permission: 'manage_role_assignment' }]
  end

  let(:update) { { label: 'Update Notes', permission: 'update_note' } }
  let(:manage) { { label: 'Manage Role Assignments', permission: 'manage_role_assignment' } }
  let(:test_hash) { [{ label: 'Test', permission: 'test' }, { label: 'Test2', permission: 'test_2' }] }
  let(:edit_formatted) { ['Edit Notes', 'update_note'] }
  let(:manage_formatted) { ['Manage (View, Edit, Create, Delete) Role Assignments', 'manage_role_assignment'] }
  let(:test_hash_formatted) { %w[Test test] }

  describe '#permission_tooltip' do
    subject { helper.permission_tooltip(permission) }

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

      it { is_expected.to eq 'Manage (create/read/update/delete) divisions' }
    end

    context 'with default non-crud tooltip' do
      let(:permission) { 'foo_division' }

      it { is_expected.to be_blank }
    end
  end

  describe '#humanized_permission_fields' do
    it 'returns human-readable permission fields' do
      expect(helper.humanized_permission_fields).to eq(
        [{ label: 'Admin', permission: 'admin' },
         { label: 'Create Division', permission: 'create_division' },
         { label: 'Delete Division', permission: 'delete_division' },
         { label: 'Read Division', permission: 'read_division' },
         { label: 'Update Division', permission: 'update_division' }]
      )
    end
  end

  describe '#normalize_names' do
    it 'does format but does not change unspecified fields' do
      formatted_hash = normalize_names(test_hash)
      expect(formatted_hash).to include(test_hash_formatted)
    end
  end
end
