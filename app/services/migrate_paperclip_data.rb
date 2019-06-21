class MigratePaperclipData
  attr_accessor :attachment_name
  attr_accessor :attachment_file_name
  attr_accessor :attachment_content_type
  attr_accessor :attachment_file_size
  attr_accessor :new_attachment_name
  attr_accessor :model_class

  def self.perform(model_class, attachment_names, sql_prepared, session)
    attachment_names.each do |attachment_name|
      migrator = MigratePaperclipData.new

      migrator.model_class = model_class
      migrator.attachment_name = attachment_name
      migrator.attachment_file_name = "#{attachment_name}_file_name"
      migrator.attachment_content_type = "#{attachment_name}_content_type"
      migrator.attachment_file_size = "#{attachment_name}_file_size"
      migrator.new_attachment_name = "#{attachment_name}_new"

      migrator.prepare_sql_statements unless sql_prepared
      migrator.perform_migration
    end
  end

  def prepare_sql_statements
    ActiveRecord::Base.connection.raw_connection.prepare('active_storage_blob_statement', <<-SQL)
      INSERT INTO active_storage_blobs (
        key, filename, content_type, metadata, byte_size, checksum, created_at
      ) VALUES ($1, $2, $3, '{}', $4, $5, $6)
    SQL
    # With the values, SQL was complaining if I didn't have named variables ($1, etc.).

    ActiveRecord::Base.connection.raw_connection.prepare('active_storage_attachment_statement', <<-SQL)
      INSERT INTO active_storage_attachments (
        name, record_type, record_id, blob_id, created_at
      ) VALUES ($1, $2, $3, $4, $5)
    SQL
  end

  def perform_migration
    ActiveRecord::Base.transaction do
      model_class.where("#{attachment_file_name} is not null").each do |record|
        Rails.logger.info "Starting Active Storage Blob and Attachment db insertions for #{model_class} #{record.id} - #{attachment_name}"
        make_active_storage_records(record)
        Rails.logger.info "Finished Active Storage Blob and Attachment db insertions for #{model_class} #{record.id} - #{attachment_name}"
      end
    end
  end

  private

  def make_active_storage_records(record)
    blob_key = key(record)
    filename = record.send attachment_file_name
    content_type = record.send attachment_content_type
    file_size = record.send attachment_file_size
    file_checksum = checksum(record)
    created_at = record.updated_at.iso8601

    blob_values = [blob_key, filename, content_type, file_size, file_checksum, created_at]
    ActiveRecord::Base.connection.raw_connection.exec_prepared(
        'active_storage_blob_statement',
        blob_values
    )

    # This will allow `record.attachment` calls to return an asset.
    blob_name = new_attachment_name
    record_type = record.class.name
    record_id = record.id

    attachment_values = [blob_name, record_type, record_id, last_blob_id, created_at]
    ActiveRecord::Base.connection.raw_connection.exec_prepared(
        'active_storage_attachment_statement',
        attachment_values
    )
  end

  def last_blob_id
    ActiveRecord::Base.connection.execute('select id, filename from active_storage_blobs order by id desc').first['id']
  end

  def key(record)
    # This differs from the standard key mentioned in the
    # migration guide, because on S3 our file is
    # located under several nested folders. Just
    # putting the filename as the key means Active Storage
    # searches the root directory and the file is not there.
    record.send(attachment_name).path
  end

  def checksum(record)
    # This code covers a migration of S3 Paperclip files only.

    resume_url = record.send(attachment_name).expiring_url(60)
    Rails.logger.info "Copy meta data for file: #{record.send(attachment_name).path}"
    uri = URI.parse(resume_url)

    opened_uri = uri.open.read

    Digest::MD5.base64digest(opened_uri)
  end
end
