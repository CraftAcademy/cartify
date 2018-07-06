require 'rails_helper'

module Cartify
  RSpec.feature 'settings Addresses tab', type: :feature do
    let(:user) { create(:customer) }

    before do
      sign_in(user)
      visit cartify.settings_addresses_path
    end

    it 'render addresses page' do
      expect(page.current_path).to eq cartify.settings_addresses_path
    end

    it 'hass right fields' do
      expect(page).to have_content I18n.t('settings.use_billing')
      expect(page).to have_content I18n.t('settings.billing')
      expect(page).to have_content I18n.t('settings.shipping')
    end
  end
end
