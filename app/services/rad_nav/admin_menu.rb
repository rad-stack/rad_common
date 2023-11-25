module RadNav
  class AdminMenu
    attr_accessor :view_context, :additional_items

    delegate :current_user, :render, :tag, to: :view_context

    def initialize(view_context, additional_items: [])
      @view_context = view_context
      @additional_items = additional_items
    end

    def content
      return unless current_user.admin?

      RadNav::DropdownMenu.new(view_context, 'Admin', admin_menu_items).content
    end

    private

      def admin_menu_items
        additional_items + standard_items
      end

      def standard_items
        [divider,
         RadNav::DropdownMenuItem.new(view_context, 'Audit Search', '/rad_common/audits').content,
         RadNav::DropdownMenuItem.new(view_context, 'Background Jobs', '/sidekiq', separate_tab: true).content,
         RadNav::DropdownMenuItem.new(view_context, 'Company Info', '/rad_common/company/edit').content,
         generate_jwt,
         RadNav::DropdownMenuItem.new(view_context, 'Notification Types', '/rad_common/notification_types').content,
         RadNav::DropdownMenuIndexItem.new(view_context, 'SecurityRole').content,
         sentry_test,
         RadNav::DropdownMenuItem.new(view_context, 'Sign In Activity', '/rad_common/login_activities').content,
         system_messages,
         RadNav::DropdownMenuItem.new(view_context, 'System Usage', '/rad_common/system_usages').content,
         twilio_logs,
         RadNav::DropdownMenuIndexItem.new(view_context, 'User').content,
         validate_database]
      end

      def divider
        return if additional_items.blank?

        tag.li(class: 'dropdown-divider')
      end

      def generate_jwt
        return unless RadConfig.jwt_enabled?

        RadNav::DropdownMenuItem.new(view_context, 'Generate JWT Token', view_context.new_json_web_token_path).content
      end

      def sentry_test
        RadNav::DropdownMenuItem.new(view_context,
                                     'Sentry Test',
                                     RadCommon::Engine.routes.url_helpers.edit_sentry_test_path(current_user)).content
      end

      def system_messages
        RadNav::DropdownMenuItem.new(view_context,
                                     'System Message',
                                     RadCommon::Engine.routes.url_helpers.new_system_message_path).content
      end

      def twilio_logs
        return unless RadTwilio.new.twilio_enabled? || TwilioLog.exists?

        RadNav::DropdownMenuItem.new(view_context, 'Twilio Logs', '/rad_common/twilio_logs').content
      end

      def validate_database
        RadNav::DropdownMenuItem.new(view_context,
                                     'Validate Database',
                                     '/rad_common/global_validations/new').content
      end
  end
end
