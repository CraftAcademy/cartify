module Cartify
    class ViewsGenerator < Rails::Generators::Base
        source_root File.expand_path('../../templates', __FILE__)

        def copy_views
            template 'login.html.haml', 'app/views/cartify/checkout/login.html.haml'
        end
     end
end