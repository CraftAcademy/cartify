require 'rails_helper'

module Cartify
  RSpec.describe CartsHelper, type: :helper do
    describe '#add_to_cart' do
      let(:product) { create(:product) }

      it 'generate link "Add to cart" by default' do
        expect(helper.add_to_cart(product)).to have_link('Add to cart')
      end

      it 'name can be changed' do
        expect(helper.add_to_cart(product, 1, 'Bla bla')).to have_link('Bla bla')
      end

      it 'quantity can be changed' do
        expect(helper.add_to_cart(product)).to match('=1')
        expect(helper.add_to_cart(product, 3)).to match('=3')
      end

      it 'remote: true link' do
        expect(helper.add_to_cart(product)).to match('data-remote=\"true')
      end
    end
  end
end
