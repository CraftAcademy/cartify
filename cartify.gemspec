
$:.push File.expand_path('../lib', __FILE__)

require 'cartify/version'

Gem::Specification.new do |s|
  s.name        = 'cartify'
  s.version     = Cartify::VERSION
  s.authors     = ['Eugene']
  s.email       = ['Re4port@ukr.net']
  s.homepage    = 'https://github.com/GalenkoNeon/cartify'
  s.summary     = 'Simple shopping cart.'
  s.description = %q(Shopping cart with a multi-step checkout,
                     easily mounted into Rails application.)
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '~> 5.1', '>= 5.2'
  s.add_dependency 'virtus', '~> 1.0', '>= 1.0.5'
  s.add_dependency 'wicked', '~> 1.3', '>= 1.3.2'
  s.add_dependency 'jquery-rails', '~> 4.3', '>= 4.3.1'
  s.add_dependency 'country_select', '~> 3.1'
  s.add_dependency 'draper', '~> 3.0'
  s.add_dependency 'jquery_mask_rails', '~> 0.1'
  s.add_dependency 'haml-rails', '~> 1.0'
  s.add_dependency 'devise', '~> 4.3'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'pry-byebug', '~> 3.5'
  s.add_development_dependency 'rubocop', '~> 0.50'
  s.add_development_dependency 'factory_bot_rails', '~> 4.8.2'
  s.add_development_dependency 'capybara', '~> 2.14', '>= 2.14.4'
  s.add_development_dependency 'capybara-webkit', '~> 1.1'
  s.add_development_dependency 'database_cleaner', '~> 1.6'
  s.add_development_dependency 'ffaker', '~> 2.6', '>= 2.6.0'
  s.add_development_dependency 'shoulda-callback-matchers', '~> 1.1', '>= 1.1.4'
  s.add_development_dependency 'shoulda-matchers', '~> 3.1'
  s.add_development_dependency 'transactional_capybara', '0.2'
  s.add_development_dependency 'rspec-rails', '~> 3.7.2'
  s.add_development_dependency 'sass-rails', '~> 5.0'
  s.add_development_dependency 'launchy'
end
