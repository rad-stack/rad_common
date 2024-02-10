module RadTable
  class AttachmentColumn < Column
    def render(record)
      view_context.render_one_attachment record: record,
                                         attachment_name: options[:attachment_name].presence || name,
                                         new_tab: options.key?(:new_tab) ? options[:new_tab] : true
    end
  end
end
