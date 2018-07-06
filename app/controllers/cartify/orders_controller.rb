require_dependency 'cartify/application_controller'

module Cartify
  class OrdersController < Cartify::ApplicationController
    before_action :cartify_authenticate_user!

    def index
      all_in_one = cartify_current_user.orders.includes(:delivery, :order_status, :order_items)
      @orders = Cartify::OrdersQuery.new(all_in_one).run(params[:filter]).decorate
    end

    def show
      @order = cartify_current_user.orders.find(params[:id]).decorate
      redirect_to checkout_path(:confirm) if @order.status == t('order.status.in_progress')
    end
  end
end
