class ExistingDataEmbedder
  def run(session)
    AppInfo.new.embeddable_models.each do |model_name|
      session.reset_status

      records = model_name.constantize.needs_embedding
      count = records.count

      records.find_each do |record|
        session.check_status "Embeddings for #{model_name}", count
        break if session.timing_out?

        record.update_embedding!
      end

      break if session.timing_out?
    end
  end
end
