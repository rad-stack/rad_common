module Notifications
  class MultipleRecordInPaceNotification < PaceErrorNotification
    def description
      "More than one #{object_type} found in Pace"
    end
  end
end
