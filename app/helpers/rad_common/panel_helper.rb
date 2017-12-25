module RadCommon
  module PanelHelper
    def panel_presenter(local_assigns = {})
      presenter = PanelPresenter.new(self, local_assigns)
      yield presenter if block_given?
      presenter
    end
  end
end
