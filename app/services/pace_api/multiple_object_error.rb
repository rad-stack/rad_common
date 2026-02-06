module PaceApi
  class MultipleObjectError < StandardError
    def initialize(message, type)
      super(message)
      @type = type
    end

    def notify!(record)
      Notifications::MultipleRecordInPaceNotification
        .main(import_record: record, message: message, object_type: @type).notify!
    end

    def skip?
      true
    end
  end
end
