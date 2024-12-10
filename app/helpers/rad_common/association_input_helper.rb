module RadCommon
  module AssociationInputHelper
    def association_input_presenter(local_assigns = {})
      presenter = AssociationInputPresenter.new(current_user, local_assigns)
      yield presenter if block_given?
      presenter
    end
  end
end
