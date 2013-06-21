module Zikaron

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
        yield and return unless Zikaron.redis_exists?
        if cached = Zikaron.redis.get(request.url)
          respond_with cached and return 
        end
        yield
        Zikaron.redis.set request.url, response.body
        Zikaron.redis.expireat request.url, (Time.now + Zikaron.config.memory_duration).to_i
      end

    end

  end

end