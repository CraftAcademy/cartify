module Cartify
  class Engine < ::Rails::Engine
    require 'jquery-rails'
    require 'country_select'
    require 'jquery_mask_rails'
    require 'wicked'
    require 'virtus'
    require 'draper'
    require 'devise'
    require 'haml-rails'

    isolate_namespace Cartify

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
      g.stylesheets false
      g.javascripts false
      g.template_engine :haml
    end

    initializer :inject_helpers do
      ActiveSupport.on_load :action_controller do
        #::ApplicationController.send(:helper, Cartify::Engine.helpers)
        #::ApplicationController.send(:include, Cartify::CurrentSession)
      end
    end
  end
end
