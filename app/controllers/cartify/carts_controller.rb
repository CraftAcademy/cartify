require_dependency 'cartify/application_controller'

module Cartify
  class CartsController < Cartify::ApplicationController
    def show
      @order_items = current_order.order_items
    end

    def update
      current_order.update_attributes(coupon_id: coupon.id) if coupon
      redirect_to cart_path, notice: coupon ? t('flash.coupon_applied') : t('flash.fake_coupon')
    end

    private

    def coupon
      @coupon ||= Cartify::Coupon.find_by(name: params[:name])
    end
  end
end
