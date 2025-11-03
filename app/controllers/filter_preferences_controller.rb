class FilterPreferencesController < ApplicationController
  def update
    authorize :filter_preference, :update?

    search_name = params[:search_name]
    behavior = params[:behavior]

    unless RadSearch::FilterDefaulting::TOGGLE_BEHAVIORS.pluck(:value).include?(behavior)
      render json: { error: 'Invalid behavior' }, status: :unprocessable_entity
      return
    end

    current_user.set_filter_toggle_behavior(search_name, behavior)

    @search_name = search_name
    @behavior = behavior
    @collapse_state = case behavior
                      when 'always_open'
                        'show'
                      when 'always_closed'
                        'hide'
                      end

    respond_to { |format| format.turbo_stream }
  end
end
