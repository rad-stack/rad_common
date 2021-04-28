class MergeDuplicatesJob < ApplicationJob
  attr_accessor :current_user, :model, :record

  queue_as :default

  def perform(duplicate_keys, model_class, model_id, user_id)
    @current_user = User.find(user_id)
    @model = model_class.constantize
    @record = model.find(model_id)

    error = nil

    duplicate_keys.each do |key|
      error = cleanup_duplicate(key)
      break if error
    end

    if error.present?
      notify_user "Unable to process duplicates for #{model_class} #{model_id}", error
    else
      record.process_duplicates
      subject = "The duplicates for #{model_class} #{model_id} were successfully resolved."
      notify_user subject, subject
    end
  end

  private

    def notify_user(subject, message)
      RadbearMailer.simple_message(current_user, subject, message, email_options(record)).deliver_later

      # TODO: remove this once done monitoring
      RadbearMailer.simple_message('gary@radicalbear.com', subject, message, email_options(record)).deliver_later
    end

    def cleanup_duplicate(key)
      duplicate_record = model.find_by(id: key)

      if duplicate_record.blank?
        return 'Invalid record data, perhaps something has changed or another user has resolved these duplicates.'
      end

      return 'The records are the same record.' if duplicate_record.id == record.id

      unless Pundit.policy!(current_user, duplicate_record).destroy?
        return 'You do not have authorization to merge these duplicates.'
      end

      status, message = duplicate_record.can_merge_duplicate?(record)
      return message unless status

      duplicate_record.clean_up_duplicate(record)
      duplicate_record.reload

      return nil if duplicate_record.destroy

      'Could not remove the unused duplicate record '\
        "id #{duplicate_record.id}: #{duplicate_record.errors.full_messages.join(', ')}"
    end

    def email_options(record)
      return if subject_url(record).blank?

      { email_action: { message: 'Click here to view the details.',
                        button_text: 'View',
                        button_url: subject_url(record) } }
    end

    def subject_url(subject_record)
      return unless ApplicationController.helpers.show_route_exists_for?(subject_record)

      Rails.application.routes.url_helpers.url_for(subject_record)
    end
end
