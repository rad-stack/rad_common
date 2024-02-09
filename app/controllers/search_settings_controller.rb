class SearchSettingsController < ApplicationController
  before_action :set_search_setting

  def update
    params[:commit] == 'Enable All' ? @search_setting.columns = [] : @search_setting.assign_attributes(permitted_params)
    if @search_setting.save
      flash[:success] = 'Settings were successfully updated'
    else
      flash[:error] = @search_setting.errors.full_messages.join(', ')
    end

    redirect_back(fallback_location: root_path)
  end

  private

    def set_search_setting
      @search_setting = SearchSetting.find(params[:id])
      authorize @search_setting
    end

    def permitted_params
      params.require(:search_setting).permit(columns: [])
    end
end
