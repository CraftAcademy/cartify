require 'rails_helper'

module Cartify
  RSpec.feature 'End to end checkout process', type: :feature do
    let(:user) { create(:customer) }

    before do
      create(:product)
      create_list(:delivery, 3)
    end

    it 'allow to pass all steps in checkout', js: true do
      sign_in(user)
      visit root_path
      click_link I18n.t('checkout.add_to_cart')
      wait_for_ajax
      click_link I18n.t('checkout.cart')
      expect(page.current_path).to eq cartify.cart_path
      click_on I18n.t('cart.checkout')
      expect(page.current_path).to eq cartify.checkout_path(:addresses)

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
      all('.radio-label').first.click
      find('input[name="commit"]').click
      expect(page.current_path).to eq cartify.checkout_path(:payment)

      within('form#new_credit_card') do
        fill_in 'credit_card[number]', with: '1234 1234 1234 1234'
        fill_in 'credit_card[name]', with: 'Monica'
        fill_in 'credit_card[mm_yy]', with: '03/19'
        fill_in 'credit_card[cvv]', with: '123'

        find('input[name="commit"]').click
      end

      expect(page.current_path).to eq cartify.checkout_path(:confirm)

      find('input[type="submit"]').click
      expect(page.current_path).to eq cartify.checkout_path(:complete)
      expect(page).to have_content "An order confirmation has been sent to #{user.email.capitalize}"
    end
  end
end
