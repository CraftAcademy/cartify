require 'rails_helper'

module Cartify
  RSpec.describe OrdersController, type: :controller do
    routes { Cartify::Engine.routes }
    let(:user) { create(:customer) }
    let(:order) { create(:order, :delivered, user_id: user.id) }
    before { sign_in(user) }

    describe 'GET #index' do
      before { get :index }

      it 'assign @orders' do
        expect(assigns(:orders)).not_to be_nil
        expect(response).to render_template :index
      end

      it 'return http status success' do
        expect(response).to have_http_status(:ok)
      end
    end

    describe 'GET #show' do
      before { get :show, params: { id: order.id } }

      it 'assign @order' do
        expect(assigns(:order)).not_to be_nil
      end

      it 'return http status success' do
        expect(response).to have_http_status(:ok)
      end

      it 'render template show' do
        expect(response).to render_template :show
      end

      context 'order with status in_progress' do
        let(:order_in_progress) { create(:order, :in_progress, user_id: user.id) }
        before { get :show, params: { id: order_in_progress.id } }

        it 'return redirect status code' do
          expect(response).to have_http_status(:found)
        end
      end
    end
  end
end
