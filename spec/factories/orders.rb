FactoryBot.define do
  factory :order, class: 'Cartify::Order' do
    subtotal 1
    total 1
    order_status
    delivery
    credit_card_id nil
    user_id nil

    trait :in_progress do
      after(:create) do |order|
        order.order_status = Cartify::OrderStatus.find_by(name: :in_progress) ||
                             create(:order_status, :in_progress)
        order.save!
      end
    end

    trait :delivered do
      after(:create) do |order|
        order.order_status = Cartify::OrderStatus.find_by(name: :delivered) ||
                             create(:order_status, :delivered)
        order.save!
      end
    end

    trait :in_queue do
      after(:create) do |order|
        order.order_status = Cartify::OrderStatus.find_by(name: :in_queue) ||
                             create(:order_status, :in_queue)
        order.save!
      end
    end

    trait :with_order_item do
      after(:create) do |order|
        order.order_items = create_list(:order_item, 2)
        order.save!
      end
    end
  end
end
