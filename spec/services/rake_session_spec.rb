require 'rails_helper'

class TestRakeTask
  def name
    'foo'
  end
end

RSpec.describe RakeSession, type: :lib do
  let(:time_limit) { 1.minute }
  let(:status_frequency) { 1 }
  let(:session) { described_class.new(TestRakeTask.new, time_limit, status_frequency) }

  before { session.reset_status }

  # TODO: add some assertions to make this spec more valuable

  describe '#check_status' do
    it 'runs' do
      session.check_status('running foo', 1000)
    end
  end
end
