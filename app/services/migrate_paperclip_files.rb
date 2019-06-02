class MigratePaperclipFiles
  attr_accessor :attachment_name
  attr_accessor :attachment_file_name
  attr_accessor :attachment_content_type
  attr_accessor :attachment_file_size
  attr_accessor :new_attachment_name
  attr_accessor :model_class

  def self.perform(model_class, attachments_to_process)

    attachments_to_process.each do |attachment_info|
      migrator = MigratePaperclipFiles.new

      migrator.model_class = model_class
      migrator.attachment_name = attachment_info[:attachment_name]
      migrator.attachment_file_name = "#{attachment_info[:attachment_name]}_file_name"
      migrator.attachment_content_type = "#{attachment_info[:attachment_name]}_content_type"
      migrator.new_attachment_name = attachment_info[:new_attachment_name]

      migrator.perform_migration
    end
  end

  def perform_migration
    model_class.where("#{attachment_file_name} is not null").find_each do |record|
      record.send(new_attachment_name).attach(io: open(attachment_url(record)),
                                          filename: record.send(attachment_file_name),
                                          content_type: record.send(attachment_content_type))
    end
  end

  def attachment_url(record)
    result = ActiveRecord::Base.connection.execute("select key from active_storage_attachments
                                                               join active_storage_blobs on active_storage_blobs.id = active_storage_attachments.blob_id
                                                               where record_type = '#{model_class}' AND record_id = #{record.id}
                                                                                                    AND name = '#{new_attachment_name}'
                                                                                                    AND  metadata = '{}'")
    path = result[0]['key']

    # this url pattern can be changed to reflect whatever service you use
    "https://s3.amazonaws.com/#{bucket_name}#{path}"
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
