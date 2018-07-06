require 'rails_helper'

module Cartify
  RSpec.describe AddressesController, type: :controller do
    routes { Cartify::Engine.routes }
    let!(:user) { create(:customer) }
    before { sign_in(user) }

    describe 'GET #index' do
      before { get :index }

      it 'return a success response' do
        expect(response).to be_successful
        expect(response).to render_template :index
      end

      it 'assign @addresses' do
        expect(assigns(:addresses)).not_to be_nil
      end
    end

    describe 'POST #create' do
      let(:address) { attributes_for(:address) }
      let(:addresses_aprams) { { billing: address, shipping: address } }
      before { post :create, params: { addresses_form: addresses_aprams } }

      it 'assign @addresses' do
        expect(assigns(:addresses)).not_to be_nil
      end

      it 'return a success response' do
        expect(response).to be_successful
      end

      it 'render index' do
        expect(response).to render_template :index
      end
    end
  end
end
