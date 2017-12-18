require 'rails_helper'

describe RadbearRails::ApplicationHelper do
  let(:date) { DateTime.current }

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
