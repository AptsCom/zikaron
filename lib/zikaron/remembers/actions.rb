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
        if cached = Zikaron.redis.get("zikaron_#{request.url}")
          respond_with cached and return
        end
        yield
        write_to_cache
      end

      def write_to_cache
        Zikaron.redis.set("zikaron_#{request.url}", response.body)
        Zikaron.redis.expireat "zikaron_#{request.url}", (Time.now + Zikaron.config.memory_duration.to_i).to_i
      end

    end

  end

end