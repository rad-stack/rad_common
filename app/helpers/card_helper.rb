module CardHelper
  def card_presenter(local_assigns = {})
    presenter = CardPresenter.new(self, local_assigns)
    yield presenter if block_given?
    presenter
  end
end
