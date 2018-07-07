require_dependency 'cartify/application_controller'

module Cartify
  class CheckoutController < Cartify::ApplicationController
    before_action :fast_authentification!
    include Wicked::Wizard
    include Showable
    include Updatable

    steps :login, :addresses, :delivery, :payment, :confirm, :complete

    def show
      return redirect_to main_app.public_send(Cartify.empty_cart_path), notice: "Please add some #{Cartify.product_class.to_s.pluralize(2).downcase} before attempting a checkout" if no_items_in_cart?
      send("show_#{step}") unless step == 'wicked_finish'
      render_wizard
    end

    def update
      current_order.update_attribute(:user, current_user) if current_step?(:addresses)
      send("update_#{step}")
      redirect_to next_wizard_path unless performed?
    end

    private

    def no_items_in_cart?
      current_order.order_items.empty? && !current_step?(:complete)
    end
  end
end
