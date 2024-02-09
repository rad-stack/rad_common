class RadTable
  attr_reader :records, :user, :view_context, :search

  def initialize(records, user, view_context, search: nil)
    @records = records
    @user = user
    @view_context = view_context
    @search = search
  end

  def render
    ApplicationController.renderer.render(partial: 'layouts/rad_table', locals: { table: self })
  end

  def columns
    raise NotImplementedError, 'You must implement define #columns in subclasses'
  end

  def path
    raise NotImplementedError, 'You must implement define #path in subclasses'
  end

  def visible_columns
    @visible_columns ||= columns.select do |column|
      !column[:hidden] && (search.nil? || search_setting.show_column?(column[:name]))
    end
  end

  # TODO: Consider making columns objects that can be extended for custom behavior
  def render_cell(record, column)
    value = parse_value(record, column)
    case column[:type]
    when :date
      view_context.format_date(value)
    when :datetime
      view_context.format_datetime(value)
    when :secured_link
      view_context.secured_link(value)
    when :attachment
      view_context.render_one_attachment record: record,
                                         attachment_name: column[:attachment_name].presence || column[:name],
                                         new_tab: column.key?(:new_tab) ? column[:new_tab] : true
    when :actions
      view_context.safe_join([update_action(record), delete_action(record)], '')
    else
      value
    end
  end

  def show_actions?
    false
  end

  def striped?
    true
  end

  def bordered?
    true
  end

  def hover?
    false
  end

  def small?
    false
  end

  def search_setting
    @search_setting ||= SearchSetting.find_or_create_by!(user: user, search_class: search.class.name)
  end

  def column_selections
    columns.map { |c| [c[:header].presence || c[:name].to_s.titleize, c[:name]] }
  end

  def all_columns_selected?
    columns.all? { |c| search_setting.show_column?(c[:name]) }
  end

  private

    def parse_value(record, column)
      if column.key?(:value)
        column[:value].is_a?(Proc) ? column[:value].call(record) : column[:value]
      else
        record.public_send(column[:name])
      end
    end

    def actions_column
      { name: :actions, type: :actions, hidden: !show_actions?, value: nil, toggleable: false }
    end

    def update_action(record)
      return unless view_context.policy(record).update?

      view_context.link_to(view_context.icon(:pencil, 'Edit'),
                           view_context.edit_division_path(record),
                           class: 'btn btn-sm btn-secondary btn-block')
    end

    def delete_action(record)
      return unless view_context.policy(record).destroy?

      view_context.link_to(view_context.icon(:times, 'Delete'), record, method: :delete,
                                                                        data: { confirm: 'Are you sure?' },
                                                                        class: 'btn btn-danger btn-sm btn-block')
    end
end
