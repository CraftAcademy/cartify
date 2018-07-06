module Cartify
  class AddressesController < Cartify::ApplicationController
    def index
      @addresses = Cartify::AddressesForm.new(user_id: cartify_current_user.id)
    end

    def create
      @addresses = Cartify::AddressesForm.new(addresses_params)
      render :index, object: @addresses.errors
    end

    private

    def addresses_params
      params.require(:addresses_form)
    end
  end
end
