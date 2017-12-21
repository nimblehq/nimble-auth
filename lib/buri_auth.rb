# Override the standard devise views by requiring 'devise' before the engine
require 'devise'
require 'buri_auth/engine'

module BuriAuth
  mattr_accessor :resource_class
end
