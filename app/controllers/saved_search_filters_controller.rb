class SavedSearchFiltersController < ApplicationController
  before_action :set_saved_search_filter, only: :destroy

  def destroy
    if @saved_search_filter.destroy
      flash[:notice] = 'Saved Filter was successfully deleted.'
    else
      flash[:error] = @saved_search_filter.errors.full_messages.join(', ')
    end

    redirect_back(fallback_location: root_path)
  end

  private

    def set_saved_search_filter
      @saved_search_filter = SavedSearchFilter.find(params[:id])
      authorize @saved_search_filter
    end
end
