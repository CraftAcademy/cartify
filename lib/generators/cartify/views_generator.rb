module Cartify
    class ViewsGenerator < Rails::Generators::Base
        source_root File.expand_path('../../templates', __FILE__)
        class_option :scope, type: :string, default: 'checkout_views'

        def setup
            @scope = options['scope']
            if @scope == 'all'
                copy_checkout_views
                copy_checkout_partials
            elsif @scope == 'checkout_views'
                copy_checkout_views
            elsif @scope == 'unstyled'
                copy_unstyled_checkout_views
            elsif @scope == 'checkout_partials'
                copy_checkout_partials
            else
              puts 'Please enter a valid scope'
            end

        end

        private

        def copy_checkout_views
            template 'checkout/login.html.haml', 'app/views/cartify/checkout/login.html.haml'
            template 'checkout/addresses.html.haml', 'app/views/cartify/checkout/addresses.html.haml'
            template 'checkout/confirm.html.haml', 'app/views/cartify/checkout/confirm.html.haml'
            template 'checkout/delivery.html.haml', 'app/views/cartify/checkout/delivery.html.haml'
            template 'checkout/complete.html.haml', 'app/views/cartify/checkout/complete.html.haml'
        end

        def copy_checkout_partials
            # in views folder
            template 'checkout/_order_summary.haml', 'app/views/cartify/checkout/_order_summary.html.haml'
            template 'checkout/_progress.haml', 'app/views/cartify/checkout/_progress.html.haml'

            # in partials folder
            template 'checkout/partials/_addresses_short.haml', 'app/views/cartify/checkout/partials/_addresses_short.html.haml'
            template 'checkout/partials/_delivery-lg.haml', 'app/views/cartify/checkout/partials/_delivery-lg.html.haml'
            template 'checkout/partials/_delivery-xs.haml', 'app/views/cartify/checkout/partials/_delivery-xs.html.haml'
            template 'checkout/partials/_list_of_items.haml', 'app/views/cartify/checkout/partials/_list_of_items.html.haml'
        end

        def copy_unstyled_checkout_views
            # views
            template 'unstyled/checkout/login.html.haml', 'app/views/cartify/checkout/login.html.haml'
            template 'unstyled/checkout/addresses.html.haml', 'app/views/cartify/checkout/addresses.html.haml'
            template 'unstyled/checkout/confirm.html.haml', 'app/views/cartify/checkout/confirm.html.haml'
            template 'unstyled/checkout/delivery.html.haml', 'app/views/cartify/checkout/delivery.html.haml'
            template 'unstyled/checkout/complete.html.haml', 'app/views/cartify/checkout/complete.html.haml'

            # partials in views folder
            template 'unstyled/checkout/_order_summary.haml', 'app/views/cartify/checkout/_order_summary.html.haml'
            template 'unstyled/checkout/_progress.haml', 'app/views/cartify/checkout/_progress.html.haml'

            # partials in partials folder
            template 'unstyled/checkout/partials/_addresses_short.haml', 'app/views/cartify/checkout/partials/_addresses_short.html.haml'
            template 'unstyled/checkout/partials/_delivery-lg.haml', 'app/views/cartify/checkout/partials/_delivery-lg.html.haml'
            template 'unstyled/checkout/partials/_delivery-xs.haml', 'app/views/cartify/checkout/partials/_delivery-xs.html.haml'
            template 'unstyled/checkout/partials/_list_of_items.haml', 'app/views/cartify/checkout/partials/_list_of_items.html.haml'
            
        end
     end
end