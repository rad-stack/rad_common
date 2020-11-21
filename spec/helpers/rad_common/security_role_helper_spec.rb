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

    context 'with tooltip' do
      let(:permission) { 'admin' }

      it { is_expected.to eq 'Ability to do everything in the system.' }
    end

    context 'without tooltip' do
      let(:permission) { 'read_user' }

      it { is_expected.to be_blank }
    end
  end

  describe '#humanized_permission_fields' do
    it 'returns human-readable permission fields' do
      expect(helper.humanized_permission_fields).to eq(
        [
          { label: 'Administration', permission: 'admin' },
          { label: 'Create Divisions', permission: 'create_division' },
          { label: 'Delete Divisions', permission: 'delete_division' },
          { label: 'View Divisions', permission: 'read_division' },
          { label: 'View Users', permission: 'read_user' },
          { label: 'Update Divisions', permission: 'update_division' }
        ]
      )
    end
  end

  describe '#normalize_names' do
    it 'formats "Update" to "Edit"' do
      expect(security_fields).to include(update)
      formatted_hash = normalize_names(security_fields)
      expect(formatted_hash).to include(edit_formatted)
      expect(formatted_hash).not_to include(update)
    end

    it 'formats "Manage" to "Manage (View, Edit, Create, Delete)"' do
      expect(security_fields).not_to include(manage_formatted)
      expect(security_fields).to include(manage)
      formatted_hash = normalize_names(security_fields)
      expect(formatted_hash).to include(manage_formatted)
    end

    it 'does format but does not change unspecified fields' do
      formatted_hash = normalize_names(test_hash)
      expect(formatted_hash).to include(test_hash_formatted)
    end
  end
end
