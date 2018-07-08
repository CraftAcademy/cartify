# user_class:      is a owner model name, change it to the class you are using!
Cartify.product_class = 'Product'

# product_class:   is a product model name, change it to the class you are using!
Cartify.user_class = 'User'

# empty_cart_path: it's a route where you will be redirected if empty cart and user try go to checkout. Default is 'root_path'
Cartify.empty_cart_path = 'root_path'

# tell Cartify what attributes to use
# the name of the product
Cartify.title_attribute = :name
# the price of the product
Cartify.price_attribute = :price 

# don't forget add:
# mount Cartify::Engine, at: '/'  # into routes.rb file
