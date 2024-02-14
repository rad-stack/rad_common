class UserGrouper
  attr_accessor :current_user, :always_include, :allow_always_include, :scopes, :with_ids, :base_query

  def initialize(current_user, always_include: nil, scopes: [], with_ids: false, base_query: User.all)
    self.current_user = current_user
    self.always_include = always_include
    self.scopes = scopes
    self.with_ids = with_ids
    self.allow_always_include = false

    # TODO: try replacing the base_query feature with scopes, but will need to allow passing a block like
    # TODO: User.for_task_assignment(task)
    self.base_query = base_query
  end

  def legacy_list
    self.allow_always_include = true

    [me_item, internal_user_item, client_user_item, inactive_user_item].compact
  end

  def list_for_tasks(task)
    # TODO: handle always_include
    # TODO: handle scopes

    inactive = task.assigned_to_user && !task.assigned_to_user.active ? task.assigned_to_user : nil

    items = [me_item, internal_user_item, client_user_item]
    items.push(['Inactive', [inactive]]) if inactive

    items.compact
  end

  private

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
      records = Pundit.policy_scope!(current_user, base_query)
      scopes.each { |scope| records = records.send(scope) }

      # TODO: eventually remove allow_always_include
      records = records.or(User.where(id: always_include.id)) if always_include.present? && allow_always_include

      records.sorted
    end

    def format_collection(collection)
      return collection unless with_ids

      collection.map { |item| [item, item.id] }
    end
end
