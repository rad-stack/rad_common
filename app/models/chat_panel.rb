class ChatPanel
  attr_reader :chat_list_id, :messages, :record, :form_url, :input_name, :input_id,
              :placeholder, :form_data, :input_data, :input_classes, :turbo_frame,
              :before_input_partial, :before_input_locals,
              :after_submit_partial, :after_submit_locals
  attr_accessor :additional_content

  # rubocop:disable Metrics/ParameterLists
  def initialize(chat_list_id:, record:, input_name:, input_id:, form_url: nil,
                 placeholder: 'Type a message...', messages: [], form_data: {}, input_data: {},
                 input_classes: 'form-control', turbo_frame: nil,
                 before_input_partial: nil, before_input_locals: {},
                 after_submit_partial: nil, after_submit_locals: {})
    @chat_list_id = chat_list_id
    @record = record
    @form_url = form_url
    @input_name = input_name
    @input_id = input_id
    @placeholder = placeholder
    @messages = messages
    @form_data = form_data
    @input_data = input_data
    @input_classes = input_classes
    @turbo_frame = turbo_frame
    @before_input_partial = before_input_partial
    @before_input_locals = before_input_locals
    @after_submit_partial = after_submit_partial
    @after_submit_locals = after_submit_locals
  end
  # rubocop:enable Metrics/ParameterLists

  def form_options
    options = { html: { data: form_data } }
    options[:url] = form_url if form_url
    options
  end
end
