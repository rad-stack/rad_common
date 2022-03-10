class AssociationInputPresenter
  MAX_DROPDOWN_SIZE = 300

  attr_reader :current_user, :local_assigns

  def initialize(current_user, local_assigns = {})
    @current_user = current_user
    @local_assigns = local_assigns
  end

  def form
    local_assigns[:f]
  end

  def search_only?
    collection.size > MAX_DROPDOWN_SIZE
  end

  def search_options
    {
      search_path: "/rad_common/global_search?global_search_scope=#{local_assigns[:search_scope]}",
      initial_value: initial_value,
      base_object: base_object,
      association: association,
      required: local_assigns[:required].presence || false,
      f: form
    }
  end

  def collection_options
    {
      collection: collection,
      input_html: { class: 'selectpicker', 'data-live-search' => true }
    }
  end

  def association
    local_assigns[:association]
  end

  private

    def initial_value
      local_assigns[:initial_value].presence || record.public_send(association)&.to_s
    end

    def record
      form.object
    end

    def base_object
      local_assigns[:base_object].presence || record.class.table_name.singularize
    end

    def collection
      Pundit.policy_scope!(current_user, record.association(association).klass).sorted
    end
end
