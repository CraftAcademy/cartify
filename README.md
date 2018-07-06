# Cartify (custom version)

This gem is a resource to be user in the SlowFood Online Challenge from Week 4 of the Craft Academy Coding Bootcamp.

Shopping cart with a multi-step checkout, easily mounted into Rails application.

# Note: The following instructions are WIP and dont include the Checkout functionality!
## Installation
Add this line to your application's Gemfile:

```ruby
gem 'cartify', github: 'CraftAcademy/cartify', branch: 'rails_5_2'
```

And then execute:
```bash
$ bundle
```

## Configuration and usage
Run initializer:
```bash
$ rails g initializer
```
Clone migrations:
```bash
$ rails cartify:install:migrations
```
Run the migrations:
```bash
$ rails db:migrate
```

If you don't have a User model, generate a simple one:
```bash
$ rails g model user name:string
```

Define associations in your "User" model:
```ruby
class User < ApplicationRecord
    has_many :orders, class_name: 'Cartify::Order', foreign_key: :user_id
    has_one :billing, class_name: 'Cartify::Billing', foreign_key: :user_id
    has_one :shipping, class_name: 'Cartify::Shipping', foreign_key: :user_id
    has_many :addresses, class_name: 'Cartify::Address', foreign_key: :user_id
end
```
Configure the Cartify initializer (found in `config/initializers/cartify.rb`)
```ruby
Cartify.product_class = 'Product'
Cartify.user_class = 'User'
Cartify.empty_cart_path = 'cart_path'
Cartify.title_attribute = :name
Cartify.price_attribute = :price
```
Mount Cartify as an engine in `config/routes.rb` and make sure you have a `show` action for your product class defined:

```ruby
Rails.application.routes.draw do
  mount Cartify::Engine, at: '/'
  resources :products, only: [:show]
end
```


Note, if you don't have a controller for your products, you can use a generator to create one:

```bash
$ rails g controller products show
```

Modify your `ApplicationController` to include the Cartify methods and helpers:

```ruby
class ApplicationController < ActionController::Base
    helper Cartify::Engine.helpers
    include Cartify::CurrentSession
end
```

## Available helpers
  #### Shop icon helper
  ```ruby
  shop_icon_quantity
  ```
  Will produce:
  ```html
 <span class="shop-icon">
    <span class="shop-quantity" id="order-details">1 item</span>
  </span>
  ```
  #### Add to cart link helper
  ```ruby
  add_to_cart(product, quantity, button_name)
  # product -     name of your selling product (required!)
  # quantity -    how many goods you with put into cart (default: 1)
  # button_name - button name (default: "Add to cart")
  ```
  Or customize as you with:
  ```ruby
  'helper link':            cartify.order_items_path()
  'required params':        order_item: {quantity: quantity, product_id: product.id}
  'use method':             method: :post
  'asynchronously':         remote: true

  # Example:
    link_to cartify.order_items_path(order_item: {quantity: 7, product_id: product.id}), 
      { method: :post, remote: true }
   ```
## ToDo
* Move away from jQuery - refactor all js code to use vanilla JavaScript only
* Fix Authentication and OAuth functionality

## License
This gem is based on the [initial Cartify gem](https://rubygems.org/gems/cartify/versions/0.1.0).
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
