module RadbearController
  extend ActiveSupport::Concern
  include Pundit

  included do
    before_action :configure_devise_permitted_parameters, if: :devise_controller?
    before_action :set_sentry_user_context
    around_action :user_time_zone, if: :current_user
    after_action :verify_authorized, unless: :devise_controller?
    after_action :verify_policy_scoped, only: :index

    rescue_from Pundit::NotAuthorizedError do
      # the application.rb config in the docs to do the same thing doesn't work
      # https://github.com/varvet/pundit#rescuing-a-denied-authorization-in-rails
      render file: Rails.root.join('public/403.html'), formats: [:html], status: :forbidden, layout: false
    end
  end

  def validate_active_storage_attachment(record, attribute, file, valid_types, no_redirect = false, max_file_size = nil)
    if valid_active_storage_attachment?(record, attribute, file, valid_types, max_file_size)
      true
    else
      return false if no_redirect

      if action_methods.include?('edit')
        render :edit
      else
        redirect_to record
      end
      false
    end
  end

  def valid_active_storage_attachment?(record, attribute, file, valid_types, max_file_size = nil)
    # TODO: Remove this method and all calls when active storage validations are added (expected in Rails 6)
    return true if file.blank?

    invalid_content = !file.content_type.in?(valid_types)
    invalid_file_size = max_file_size.present? && max_file_size < file.size

    if invalid_content || invalid_file_size
      error = 'File could not be saved.'
      error += " File type must be one of #{valid_types.join(', ')}" if invalid_content

      if invalid_file_size
        error += " File size must be less than #{ApplicationController.helpers.number_to_human_size(max_file_size)}."
      end

      flash[:error] = error
      false
    else
      record.send(attribute).attach(file)
      true
    end
  end

  def validate_multiple_attachments(record, model, attributes_and_types)
    # TODO: Remove this method once native active storage validations are implemented

    errors = []
    attributes_and_types.each do |attribute_and_type|
      file = params[model][attribute_and_type[:attr]]

      if file.is_a?(Array)
        next if file.empty?

        if file.all? { |f| f.content_type.in?(attribute_and_type[:types]) }
          record.send(attribute_and_type[:attr]).attach(file)
        else
          errors << attribute_and_type[:attr].to_s.humanize
        end
      else
        next if file.blank?

        if file.content_type.in?(attribute_and_type[:types])
          record.send(attribute_and_type[:attr]).attach(file)
        else
          errors << attribute_and_type[:attr].to_s.humanize
        end
      end
    end
    return true if errors.empty?

    flash[:error] = "#{errors.join(', ')} could not be saved due to invalid content types"
    if action_methods.include?('edit')
      render :edit
    else
      redirect_to record
    end
    false
  end

  protected

    def set_sentry_user_context
      return unless current_user

      Sentry.set_user(id: current_user.id, email: current_user.email, name: current_user.to_s)
    end

    def user_time_zone(&block)
      Time.use_zone(current_user.timezone, &block)
    end
end
