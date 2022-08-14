module Users
  class InvitationsController < Devise::InvitationsController
    def new
      authorize User
      super
    end

    def create
      authorize User
      self.resource = invite_resource
      resource_invited = resource.errors.empty?

      yield resource if block_given?

      if resource_invited
        if status
          flash[:success] = "We invited '#{resource}' and sent them an email. You can update their settings as " \
                            'needed here.'

          redirect_to edit_user_path(resource)
        else
          flash[:error] = "Could not add user: #{user.errors.full_messages.join(', ')}"
        end
      else
        flash[:error] = "Could not add user: #{resource.errors.full_messages.join(', ')}" if resource.errors.any?

        respond_with_navigational(resource) { render :new }
      end
    end
  end
end
