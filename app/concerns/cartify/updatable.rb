module Cartify::Updatable
  extend ActiveSupport::Concern

  included do
    private

    def update_addresses
      @addresses = Cartify::AddressesForm.new(addresses_params)
       if @addresses.save
        jump_to(next_step)
       else
        array = @addresses.errors.values.map{|v| v.full_messages}
        flash[:alert] = array.join('<br>')
        render_wizard
       end
    end

    def update_delivery
      if current_order.update_attributes(order_params)
        jump_to(next_step)
      else
        flash[:notice] = t('delivery.pickup') if current_order.delivery_id.nil?
        render_wizard
      end
    end

    def update_payment
      @credit_card = Cartify::CreditCard.new(credit_card_params)
      if @credit_card.save
        jump_to(next_step)
      else
        render_wizard
      end

    end

    def update_confirm
      flash[:complete_order] = true
      session[:order_id] = nil if current_order.finalize
    end

    def order_params
      params.require(:order).permit(:delivery_id)
    end

    def credit_card_params
      params.require(:credit_card).permit(:number, :name, :mm_yy, :cvv)
    end

    def addresses_params
      params.require(:addresses_form)
    end
  end
end
