module RadNav
  class AdminMenu
    attr_accessor :view_context, :additional_items, :include_users

    delegate :current_user, :render, :tag, to: :view_context

    def initialize(view_context, include_users, additional_items: [])
      @view_context = view_context
      @additional_items = additional_items
      @include_users = include_users
    end

    def content
      return unless current_user.admin?

      RadNav::DropdownMenu.new(view_context, 'Admin', admin_menu_items, badge: user_badge).content
    end

    private

      def admin_menu_items
        additional_items + standard_items
      end

      def standard_items
        [divider,
         RadNav::DropdownMenuItem.new(view_context, 'Audit Search', '/rad_common/audits').content,
         sidekiq,
         RadNav::DropdownMenuItem.new(view_context, 'Company Info', '/rad_common/company/edit').content,
         generate_jwt,
         RadNav::DropdownMenuItem.new(view_context, 'Notification Types', '/rad_common/notification_types').content,
         RadNav::DropdownMenuIndexItem.new(view_context, 'SecurityRole').content,
         sentry_test,
         RadNav::DropdownMenuItem.new(view_context, 'Sign In Activity', '/rad_common/login_activities').content,
         system_messages,
         RadNav::DropdownMenuItem.new(view_context, 'System Usage', '/rad_common/system_usages').content,
         twilio_logs,
         users,
         validate_database]
      end

      def divider
        return if additional_items.blank?

        tag.li(class: 'dropdown-divider')
      end

      def sidekiq
        RadNav::DropdownMenuItem.new(view_context,
                                     'Background Jobs',
                                     '/sidekiq',
                                     link_options: { target: '_blank', rel: :noopener }).content
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

      def users
        return if user_nav.blank?

        user_nav.content
      end

      def validate_database
        RadNav::DropdownMenuItem.new(view_context,
                                     'Validate Database',
                                     '/rad_common/global_validations/new').content
      end

      def user_nav
        return unless include_users?

        RadNav::DropdownMenuIndexItem.new(view_context, 'User')
      end

      def user_badge
        return if user_nav.blank?

        user_nav.badge
      end

      def include_users?
        include_users
      end
  end
end
