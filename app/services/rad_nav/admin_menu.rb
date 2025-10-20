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

      DropdownMenu.new(view_context, 'Admin', admin_menu_items, icon_name: 'gear').content
    end

    private

      def admin_menu_items
        additional_items + [divider] + standard_items
      end

      def standard_items
        [DropdownMenuItem.new(view_context, 'Audit Search', view_context.audits_path),
         sidekiq,
         DropdownMenuItem.new(view_context, 'Company Info', view_context.company_edit_path),
         generate_jwt,
         DropdownMenuIndexItem.new(view_context, 'NotificationType'),
         DropdownMenuIndexItem.new(view_context, 'SecurityRole'),
         sentry_test,
         DropdownMenuIndexItem.new(view_context, 'LoginActivity', label: 'Sign In Activity'),
         system_messages,
         DropdownMenuItem.new(view_context, 'System Usage', view_context.system_usages_path),
         DropdownMenuIndexItem.new(view_context, 'ContactLog'),
         DropdownMenuIndexItem.new(view_context, 'CustomReport'),
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
                             link_options: { target: '_blank', rel: :noopener },
                             permission: developer?)
      end

      def generate_jwt
        return unless RadConfig.jwt_enabled?

        DropdownMenuItem.new(view_context,
                             'Generate JWT Token',
                             view_context.new_json_web_token_path,
                             permission: developer?)
      end

      def sentry_test
        DropdownMenuItem.new(view_context,
                             'Sentry Test',
                             view_context.new_sentry_test_path,
                             permission: developer?)
      end

      def system_messages
        DropdownMenuItem.new(view_context, 'System Message', view_context.new_system_message_path)
      end

      def users
        return unless include_users?

        DropdownMenuUsersItem.new(view_context)
      end

      def validate_database
        DropdownMenuItem.new(view_context,
                             'Validate Database',
                             view_context.new_global_validation_path,
                             permission: developer?)
      end

      def include_users?
        include_users
      end

      def admin?
        @admin ||= current_user.admin?
      end

      def developer?
        @developer ||= current_user.developer? || Rails.env.development?
      end
  end
end
