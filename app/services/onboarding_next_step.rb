class OnboardingNextStep
  attr_reader :label, :path

  def initialize(label:, path:)
    @label = label
    @path = path
  end
end
