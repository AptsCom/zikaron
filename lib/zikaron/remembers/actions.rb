module Remembers

  module Actions

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def remembers(actions=[])
        actions = [actions].flatten
        send(:around_filter, :cache, :only => actions)
      end
    end

    def cache
      yield and return unless redis
      if cached = redis.get(request.url)
        respond_with cached and return 
      end
      yield
      redis.set request.url, response.body
      redis.expireat request.url, (Time.now + 5.seconds).to_i
    end

  end

end
