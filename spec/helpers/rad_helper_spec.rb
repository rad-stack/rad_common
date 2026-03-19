require 'rails_helper'

describe RadHelper do
  let(:me) { create :user }
  let(:date) { Time.current }
  let(:timestamp) { '2018-06-15 06:43 AM' }

  describe '#show_actions?' do
    let(:model_class) { Division }

    context 'when user can update resource' do
      before do
        me.security_roles.update_all update_division: true
        me.reload
        allow(controller).to receive(:current_user).and_return(me)
      end

      it 'returns true' do
        expect(helper.show_actions?(model_class)).to be(true)
      end
    end

    context 'when user can delete resource' do
      before do
        me.security_roles.update_all update_division: false
        me.security_roles.update_all delete_division: true
        me.reload
        allow(controller).to receive(:current_user).and_return(me)
      end

      it 'returns true' do
        expect(helper.show_actions?(model_class)).to be(true)
      end
    end

    context 'when user can neither update or delete resource' do
      before do
        me.security_roles.update_all update_division: false
        me.security_roles.update_all delete_division: false
        me.reload
        allow(controller).to receive(:current_user).and_return(me)
      end

      it 'returns false' do
        expect(helper.show_actions?(model_class)).to be(false)
      end
    end
  end

  describe '#gravatar_for' do
    context 'with string size' do
      let(:size) { '60' }
      let(:resource) { build :user }

      it 'returns a url with the correct size' do
        expect(avatar_image(resource, size)).to include('gravatar')
        expect(avatar_image(resource, size)).to include('60')
      end
    end

    context 'with integer size' do
      let(:size) { 100 }
      let(:resource) { build :user }

      it 'returns a url with the correct size' do
        expect(avatar_image(resource, size)).to include('gravatar')
        expect(avatar_image(resource, size)).to include('100')
      end
    end

    context 'with symbol size' do
      let(:resource) { build :user }

      it 'returns a url with a non string size' do
        expect(avatar_image(resource, :small)).to include('25')
        expect(avatar_image(resource, :medium)).to include('50')
        expect(avatar_image(resource, :large)).to include('200')
      end
    end
  end

  describe '#avatar_image' do
    let(:size) { 80 }
    let(:filename) { 'avatar.png' }

    context 'when user does not have avatar' do
      let(:resource) { build :user, avatar: nil }

      it 'returns an image tag with the user gravatar' do
        expect(avatar_image(resource, size)).to include('gravatar')
      end
    end
  end

  describe '#secured_link' do
    before { allow(controller).to receive(:current_user).and_return(me) }

    context 'with resource' do
      let(:resource) { build :user }

      context 'when user is authorized' do
        before { allow_any_instance_of(UserPolicy).to receive(:show?).and_return(true) }

        it 'renders a link' do
          expect(helper.secured_link(resource)).to include('href')
          expect(helper.secured_link(resource)).to include(resource.id.to_s)
        end

        it 'defaults to no specified format' do
          expect(helper.secured_link(resource)).not_to include('format')
        end

        it 'can specify a pdf format' do
          expect(helper.secured_link(resource, format: 'pdf')).to include('format="pdf"')
        end
      end

      context 'when user is unauthorized' do
        before { allow_any_instance_of(UserPolicy).to receive(:show?).and_return(false) }

        it 'returns the resource name' do
          expect(helper.secured_link(resource)).to eq(resource.to_s)
        end
      end
    end

    context 'without resource' do
      let(:resource) { nil }

      it 'returns nil' do
        expect(helper.secured_link(resource)).to be_nil
      end
    end
  end

  describe 'show_route_exists?' do
    subject { helper.show_route_exists? record }

    context 'when route exists' do
      let(:record) { create :attorney }

      it { is_expected.to be true }
    end

    context "when route doesn't exist" do
      let(:record) { create :saved_search_filter }

      it { is_expected.to be false }
    end

    context "when another route doesn't exist" do
      let(:record) { create :duplicate }

      it { is_expected.to be false }
    end
  end

  describe '#format_date_long' do
    it 'formats' do
      expect(helper.format_date_long(Time.zone.parse(timestamp))).to eq('June 15, 2018')
    end
  end

  describe '#format_time' do
    it 'formats the time' do
      expect(helper.format_time(Time.zone.parse(timestamp))).to eq('6:43am')
    end
  end

  describe '#format_datetime' do
    context 'with nil' do
      it 'returns nil' do
        expect(helper.format_datetime(nil)).to be_nil
      end
    end

    context 'with no options' do
      it 'formats the date' do
        expect(helper.format_datetime(date)).to eq(date.strftime('%-m/%-d/%Y %-l:%M %p'))
      end
    end

    context 'with seconds option' do
      it 'formats the date' do
        expect(helper.format_datetime(date, include_seconds: true)).to eq(date.strftime('%-m/%-d/%Y %-l:%M:%S %p'))
      end
    end

    context 'with zone option' do
      it 'formats the date' do
        result = date.in_time_zone.strftime('%-m/%-d/%Y %-l:%M %p %Z')
        expect(helper.format_datetime(date, include_zone: true)).to eq(result)
      end
    end

    it 'has the proper spacing' do
      date = DateTime.parse('2023-05-29 9:38AM')
      expect(helper.format_datetime(date)).to eq('5/29/2023 9:38 AM')
    end
  end

  describe 'table_row_style' do
    subject { helper.table_row_style record }

    let(:record) { create :attorney, active: active }

    context 'with active record' do
      let(:active) { true }

      it { is_expected.to be_nil }
    end

    context 'with inactive record' do
      let(:active) { false }

      it { is_expected.to eq 'table-danger' }

      context 'with style class' do
        it 'returns the class' do
          expect(helper.table_row_style(record, style_class: 'text-danger')).to eq 'text-danger'
        end
      end
    end
  end
end
