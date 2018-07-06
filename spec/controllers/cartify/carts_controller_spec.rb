require 'rails_helper'

module Cartify
  RSpec.describe CartsController, type: :controller do
    routes { Cartify::Engine.routes }
    describe 'GET #show' do
      before { get :show }

      it 'assign @order_items' do
        expect(assigns(:order_items)).not_to be_nil
      end

      it 'return success response with show template' do
        expect(response).to be_successful
        expect(response).to render_template :show
      end
    end

    describe 'POST #update' do
      let!(:coupon) { create(:coupon, name: 'D12345678900000', value: 33.33) }

      it 'set coupon' do
        expect(controller).to receive(:coupon).at_least(:once)
        post :update
      end

      context 'fake coupon' do
        before { post :update, params: { name: 'invalid coupon' } }

        it 'redirect to Cart' do
          expect(response).to redirect_to cart_path
        end

        it 'show error message' do
          expect(flash[:notice]).to eq I18n.t('flash.fake_coupon')
        end
      end

      context 'valid coupon' do
        before { post :update, params: { name: 'D12345678900000' } }

        it 'redirect to Cart' do
          expect(response).to redirect_to cart_path
        end

        it 'show success message' do
          expect(flash[:notice]).to eq I18n.t('flash.coupon_applied')
        end
      end
    end
  end
end
