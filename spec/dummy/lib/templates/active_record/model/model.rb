<% module_namespacing do -%>
class <%= class_name %> < <%= parent_class_name.classify %>
  include Authority::Abilities
  acts_as_tenant(:company)
  # alias_attribute :to_s, :name
  audited

<% attributes.select(&:reference?).each do |attribute| -%>
  belongs_to :<%= attribute.name %><%= ', polymorphic: true' if attribute.polymorphic? %><%= ', required: true' if attribute.required? %>
<% end -%>
<% if attributes.any?(&:password_digest?) -%>
  has_secure_password
<% end -%>
end
<% end -%>
