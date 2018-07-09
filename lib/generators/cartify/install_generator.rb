module Cartify
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../../templates', __FILE__)

    class_option :scope, type: :string, default: 'all'

    def setup
      @scope = options['scope']
      if @scope == 'all'
        copy_initializer_file
        configure_js
        configure_css
        configure_layout
        mount_engine
      elsif @scope == 'initializer'
        copy_initializer_file
      elsif @scope == 'routes'
        mount_engine
      elsif @scope == 'assets'
        configure_js
        configure_css
        configure_layout
      else
        puts 'Please enter a valid scope'
      end
    end

    private


    def copy_initializer_file
      copy_file 'initializer.rb', 'config/initializers/cartify.rb'
    end

    def configure_js
      inject_into_file 'app/assets/javascripts/application.js',
                      before: "//= require_tree ." do
        <<~'JS'
          //= require jquery
          //= require cartify/application
        JS
      end
    end

    def configure_layout
      inject_into_file 'app/views/layouts/application.html.haml',
                      after: "%body\n" do
        <<~'HAML'.indent(4) 
                  #notifications
                    = alert 
                    = notice
        HAML
      end
    end

    def configure_css
      inject_into_file 'app/assets/stylesheets/application.css',
                      before: "*= require_tree .\n" do
        <<~'JS'
          *= require cartify/application
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
