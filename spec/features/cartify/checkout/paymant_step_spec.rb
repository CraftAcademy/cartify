require 'rails_helper'

module Cartify
  RSpec.feature 'Paymant step', type: :feature do
    let(:user) { create(:customer) }

    before do
      create(:product)
      create(:delivery)
    end

    it 'allow pass paymant step', js: true do
      sign_in(user)
      allow_any_instance_of(Cartify::CheckoutController)
        .to receive(:no_items_in_cart?) { false }
      allow_any_instance_of(Cartify::Order)
        .to receive('delivery') { true }
      visit cartify.checkout_path(:payment)
      allow_any_instance_of(Cartify::Order)
        .to receive('credit_card') { true }

      expect(page).to have_content I18n.t('checkout.mm_yy')
      expect(page).to have_content I18n.t('checkout.name_on_card')
      expect(page).to have_content I18n.t('checkout.credit_card')
      expect(page).to have_content I18n.t('checkout.cart_number')
    end
  end
end
