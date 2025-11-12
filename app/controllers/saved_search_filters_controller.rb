class SavedSearchFiltersController < ApplicationController
  before_action :set_saved_search_filter, only: :destroy

  def create
    @saved_search_filter = SavedSearchFilter.new(permitted_params)
    @saved_search_filter.user = current_user
    if @saved_search_filter.search_filters.is_a? String
      @saved_search_filter.search_filters = JSON.parse(@saved_search_filter.search_filters)
    end
    authorize @saved_search_filter
    if @saved_search_filter.save
      respond_to { |format| format.turbo_stream { render 'create' } }
    else
      render(partial: 'saved_search_filters/form')
    end
  end

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

    def permitted_params
      params.require(:saved_search_filter).permit(:name, :search_class, :search_filters)
    end
end
