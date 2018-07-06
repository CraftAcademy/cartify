require 'rails_helper'

module Cartify
  RSpec.describe OrderItem, type: :model do
    it { expect(subject).to belong_to :order }
    it { expect(subject).to validate_presence_of :quantity }
    it { expect(subject).to belong_to :order }

    let(:product) { create(:product, price: 12.66) }
    let(:params) { [:order_item, unit_price: 77.77, product_id: product.id, quantity: 2] }

    it 'return product price before adding to cart' do
      order_i = build(*params)
      expect(order_i.unit_price).to eq 12.66
    end

    it 'freeze price when order is saving' do
      order_i = create(*params)
      expect(order_i.unit_price).to eq 12.66
    end

    it 'return total price' do
      order_i = create(*params)
      expect(order_i.total_price).to eq 25.32
    end

    context 'callbacks' do
      it { expect(subject).to callback(:finalize).before(:save) }
    end
  end
end
