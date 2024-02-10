module RadTable
  class ActionsColumn < Column
    def render(record)
      actions = []
      actions << update_action(record) if view_context.policy(record).update?
      actions << delete_action(record) if view_context.policy(record).destroy?
      view_context.safe_join(actions, '')
    end

    def toggleable?
      false
    end

    private

      def update_action(record)
        view_context.link_to 'Edit',
                             view_context.edit_division_path(record),
                             class: 'btn btn-sm btn-secondary btn-block'
      end

      def delete_action(record)
        view_context.link_to 'Delete',
                             record,
                             method: :delete,
                             data: { confirm: 'Are you sure?' },
                             class: 'btn btn-danger btn-sm btn-block'
      end
  end
end
