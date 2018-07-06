require 'rails_helper'

module Cartify
  RSpec.feature 'Addresses step', type: :feature do
    let(:user) { create(:customer) }

    before do
      create(:product)
      create(:delivery)
    end

    it 'allow pass addresses step', js: true do
      sign_in(user)
      allow_any_instance_of(Cartify::CheckoutController)
        .to receive(:no_items_in_cart?) { false }
      visit cartify.checkout_path(:addresses)
      allow_any_instance_of(Cartify::Order)
        .to receive_message_chain('addresses.presence') { true }

      within('form#new_addresses_form') do
        fill_in 'addresses_form[billing][first_name]', with: 'Monica'
        fill_in 'addresses_form[billing][last_name]', with: 'Bellucci'
        fill_in 'addresses_form[billing][address]', with: 'West 999'
        fill_in 'addresses_form[billing][city]', with: 'NY'
        fill_in 'addresses_form[billing][zip]', with: '32158'
        select('Spain', from: 'addresses_form[billing][country]')
        fill_in 'addresses_form[billing][phone]', with: '+112 34 567 8998'

        fill_in 'addresses_form[shipping][first_name]', with: 'Monica'
        fill_in 'addresses_form[shipping][last_name]', with: 'Bellucci'
        fill_in 'addresses_form[shipping][address]', with: 'West 999'
        fill_in 'addresses_form[shipping][city]', with: 'NY'
        fill_in 'addresses_form[shipping][zip]', with: '32158'
        select('Spain', from: 'addresses_form[billing][country]')
        fill_in 'addresses_form[shipping][phone]', with: '+112 34 567 8998'

        find('input[name="commit"]').click
      end

      expect(page.current_path).to eq cartify.checkout_path(:delivery)
    end
  end
end
