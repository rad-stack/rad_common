require 'rails_helper'

describe RadCommon::AuditsHelper do
  let(:me) { create :user, security_roles: [security_role] }
  let(:division) { create :division }
  let(:user) { create :user }
  let(:security_role) { create :security_role }

  before { allow(controller).to receive(:current_user).and_return(me) }

  describe 'formatted_audited_changes' do
    subject { helper.send(:formatted_audited_changes, audit) }

    before { division.update! notify: true, hourly_rate: 100 }

    let(:audit) { division.audits.reorder('id DESC').first }

    context 'when admin' do
      let(:security_role) { create :security_role, :admin }

      let(:result) do
        "Changed <strong>Notify</strong> to <strong>true</strong>\n" \
          "Changed <strong>Hourly Rate</strong> from <strong>0.0</strong> to <strong>100.0</strong>\n"
      end

      it { is_expected.to eq result }
    end

    context 'when user' do
      let(:result) do
        "Changed <strong>Notify</strong> to <strong>true</strong>\n" \
          "Changed <strong>Hourly Rate</strong> from <strong>XXX</strong> to <strong>XXX</strong>\n"
      end

      it { is_expected.to eq result }
    end
  end

  describe 'display_audited_action' do
    subject { strip_tags(helper.display_audited_action(audit)) }

    let(:audit) { division.own_and_associated_audits.reorder(id: :desc).first }
    let(:file) { Rails.root.join('app/assets/images/app_logo.png').open }

    context 'when associated attachment' do
      context 'when create' do
        before { division.logo.attach(io: file, filename: 'logo.png') }

        it { is_expected.to eq 'create attachment' }
      end

      context 'when destroy' do
        before do
          division.logo.attach(io: file, filename: 'logo.png')
          division.logo.attachment.send(:audit_destroy)
          division.logo.purge
        end

        it { is_expected.to eq 'delete attachment' }
      end
    end

    context 'when create' do
      it { is_expected.to eq 'create' }
    end

    context 'when destroy' do
      before { division.destroy! }

      it { is_expected.to eq 'delete' }
    end
  end

  describe 'display_audited_changes' do
    context 'without associated changes' do
      subject { strip_tags(helper.display_audited_changes(audit)) }

      let(:audit) { division.audits.reorder('created_at DESC').first }

      context 'when create' do
        it { is_expected.to include "Changed Name to #{division.name}" }
      end

      context 'when update' do
        let(:old_name) { Faker::Company.name }
        let(:new_name) { Faker::Company.name }

        before do
          division.update! name: old_name
          division.update! name: new_name
        end

        it { is_expected.to include "Changed Name from #{old_name} to #{new_name}" }
      end

      context 'when destroy' do
        before { division.destroy! }

        it { is_expected.to include 'deleted record' }
      end
    end

    context 'with associated changes' do
      subject { strip_tags(helper.display_audited_changes(audit)) }

      let(:audit) { user.own_and_associated_audits.reorder('created_at DESC').first }

      before { user.update! user_status: UserStatus.default_pending_status }

      context 'when create' do
        before do
          user.update!(security_roles: [])
          user.update!(security_roles: [security_role])
        end

        it { is_expected.to include "Changed Security Role to #{security_role}" }
      end

      context 'when destroy' do
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
      p_2 = 'security_roleee_id'
      expect(helper.send(:classify_foreign_key, p, SecurityRole)).to eq p
      expect(helper.send(:classify_foreign_key, p_2, SecurityRole)).to eq p_2
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
