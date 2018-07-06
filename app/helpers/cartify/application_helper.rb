module Cartify
  module ApplicationHelper
    def shop_icon_quantity
      qty = current_order.order_items.reload.collect(&:quantity).compact.sum
      if qty.zero?
        "<span class='shop-quantity' id='order-details'>You have not added any dishes yet!</span>".html_safe
      else
        "<span class='shop-quantity' id='order-details'>#{pluralize(qty, 'item')}</span>".html_safe
      end 
    end

    def active_class(link_path)
      return '' if request.GET.empty?
      link_path.include? request.GET.first.join('=') ? 'active' : ''
    end

    def country_name(object)
      country = ISO3166::Country[object.country]
      country.translations[I18n.locale.to_s] || country.name
    end

    def image_for(obj)
      begin
          obj.product_image 
      rescue => exception
          'https://vignette.wikia.nocookie.net/teenage-mutant-ninja-turtles-2012-series/images/f/fd/Pizza_trad_pepperoni.png/revision/latest?cb=20161106191944'
      end
    end
  end
end
