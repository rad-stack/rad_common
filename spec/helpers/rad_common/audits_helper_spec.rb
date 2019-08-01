require 'rails_helper'

describe RadCommon::AuditsHelper do
  let(:division) { create :division }
  let(:user) { create :user }
  let(:security_role) { create :security_role }

  before do
    @user = create :user, security_roles: [security_role]

    def helper.current_user
      @user
    end
  end

  describe 'audit_models_to_search' do
    subject { helper.audit_models_to_search }

    let(:result) do
      %w[Company Division NotificationSecurityRole NotificationSetting SecurityRole SecurityRolesUser Status User]
    end

    it { is_expected.to eq result }
  end

  describe 'formatted_audited_changes' do
    subject { helper.send(:formatted_audited_changes, audit) }
    before { division.update! notify: true, hourly_rate: 100 }
    let(:audit) { division.audits.reorder('id DESC').first }

    context 'admin' do
      let(:security_role) { create :security_role, :admin }

      let(:result) do
        "Changed <strong>Notify</strong> to <strong>true</strong>\n"\
        "Changed <strong>Hourly Rate</strong> from <strong>0.0</strong> to <strong>100.0</strong>\n"
      end

      it { is_expected.to eq result }
    end

    context 'user' do
      let(:result) do
        "Changed <strong>Notify</strong> to <strong>true</strong>\n"\
        "Changed <strong>Hourly Rate</strong> from <strong>XXX</strong> to <strong>XXX</strong>\n"
      end

      it { is_expected.to eq result }
    end
  end

  describe 'display_audited_changes' do
    context 'without associated changes' do
      subject { strip_tags(helper.display_audited_changes(audit)) }

      let(:audit) { division.audits.reorder('created_at DESC').first }

      context 'create' do
        it { is_expected.to include "Changed Name to #{division.name}" }
      end

      context 'update' do
        let(:old_name) { Faker::Company.name }
        let(:new_name) { Faker::Company.name }

        before do
          division.update! name: old_name
          division.update! name: new_name
        end

        it { is_expected.to include "Changed Name from #{old_name} to #{new_name}" }
      end

      context 'destroy' do
        before { division.destroy! }

        it { is_expected.to include 'deleted record' }
      end
    end

    context 'with associated changes' do
      subject { strip_tags(helper.display_audited_changes(audit)) }

      let(:audit) { user.own_and_associated_audits.reorder('created_at DESC').first }

      context 'create' do
        before do
          user.update!(security_roles: [])
          user.update!(security_roles: [security_role])
        end

        it { is_expected.to include "Changed Security Role to #{security_role}" }
      end

      context 'destroy' do
        before do
          user.update!(security_roles: [])
          user.update!(security_roles: [security_role])
          user.update!(security_roles: [])
        end

        it { is_expected.to include "Deleted Security Role #{security_role}" }
      end
    end
  end

  describe '#classify_foreign_key' do
    it 'returns class name' do
      p = 'security_role_id'
      expect(helper.send(:classify_foreign_key, p, SecurityRole)).to eq SecurityRole
    end

    it 'returns original value if no class is found' do
      p = 'security_roleee'
      p2 = 'security_roleee_id'
      expect(helper.send(:classify_foreign_key, p, SecurityRole)).to eq p
      expect(helper.send(:classify_foreign_key, p2, SecurityRole)).to eq p2
    end

    it 'returns original value of there is no _id at end of string' do
      p = 'security_role'
      expect(helper.send(:classify_foreign_key, p, SecurityRole)).to eq p
    end

    it 'works for other classes' do
      u = 'user_id'
      o = 'security_role_id'
      division = 'division_id'

      expect(helper.send(:classify_foreign_key, u, User)).to eq User
      expect(helper.send(:classify_foreign_key, o, SecurityRole)).to eq SecurityRole
      expect(helper.send(:classify_foreign_key, division, Division)).to eq Division
    end

    it 'works for special relationships' do
      o = 'owner_id'

      expect(helper.send(:classify_foreign_key, o, Division)).to eq User
    end
  end
end
