class UserGrouper
  include RadCommon::SearchableDropdownHelper
  attr_accessor :current_user, :always_include, :scopes, :with_ids

  def initialize(current_user, always_include: nil, scopes: [], with_ids: false)
    self.current_user = current_user
    self.always_include = always_include
    self.scopes = scopes
    self.with_ids = with_ids
  end

  def call
    [me_item, internal_user_item, client_user_item, inactive_user_item].compact
  end

  def user_filter(label, column, scope = nil)
    default_options = { input_label: label, column: column, include_blank: false, blank_value_label: 'All Users' }
    default_options[:scope] = scope if scope
    return searchable_options(default_options) if max_dropdown_size_exceeded?(base_users)

    { options: call }.merge(default_options).merge({ grouped: true, include_blank: true })
  end

  private

    def searchable_options(default_options)
      { search_scope_name: 'user_name', show_search_subtext: true }.merge(default_options)
    end

    def me_item
      return if me_users.none?

      ['Me', format_collection(me_users)]
    end

    def internal_user_item
      return if internal_users.none?

      ['Users', format_collection(internal_users)]
    end

    def client_user_item
      return if client_users.none?

      ['Clients', format_collection(client_users)]
    end

    def inactive_user_item
      return if inactive_users.none?

      ['Inactive', format_collection(inactive_users)]
    end

    def me_users
      @me_users ||= base_users.where(id: current_user.id)
    end

    def internal_users
      @internal_users ||= base_users.active.internal.where.not(id: current_user.id)
    end

    def client_users
      @client_users ||= base_users.active.external
    end

    def inactive_users
      @inactive_users ||= base_users.inactive
    end

    def base_users
      records = Pundit.policy_scope!(current_user, User)
      records = apply_scopes(records) if scopes.any?
      records = records.or(User.where(id: always_include.id)) if always_include.present?
      records.sorted
    end

    def apply_scopes(records)
      scopes.each do |scope|
        if scope.is_a?(Hash)
          scope_args = scope.values.first.is_a?(Array) ? scope.values.first : [scope.values.first]
          records = records.public_send(scope.keys.first, *scope_args)
        elsif scope.is_a?(Symbol)
          records = records.public_send(scope)
        else
          raise "invalid scope type #{scope.class}"
        end
      end

      records
    end

    def format_collection(collection)
      return collection unless with_ids

      collection.map { |item| [item, item.id] }
    end
end
