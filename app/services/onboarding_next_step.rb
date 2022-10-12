class OnboardingNextStep
  attr_reader :label, :path

  def initialize(label:, path:)
    @label = "Setup Incomplete, Next Step #{label}"
    @path = path
  end
end
