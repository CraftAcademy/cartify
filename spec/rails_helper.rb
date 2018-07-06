require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../dummy/config/environment', __FILE__)
abort('The Rails environment is running in production mode!') if Rails.env.production?
if ENV['RAILS_ENV'] == 'test'
  require 'simplecov'
  SimpleCov.start 'rails'
  puts 'required simplecov'
end
require 'rspec/rails'
require 'capybara/rails'
require 'shoulda/matchers'
require 'ffaker'
require 'rails-controller-testing'
require 'shoulda-callback-matchers'
require 'factory_bot_rails'
#FactoryBot.definition_file_paths << File.join(File.dirname(__FILE__), 'factories')
#FactoryBot.find_definitions

REQUIRED_DIRS = %w[
  support
  features/cartify/shared_examples
  models/cartify/shared_examples
].freeze

REQUIRED_DIRS.each do |path|
  Dir[Rails.root.sub('dummy', "/#{path}/**/*.rb")].each { |f| require f }
end

RSpec.configure do |config|
  config.include TransactionalCapybara::AjaxHelpers
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include DeviseRequestSpecHelpers, type: :feature
  config.include FormHelpers, type: :feature
  config.include Features::SessionHelpers, type: :feature
  config.include Shoulda::Matchers::ActiveModel, type: :model
  config.include Shoulda::Matchers::ActiveRecord, type: :model
  config.include Shoulda::Callback::Matchers::ActiveModel
  config.include FactoryBot::Syntax::Methods
  config.include Capybara::Webkit::RspecMatchers, type: :feature
  config.include InjectSession, type: :feature
end
