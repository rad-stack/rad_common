module RadNav
  class AdminMenu
    attr_accessor :view_context, :additional_items, :include_users

    delegate :current_user, :render, :tag, to: :view_context

    def initialize(view_context, include_users, additional_items: [])
      @view_context = view_context
      @additional_items = additional_items.compact.sort_by(&:label)
      @include_users = include_users
    end

    def content
      return unless admin?

      DropdownMenu.new(view_context, 'Admin', admin_menu_items).content
    end

    private

      def admin_menu_items
        additional_items + [divider] + standard_items
      end

      def standard_items
        [DropdownMenuItem.new(view_context, 'Audit Search', '/rad_common/audits'),
         sidekiq,
         DropdownMenuItem.new(view_context, 'Company Info', '/rad_common/company/edit'),
         generate_jwt,
         DropdownMenuItem.new(view_context, 'Notification Types', '/rad_common/notification_types'),
         DropdownMenuIndexItem.new(view_context, 'SecurityRole'),
         sentry_test,
         DropdownMenuItem.new(view_context, 'Sign In Activity', '/rad_common/login_activities'),
         system_messages,
         DropdownMenuItem.new(view_context, 'System Usage', '/rad_common/system_usages'),
         DropdownMenuIndexItem.new(view_context, 'ContactLog'),
         users,
         validate_database].compact.sort_by(&:label)
      end

      def divider
        return if additional_items.blank?

        NavDivider.new view_context
      end

      def sidekiq
        DropdownMenuItem.new(view_context,
                             'Background Jobs',
                             '/sidekiq',
                             link_options: { target: '_blank', rel: :noopener })
      end

      def generate_jwt
        return unless RadConfig.jwt_enabled?

        DropdownMenuItem.new(view_context, 'Generate JWT Token', view_context.new_json_web_token_path)
      end

      def sentry_test
        DropdownMenuItem.new(view_context, 'Sentry Test', view_context.new_sentry_test_path)
      end

      def system_messages
        DropdownMenuItem.new(view_context,
                             'System Message',
                             RadCommon::Engine.routes.url_helpers.new_system_message_path)
      end

      def users
        return unless include_users?

        DropdownMenuUsersItem.new(view_context)
      end

      def validate_database
        DropdownMenuItem.new(view_context, 'Validate Database', '/rad_common/global_validations/new')
      end

      def include_users?
        include_users
      end

      def admin?
        @admin ||= current_user.admin?
      end
  end
end
