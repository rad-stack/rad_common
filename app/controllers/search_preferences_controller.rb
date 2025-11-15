class SearchPreferencesController < ApplicationController
  def create
    @search_preference = SearchPreference.new(search_preference_params)
    @search_preference.user = current_user
    authorize @search_preference

    save_and_respond
  end

  def update
    @search_preference = SearchPreference.find(params[:id])
    authorize @search_preference
    @search_preference.assign_attributes(search_preference_params)

    save_and_respond
  end

  private

    def save_and_respond
      unless @search_preference.save
        render json: { error: @search_preference.errors.full_messages.join(', ') }, status: :unprocessable_entity
        return
      end

      @collapse_state = collapse_state_for_behavior(@search_preference.toggle_behavior)
      respond_to { |format| format.turbo_stream { render 'update' } }
    end

    def search_preference_params
      params.require(:search_preference).permit(:search_class, :toggle_behavior, :sticky_filters)
    end

    def collapse_state_for_behavior(behavior)
      case behavior
      when 'always_open'
        'show'
      when 'always_closed'
        'hide'
      end
    end
end
