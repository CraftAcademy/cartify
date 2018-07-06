FactoryBot.define do
  factory :delivery, class: 'Cartify::Delivery' do
    name { %w[train bus plain telepor].sample }
    price 777.0
    duration 'infinity..'
  end
end
