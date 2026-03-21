module PaceApi
  class MissingObjectError < StandardError
    def initialize(message, type)
      super(message)
      @type = type
    end

    def notify!(record)
      Notifications::MissingRecordInPaceNotification
        .main({ import_record: record, message: message, object_type: @type }).notify!
    end

    def skip?
      true
    end
  end
end
