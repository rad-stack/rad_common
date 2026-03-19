require 'rails_helper'

describe TooltipHelper do
  let(:html_tag) { 'span' }
  let(:title) { 'Test' }
  let(:icon) { 'fa-heartbeat' }

  describe '#icon_tooltip' do
    it 'correctly formats to an icon tooltip' do
      tooltip = icon_tooltip(html_tag, title)
      expect(tooltip).to include('span')
      expect(tooltip).to include('title="Test"')
      expect(tooltip).to include('fa-circle-question')
    end

    it 'displays nothing if title is nil' do
      tooltip = icon_tooltip(html_tag, nil)
      expect(tooltip).to be_nil
    end

    it 'displays nothing if title is empty string' do
      tooltip = icon_tooltip(html_tag, '')
      expect(tooltip).to be_nil
    end

    it 'defaults tooltip placement to top' do
      tooltip = icon_tooltip(html_tag, title)
      expect(tooltip).to include('data-bs-placement="top"')
    end

    it 'changes the tooltip icon with 3rd argument' do
      tooltip = icon_tooltip(html_tag, title, icon)
      expect(tooltip).to include('fa-heartbeat')
    end
  end

  describe '#tooltip' do
    it 'does not include the font awesome icon class' do
      tooltip = tooltip(html_tag, title)
      expect(tooltip).not_to include('fa-circle-question')
    end

    it 'displays nothing if title is nil' do
      tooltip = tooltip(html_tag, nil)
      expect(tooltip).to be_nil
    end

    it 'displays nothing if title is empty string' do
      tooltip = tooltip(html_tag, '')
      expect(tooltip).to be_nil
    end
  end
end
