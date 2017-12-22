module RadCommon
  module GlobalValidityHelper
    def record_url(record)
      url_for(record)
    end

    def record_name(record)
      "#{record.class.to_s.titleize} #{record.id}:"
    end
  end
end
