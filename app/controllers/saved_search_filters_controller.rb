class SavedSearchFiltersController < ApplicationController
  before_action :set_saved_search_filter, only: :destroy

  def create
    @saved_search_filter = SavedSearchFilter.new(permitted_params)
    @saved_search_filter.search_filters = JSON.parse(@saved_search_filter.search_filters)
    authorize @saved_search_filter

    if @saved_search_filter.save
      flash[:success] = 'Saved Filter was successfully created.'
    else
      flash[:error] = @saved_search_filter.errors.full_messages.join(', ')
    end

    redirect_back(fallback_location: root_path)
  end

  def destroy
    if @saved_search_filter.destroy
      flash[:success] = 'Saved Filter was successfully deleted.'
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

    def permitted_params
      params.require(:saved_search_filter).permit(:search_setting_id, :name, :search_filters)
    end
end
