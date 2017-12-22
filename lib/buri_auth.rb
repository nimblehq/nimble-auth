# Override the standard devise views by requiring 'devise' before the engine
require 'devise'
require 'buri_auth/engine'

module BuriAuth
  class Configuration
    # The model in the host application from which the engine User model is extended
    # It defaults to simply 'User'
    # @return [String]
    attr_accessor :resource_class

    def initialize
      @resource_class = 'User'
    end
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configuration=(config)
    @configuration = config
  end

  def self.configure
    yield configuration
  end
end
