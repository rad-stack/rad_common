class MigratePaperclipFiles
  attr_accessor :attachment_name
  attr_accessor :attachment_file_name
  attr_accessor :attachment_content_type
  attr_accessor :attachment_file_size
  attr_accessor :new_attachment_name
  attr_accessor :model_class

  def self.perform(model_class, attachment_names, session)

    attachment_names.each do |attachment_name|
      session.reset_status
      migrator = MigratePaperclipFiles.new

      migrator.model_class = model_class
      migrator.attachment_name = attachment_name
      migrator.attachment_file_name = "#{attachment_name}_file_name"
      migrator.attachment_content_type = "#{attachment_name}_content_type"
      migrator.new_attachment_name = "#{attachment_name}_new"

      migrator.perform_migration(session)
    end
  end

  def perform_migration(session)
    records_with_attachments = model_class.where("#{attachment_file_name} is not null")
    count = records_with_attachments.count
    records_with_attachments.find_each do |record|
      break if session.check_status('performing migration', count)

      Rails.logger.info "Attaching #{attachment_name} to #{model_class} #{record.id}"
      result_key = attachment_result_key(record)
      if result_key.present?
        record.send(new_attachment_name).attach(io: open(attachment_url(result_key)),
                                                filename: record.send(attachment_file_name),
                                                content_type: record.send(attachment_content_type))
        Rails.logger.info "Finised Attaching #{attachment_name} to #{model_class} #{record.id}"
      else
        puts "Skipping #{model_class} #{record.id}  - #{attachment_name}, it has already been processed"
      end
    end
  end

  def attachment_result_key(record)
    result = ActiveRecord::Base.connection.execute("select key from active_storage_attachments
                                                               join active_storage_blobs on active_storage_blobs.id = active_storage_attachments.blob_id
                                                               where record_type = '#{model_class}' AND record_id = #{record.id}
                                                                                                    AND name = '#{new_attachment_name}'
                                                                                                    AND metadata = '{}'")

    result.count.zero? ? nil : result[0]['key']
  end

  def attachment_url(result_key)
    "https://s3.amazonaws.com/#{bucket_name}#{result_key}"
  end

  def bucket_name
    parse_credentials[:bucket]
  end

  def parse_credentials(creds=Rails.root.join('config', 's3.yml'))
    creds = creds.respond_to?(:call) ? creds.call(self) : creds
    creds = find_credentials(creds).stringify_keys
    (creds[Rails.env] || creds).symbolize_keys
  end

  def find_credentials(creds)
    case creds
    when File
      YAML::load(ERB.new(File.read(creds.path)).result)
    when String, Pathname
      YAML::load(ERB.new(File.read(creds)).result)
    when Hash
      creds
    else
      if creds.respond_to?(:call)
        creds.call(self)
      else
        raise ArgumentError, "Credentials are not a path, file, hash or proc."
      end
    end
  end
end
