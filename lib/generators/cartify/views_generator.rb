module Cartify
    class ViewsGenerator < Rails::Generators::Base
        source_root File.expand_path('../../templates', __FILE__)
        class_option :scope, type: :string, default: 'all'

        def setup
            @scope = options['scope']
            if @scope == 'all'
                copy_checkout_views
                copy_checkout_partials
            elsif @scope == 'checkout_views'
                copy_checkout_views
            elsif @scope == 'checkout_partials'
                copy_checkout_partials
            else
              puts 'Please enter a valid scope'
            end
        end

        private

        def copy_checkout_views
            template 'checkout/login.html.haml', 'app/views/cartify/checkout/login.html.haml'
        end

        def copy_checkout_partials

        end


     end
end