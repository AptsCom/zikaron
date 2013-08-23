require "redis/namespace"
require "zikaron/version"
require "zikaron/remembers/actions"

module Zikaron

  class << self
    attr_accessor :config
  end

  def self.redis_exists?
    begin
      Redis.connect(:url => config.redis_url).ping
    rescue
      false
    end
  end

  def self.flush_cache
    begin
      return unless redis_exists?
      keys = redis.keys("zikaron*")
      redis.del(keys) unless keys.empty?
    rescue
      puts "Cache does not exist."
    end
  end

  def self.redis
    @redis ||= Redis::Namespace.new(config.cache_name, :redis => Redis.connect(:url => config.redis_url))
  end

  def self.configure(&block)
    @config = Configuration.new
    yield(config)
  end

  def self.config
    @config || Configuration.new
  end

  class Configuration
    attr_accessor :redis_url, :memory_duration, :cache_name

    def initialize
      self.redis_url        ||= 'redis://localhost:6379/'
      self.memory_duration  ||= 60
      self.cache_name       ||= 'zikaron'
    end
  end

end
