ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('dummy/config/environment.rb', __dir__)

require 'rspec/rails'
require 'ffaker'
require 'fabrication'

Dir['spec/support/**/*.rb'].each { |f| require "#{Dir.pwd}/#{f}" }

RSpec.configure do |config|
  config.color = true

  config.fixture_path = 'spec/fabricators'

  config.use_transactional_fixtures = true

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.default_formatter = 'doc' if config.files_to_run.one?

  config.infer_spec_type_from_file_location!

  config.infer_base_class_for_anonymous_controllers = false

  config.filter_rails_from_backtrace!

  config.order = :random
end
