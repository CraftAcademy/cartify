FactoryBot.define do
  factory :order_item, class: 'Cartify::OrderItem' do
    product
    order
    unit_price 1.0
    quantity 1
    total_price 1.0
  end
end
