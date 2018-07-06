require 'rails_helper'

module Cartify
  RSpec.describe CheckoutController, type: :controller do
    routes { Cartify::Engine.routes }
    let!(:user) { create(:customer) }
    before { sign_in(user) }

    describe 'GET #show' do
      let!(:order) { create(:order, :in_progress, :with_order_item, user_id: user.id) }

      describe 'addresses tab' do
        before { get :show, params: { id: :addresses } }

        it 'render addresses view' do
          expect(response).to render_template :addresses
        end

        it 'assign @addresses' do
          expect(assigns(:addresses)).not_to be_nil
        end

        it 'return http success' do
          expect(response).to have_http_status(:success)
        end
      end

      describe 'delivery tab' do
        before do
          create(:address, order_id: order.id)
          get :show, params: { id: :delivery }
        end

        it 'render delivery view' do
          expect(response).to render_template :delivery
        end

        it 'assign @deliveries' do
          expect(assigns(:deliveries)).not_to be_nil
        end

        it 'return http success' do
          expect(response).to have_http_status(:success)
        end
      end

      describe 'payment tab' do
        before { get :show, params: { id: :payment } }

        it 'render payment view' do
          expect(response).to render_template :payment
        end

        it 'assign @credit_card' do
          expect(assigns(:credit_card)).not_to be_nil
        end

        it 'return http success' do
          expect(response).to have_http_status(:success)
        end
      end

      describe 'confirm tab' do
        let(:credit_card) { create(:credit_card) }
        before do
          order.update(credit_card_id: credit_card.id)
          get :show, params: { id: :confirm }
        end

        it 'render confirm view' do
          expect(response).to render_template :confirm
        end

        it 'return http success' do
          expect(response).to have_http_status(:success)
        end
      end

      describe 'complete tab' do
        before do
          get :show, params: { id: :complete }, flash: { complete_order: true }
        end

        it 'render complete view' do
          expect(response).to render_template :complete
        end

        it 'assign @order' do
          expect(assigns(:order)).not_to be_nil
        end

        it 'return http success' do
          expect(response).to have_http_status(:success)
        end
      end
    end

    describe 'PUT #update' do
      let!(:order) { create(:order, :in_progress, :with_order_item, user_id: user.id) }

      describe 'addresses' do
        before do
          allow(AddressesForm).to receive(:new) { build(:address) }
          put :update, params: { id: :addresses, addresses_form: true }
        end

        it 'assign @addresses' do
          expect(assigns(:addresses)).not_to be_nil
        end

        it 'return http found' do
          expect(response).to have_http_status(:found)
        end
      end

      describe 'delivery' do
        before do
          delivery = create(:delivery)
          put :update, params: { id: :delivery, order: { delivery_id: delivery.id } }
        end

        it 'return http found' do
          expect(response).to have_http_status(:found)
        end
      end

      describe 'payment' do
        before do
          credit_card_attributes = attributes_for(:credit_card)
          put :update, params: { id: :payment, credit_card: credit_card_attributes }
        end

        it 'assign @credit_card' do
          expect(assigns(:credit_card)).not_to be_nil
        end

        it 'return http found' do
          expect(response).to have_http_status(:found)
        end
      end

      describe 'confirm' do
        before do
          put :update, params: { id: :confirm }
        end

        it 'set flash[:complete_order]' do
          expect(flash[:complete_order]).to eq true
        end

        it 'return http found' do
          expect(response).to have_http_status(:found)
        end

        it 'clear order_id from session' do
          expect(session[:order_id]).to be_nil
        end
      end
    end
  end
end
