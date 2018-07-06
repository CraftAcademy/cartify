require 'cartify/engine'

module Cartify
  mattr_accessor :product_class
  mattr_accessor :user_class
  mattr_accessor :empty_cart_path
  mattr_accessor :title_attribute
  mattr_accessor :price_attribute

  def self.product_class
    @@product_class.constantize
  end

  def self.user_class
    @@user_class.constantize
  end

  def self.table_name_prefix
    'cartify_'
  end
end
