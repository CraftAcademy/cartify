module Cartify
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../../templates', __FILE__)

    class_option :scope, type: :string, default: 'all'

    def setup
      @scope = options['scope']
      if @scope == 'all'
        copy_initializer_file
        install_js
        mount_engine
      elsif @scope == 'routes'
        mount_engine
      else
        puts 'Please enter a valid scope'
      end
    end

    private


    def copy_initializer_file
      copy_file 'initializer.rb', 'config/initializers/cartify.rb'
    end

    def install_js
      inject_into_file 'app/assets/javascripts/application.js',
                      before: "//= require_tree .\n" do
        <<~'JS'
          //= require jquery
          //= require cartify/application
        JS
      end
    end

    def mount_engine
      resources_class = Cartify.product_class.to_s.pluralize(2).downcase
      route "mount Cartify::Engine, at: '/'"
      route "resources :#{resources_class}, only: [:show]"
      
    end
  end
end
