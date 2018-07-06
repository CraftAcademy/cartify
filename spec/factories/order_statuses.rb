FactoryBot.define do
  factory :order_status, class: 'Cartify::OrderStatus' do
    sequence(:name) { |i| "status_#{i}" }

    trait :delivered do
      name 'delivered'
    end

    trait :in_progtess do
      name 'in_progtess'
    end

    trait :in_queue do
      name 'in_queue'
    end
  end
end
