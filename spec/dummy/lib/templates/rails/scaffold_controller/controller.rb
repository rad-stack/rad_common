<% if namespaced? -%>
require_dependency "<%= namespaced_file_path %>/application_controller"

<% end -%>
<% module_namespacing do -%>
class <%= controller_class_name %>Controller < ApplicationController
  before_action :set_<%= singular_table_name %>, only: %i[show edit update destroy]

  def index
    authorize <%= class_name %>
    # TODO: change 'all' to a scope for ordering the records
    @<%= plural_table_name %> = policy_scope(<%= orm_class.all(class_name) %>).page(params[:page])
  end

  def show; end

  def new
    @<%= singular_table_name %> = <%= orm_class.build(class_name) %>
    authorize @<%= singular_table_name %>
  end

  def edit; end

  def create
    @<%= singular_table_name %> = <%= orm_class.build(class_name, "permitted_params") %>
    authorize @<%= singular_table_name %>

    if @<%= orm_instance.save %>
      redirect_to @<%= singular_table_name %>, notice: <%= "'#{human_name} was successfully created.'" %>
    else
      render :new
    end
  end

  def update
    if @<%= orm_instance.update("permitted_params") %>
      redirect_to @<%= singular_table_name %>, notice: <%= "'#{human_name} was successfully updated.'" %>
    else
      render :edit
    end
  end

  def destroy
    destroyed = @<%= orm_instance.destroy %>

    if destroyed
      flash[:success] = <%= "'#{human_name} was successfully deleted.'" %>
    else
      flash[:error] = @<%= singular_table_name %>.errors.full_messages.join(', ')
    end

    index_paths = [<%= singular_table_name %>_path(@<%= singular_table_name %>), edit_<%= singular_table_name %>_path(@<%= singular_table_name %>)]

    if destroyed && index_paths.include?(URI(request.referer).path)
      redirect_to <%= index_helper %>_path
    else
      redirect_back(fallback_location: <%= index_helper %>_path)
    end
  end

  private

    def set_<%= singular_table_name %>
      @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
      authorize @<%= singular_table_name %>
    end

    def permitted_params
      <%- if attributes_names.empty? -%>
      params[:<%= singular_table_name %>]
      <%- else -%>
      params.require(:<%= singular_table_name %>).permit(<%= attributes_names.map { |name| ":#{name}" }.join(', ') %>)
      <%- end -%>
    end
end
<% end -%>
