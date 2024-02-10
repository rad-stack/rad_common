module RadTable
  class Table
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
        column.attach_table(self)
        !column.hidden && (search.nil? || search_setting.show_column?(column))
      end
    end

    def render_cell(record, column)
      column.render(record)
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
      columns.map { |c| [c.header, c.name] }
    end

    def all_columns_selected?
      columns.all? { |c| search_setting.show_column?(c) }
    end

    def saved_filters
      @saved_filters ||= if search.nil?
                           []
                         else
                           Pundit.policy_scope(user, SavedSearchFilter).for_search_class(search.class.name)
                         end
    end

    def rad_common_engine?
      false
    end
  end
end
