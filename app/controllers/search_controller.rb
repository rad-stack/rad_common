class SearchController < ApplicationController
  def global_search
    # authorization is checked within the global_autocomplete_result
    skip_authorization

    global_autocomplete = GlobalAutocomplete.new(params, GlobalSearch.new(current_user).scopes, current_user)

    if params['super_search'].to_i == 1
      render json: global_autocomplete.global_super_search_result
    else
      render json: global_autocomplete.global_autocomplete_result
    end
  end

  def global_search_result
    # authorization is checked by the redirect destination
    skip_authorization

    if params[:global_search_model_name].blank? || params[:global_search_id].blank?
      flash[:error] = 'Missing parameters'
      redirect_to root_path
    else
      model_name = params[:global_search_model_name]
      the_id = params[:global_search_id]
      klass = Object.const_get model_name
      the_object = klass.find_by(id: the_id)

      if params[:global_search_scope].present?
        current_user.update_column(:global_search_default, params[:global_search_scope])
      end

      if the_object
        if current_user.portal?
          redirect_to [:portal, the_object]
        else
          redirect_to the_object
        end
      else
        flash[:error] = 'Could not find record, please try your search again.'
        redirect_to root_path
      end
    end
  end
end
