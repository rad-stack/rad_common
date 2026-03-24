module DataColumnsHelper
  def data_columns_presenter(local_assigns = {})
    presenter = DataColumnsPresenter.new(self, local_assigns)
    yield presenter if block_given?
    presenter
  end
end
