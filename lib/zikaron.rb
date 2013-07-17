require "redis-namespace"
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
    return unless redis_exists?
    return if redis.keys("zikaron*")).empty?
    redis.del(redis.keys("zikaron*"))
  end

  def self.redis
    @redis ||= Redis.new
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
