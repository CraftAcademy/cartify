require 'capybara/rspec'
# require 'capybara-webkit'
# require 'capybara/webkit/matchers'
require 'transactional_capybara/rspec'
#require 'factory_bot_rails'
require 'database_cleaner'
require "selenium-webdriver"
require 'chromedriver/helper'
Chromedriver.set_version '2.36' unless ENV['CI'] == 'true'

chrome_options = %w(no-sandbox disable-popup-blocking disable-infobars)
chrome_options << 'headless' if ENV['CI'] == 'true'

Capybara.register_driver :chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new(
      args: chrome_options
  )

  # Possible options to use
  # headless 
  # auto-open-devtools-for-tabs

  client = Selenium::WebDriver::Remote::Http::Default.new
  client.open_timeout = 100000
  client.read_timeout = 100000

  Capybara::Selenium::Driver.new(
      app,
      browser: :chrome,
      options: options, 
      http_client: client
  )
end

Capybara.javascript_driver = :chrome
Capybara.default_max_wait_time = 5
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.default_formatter = 'doc' if config.files_to_run.one?
  #config.include FactoryBot::Syntax::Methods
  config.before(:suite) do
    DatabaseCleaner.clean_with :truncation
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each) { DatabaseCleaner.start }
  config.after(:each) { DatabaseCleaner.clean }
end
