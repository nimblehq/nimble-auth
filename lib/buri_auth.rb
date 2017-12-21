# Override the standard devise views by requiring 'devise' before the engine
require 'devise'
require 'buri_auth/engine'

module BuriAuth
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :resource_class

    def initialize
      @resource_class = 'User'
    end
  end
end
