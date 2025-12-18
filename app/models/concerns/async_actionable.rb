module AsyncActionable
  extend ActiveSupport::Concern

  class_methods do
    def async_action(name,
                     job_class:,
                     cache_expires_in: 10.minutes,
                     broadcast_channel: nil,
                     broadcast_target: nil,
                     broadcast_partial: nil)
      action_name = name.to_s

      define_method "#{action_name}_running?" do
        Rails.cache.read(cache_key_for(action_name)) == true
      end

      define_method "start_#{action_name}!" do
        Rails.cache.write(cache_key_for(action_name), true, expires_in: cache_expires_in)
      end

      define_method "finish_#{action_name}!" do
        Rails.cache.delete(cache_key_for(action_name))
        broadcast_async_update(broadcast_channel, broadcast_target, broadcast_partial) if broadcast_channel
      end

      define_method "trigger_#{action_name}!" do
        send("start_#{action_name}!")
        job_class.perform_later(id)
      end
    end

    def global_async_action(name,
                            job_class:,
                            cache_expires_in: 10.minutes,
                            broadcast_channel: nil,
                            broadcast_target: nil,
                            broadcast_partial: nil)
      action_name = name.to_s
      cache_key = "#{self.name.underscore}_#{action_name}_running"

      define_singleton_method "#{action_name}_running?" do
        Rails.cache.read(cache_key) == true
      end

      define_singleton_method "start_#{action_name}!" do
        Rails.cache.write(cache_key, true, expires_in: cache_expires_in)
      end

      define_singleton_method "finish_#{action_name}!" do
        Rails.cache.delete(cache_key)

        return unless broadcast_channel && broadcast_target

        Turbo::StreamsChannel.broadcast_replace_to(
          broadcast_channel,
          target: broadcast_target,
          partial: broadcast_partial
        )
      end

      define_singleton_method "trigger_#{action_name}!" do
        send("start_#{action_name}!")
        job_class.perform_later
      end
    end
  end

  private

    def cache_key_for(action_name)
      "#{self.class.name.underscore}_#{id}_#{action_name}_running"
    end

    def broadcast_async_update(channel_proc, target_proc, partial_path)
      return unless channel_proc && target_proc

      channel = channel_proc.is_a?(Proc) ? instance_exec(&channel_proc) : channel_proc
      target = target_proc.is_a?(Proc) ? instance_exec(&target_proc) : target_proc

      Turbo::StreamsChannel.broadcast_replace_to(
        channel,
        target: target,
        partial: partial_path,
        locals: { record: self }
      )
    end
end
