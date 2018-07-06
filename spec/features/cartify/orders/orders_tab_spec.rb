require 'rails_helper'

module Cartify
  RSpec.feature 'Orders', type: :feature do
    let(:user) { create(:customer) }

    context 'User signed out' do
      it 'redirect to sign_in path' do
        visit cartify.orders_path
        expect(current_path).to eq '/customers/sign_in'
      end
    end

    context 'registered user' do
      before do
        create(:order, :delivered, user_id: user.id)
        sign_in(user)
        visit cartify.orders_path
      end

      it 'render orders page' do
        expect(page.current_path).to eq cartify.orders_path
      end

      it 'show order status' do
        within('table.table-hover') do
          expect(page).to have_content I18n.t('order.status.delivered')
        end
      end

      it 'show order number' do
        id = user.orders.first.id.to_s
        expect(page).to have_content 'R0000000'[0..-id.size] + id
      end

      it 'show filter links' do
        within('div.dropdowns.dropdown.general-order-dropdown') do
          expect(page).to have_content I18n.t('order.status.in_delivery')
          expect(page).to have_content I18n.t('order.status.canceled')
          expect(page).to have_content I18n.t('order.status.in_progress')
          expect(page).to have_content I18n.t('order.status.in_queue')
        end
      end
    end
  end
end
