module RadCommon
  class Utf8QueryGuard
    class InvalidUtf8Query < StandardError; end

    def initialize(app)
      @app = app
    end

    def call(env)
      query = env['QUERY_STRING']
      return @app.call(env) if query.nil? || query.empty? || valid_utf8?(query)
      return [400, { 'content-type' => 'text/plain' }, ['Bad Request']] unless authenticated?(env)

      raise InvalidUtf8Query, "Invalid UTF-8 in query string: #{query.inspect}"
    end

    private

      def valid_utf8?(query)
        Rack::Utils.unescape_path(query.dup).force_encoding('UTF-8').valid_encoding?
      rescue ArgumentError
        false
      end

      def authenticated?(env)
        env['warden']&.user.present?
      rescue StandardError
        false
      end
  end
end
