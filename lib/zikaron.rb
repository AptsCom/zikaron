require "zikaron/version"
require "zikaron/remembers/actions"

module Zikaron

  class << self
    attr_accessor :config
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
      self.redis_url        ||= 'http://localhost:6379/'
      self.memory_duration  ||= 60
      self.cache_name       ||= 'zikaron'
    end
  end

end
