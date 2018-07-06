require 'rails_helper'

module Cartify
  RSpec.describe OrderItemsController, type: :controller do
    routes { Cartify::Engine.routes }
    let!(:user) { create(:customer) }
    let!(:order) { create(:order, :in_progress, :with_order_item, user_id: user.id) }
    let(:product) { create(:product) }
    before { sign_in(user) }

    describe 'POST #create' do
      let(:create_params) { { order_item: { product_id: product.id, quantity: 1 } } }
      before { post :create, xhr: true, params: create_params }

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'assign order_id to session' do
        expect(session[:order_id]).to eq order.id
      end
    end

    describe 'PUT #update' do
      let(:update_params) do
        { id: order.order_items.first.id, order_item: { quantity: 2 } }
      end
      before { put :update, xhr: true, params: update_params }

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'assign @order_items' do
        expect(assigns(:order_items)).to match_array(order.order_items)
      end
    end

    describe 'DELETE #destroy' do
      it 'returns http success' do
        delete :destroy, xhr: true, params: { id: order.order_items.last.id }
        expect(response).to have_http_status(:success)
      end
    end
  end
end
