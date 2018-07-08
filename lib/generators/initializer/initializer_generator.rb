module Cartify
class InitializerGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def copy_initializer_file
    copy_file 'initializer.rb', 'config/initializers/cartify.rb'
  end

  def install_js
    inject_into_file 'app/assets/javascripts/application.js',
                     before: "//= require_tree .\n" do
      <<~'JS'
        //= require jquery
        //= require cartify/application.js
      JS
    end
  end
end
end
