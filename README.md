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
$ rails generate cartify:install --scope initializer
```
This will create the initializer for Cartify (`config/initializers/cartify.rb`).

You have 3 other options (`--scope`) you can put in to the generator:

```bash
--scope assets
--scope routes
--scope all
```

 `--scope routes` makes modifications to your routes table (`config/routes.rb`)
 
 `--scope assets` makes modifications to your JavaScript file (`app/assets/javascripts/application.js`) and CSS (`app/assets/stylesheets/application.css`).

 `--scope all` makes all above mentioned modifications.

Clone the necessay migrations:

```bash
$ rails cartify:install:migrations
```
Run the migrations:

```bash
$ rails db:migrate
```

Note that Cartify need to authenticate a user and depends on [Devise](https://github.com/plataformatec/devise). If you don't have a User model, generate a simple one to start with and configure Devise at a later stage.

```bash
$ rails g model user name:string
```

Modify your "User" model and define the necessary associations for Cartify:

```ruby
class User < ApplicationRecord
    has_many :orders, class_name: 'Cartify::Order', foreign_key: :user_id
    has_one :billing, class_name: 'Cartify::Billing', foreign_key: :user_id
    has_one :shipping, class_name: 'Cartify::Shipping', foreign_key: :user_id
    has_many :addresses, class_name: 'Cartify::Address', foreign_key: :user_id
end
```
Configure the Cartify initializer (found in `config/initializers/cartify.rb`) with the settings that suite your application structure:

```ruby
Cartify.product_class = 'Product'
Cartify.user_class = 'User'
Cartify.empty_cart_path = 'root_path'
Cartify.title_attribute = :name
Cartify.price_attribute = :price
```

If you did not run `rails generate cartify:install`, then make sure to mount Cartify as an engine in `config/routes.rb` and make sure you have a `show` action for your product class defined:

```ruby
Rails.application.routes.draw do
  mount Cartify::Engine, at: '/'
  resources :products, only: [:show]
end
```
Note, if you don't have a controller for your products, you can use a generator to create one (some of the Cartify view templates links to the show page of your product class.

```bash
$ rails g controller products show # or whatever class you use for products
```
## Helpers and Session

Cartify comes with some helper methods that will make it easy to integrate into your application's flow. 

Modify your `ApplicationController` to include the Cartify methods and helpers:

```ruby
class ApplicationController < ActionController::Base
    helper Cartify::Engine.helpers
    include Cartify::CurrentSession
end
```

### Available helpers
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

### Link to checkout
You can add a link to the Checkout process anywhere on your views. 

```
checkout_link
```

Will produce:

```html
<a id="checkout-link" href="/checkout">Checkout</a>
```

## Views
Cartify comes with a full set of views. If you want to modify them, you can copy selected ones to your application (`app/views/cartify`). The most relevant views are related to the checkout flow. You can copy them using a generator:

```
$ rails generate cartify:views
```

This generator comes with a custom flag: `scope`. You can use it to copy the vies, the partials or both:

```bash
To copy views:
$ rails generate cartify:views --scope checkout_views 

To copy partials:
$ rails generate cartify:views --scope checkout_partials

To copy both partials and views:
$ rails generate cartify:views --scope all 
```

Please note that the copied views are unstyled but include come css classes that are needed for the JavaScript to work (i.e. `.clickable-row`). **Do NOT remove them.** Doing so will break the Cartify functionality. 





## ToDo
* Move away from jQuery - refactor all js code to use vanilla JavaScript only


## License
This gem is based on the [initial Cartify gem](https://rubygems.org/gems/cartify/versions/0.1.0).
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
