module PaceApi
  class ErrorReporter
    def initialize
      @subscribers = []
    end

    def report_error(error)
      @subscribers.each { |subscriber| subscriber.call(error) }
    end

    def subscribe(subscriber)
      @subscribers << subscriber
    end
  end
end
