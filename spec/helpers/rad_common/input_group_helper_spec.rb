require 'rails_helper'

describe RadCommon::InputGroupHelper do
  let(:html_tag) { 'span' }
  let(:title) { 'Test' }

  describe '#addon' do
    it 'correctly formats to an addon span' do
      append = addon(title)
      expect(append).to include('span')
      expect(append).to include('Test')
    end

    it 'displays nothing if title is nil' do
      append = addon(nil)
      expect(append).to eq(nil)
    end

    it 'displays nothing if title is empty string' do
      append = addon('')
      expect(append).to eq(nil)
    end

    it 'html tag can be changed from default' do
      append = addon(title, 'div')
      expect(append).to include('div')
      expect(append).to include('Test')
    end
  end
end
