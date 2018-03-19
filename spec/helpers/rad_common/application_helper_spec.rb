require 'rails_helper'

describe RadCommon::ApplicationHelper do
  let(:date) { DateTime.current }

  before do
    @user = create :user

    def helper.current_member
      @user
    end
  end

  describe '#gravatar_for' do
    context 'string size' do
      let(:size) { '60' }
      let(:resource) { build(:user) }
      it 'returns a url with the correct size' do
        expect(avatar_image(resource, size)).to include('gravatar')
        expect(avatar_image(resource, size)).to include('60')
      end
    end

    context 'integer size' do
      let(:size) { 100 }
      let(:resource) { build(:user) }
      it 'returns a url with the correct size' do
        expect(avatar_image(resource, size)).to include('gravatar')
        expect(avatar_image(resource, size)).to include('100')
      end
    end

    context 'symbol size' do
      let(:resource) { build(:user) }
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
    before { Rails.application.config.use_avatar = true }
    after  { Rails.application.config.use_avatar = false }

    context "user has avatar" do
      let(:resource) do
        build(:user, avatar: fixture_file_upload(Rails.root.join('spec', 'fixtures', filename)))
      end
      xit 'should return the Amazon stored image' do
        # TODO doesn't work locally
        response = avatar_image(resource, size)
        expect(response).to include("<img")
        expect(response).to include(".png")
        expect(response).to_not include('gravatar')
      end

      xit 'returns a 50px image' do
        #todo this just stopped working, need to debug
        response = avatar_image(resource, size)
        expect(avatar_image(resource, size)).to include("50")
      end
    end

    context "user does not have avatar" do
      let(:resource) { build(:user, avatar: nil) }
      it "should return an image tag with the user gravatar" do
        expect(avatar_image(resource, size)).to include('gravatar')
      end
    end
  end

  describe '#secured_link' do
    context 'resource' do
      let(:resource) { build(:user) }

      context 'member is authorized' do
        before { allow(@user).to receive(:can_read?).and_return(true) }

        it 'renders a link' do
          expect(helper.secured_link(resource)).to include('href')
          expect(helper.secured_link(resource)).to include("#{resource.id}")
        end

        it 'defaults to no specified format' do
          expect(helper.secured_link(resource)).to_not include("format")
        end

        it 'can specify a pdf format' do
          expect(helper.secured_link(resource, format: 'pdf')).to include("format=\"pdf\"")
        end
      end

      context 'member is unauthorized' do
        before { expect(@user).to receive(:can_read?).and_return(false) }

        it 'returns the resource name' do
          expect(helper.secured_link(resource)).to eq(resource.to_s)
        end
      end
    end

    context 'no resource' do
      let(:resource) { nil }
      it 'returns nil' do
        expect(helper.secured_link(resource)).to be_nil
      end
    end
  end

  describe '#format_datetime' do
    context 'with nil' do
      it 'returns nil' do
        expect(helper.format_datetime(nil)).to eq(nil)
      end
    end

    context 'with no options' do
      it 'formats the date' do
        expect(helper.format_datetime(date)).to eq(date.strftime('%-m/%-d/%Y %l:%M %p'))
      end
    end

    context 'with seconds option' do
      it 'formats the date' do
        expect(helper.format_datetime(date, { include_seconds: true })).to eq(date.strftime('%-m/%-d/%Y %l:%M:%S %p'))
      end
    end

    context 'with zone option' do
      it 'formats the date' do
        expect(helper.format_datetime(date, { include_zone: true })).to eq(date.in_time_zone.strftime('%-m/%-d/%Y %l:%M %p %Z'))
      end
    end
  end

  describe "#classify_foreign_key" do
    it "returns class name" do
      p = "security_group_id"
      expect(helper.classify_foreign_key(p, SecurityGroup)).to eq SecurityGroup
    end

    it "returns original value if no class is found" do
      p = "security_grouppp"
      p2 = "security_groupppp_id"
      expect(helper.classify_foreign_key(p, SecurityGroup)).to eq p
      expect(helper.classify_foreign_key(p2, SecurityGroup)).to eq p2
    end

    it "returns original value of there is no _id at end of string" do
      p = "security_group"
      expect(helper.classify_foreign_key(p, SecurityGroup)).to eq p
    end

    it "works for other classes" do
      u = "user_id"
      o = "security_group_id"
      division = "division_id"

      expect(helper.classify_foreign_key(u, User)).to eq User
      expect(helper.classify_foreign_key(o, SecurityGroup)).to eq SecurityGroup
      expect(helper.classify_foreign_key(division, Division)).to eq Division
    end

    it "works for special relationships" do
      o = "owner_id"

      expect(helper.classify_foreign_key(o, Division)).to eq User
    end
  end
end
