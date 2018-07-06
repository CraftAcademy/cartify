FactoryBot.define do
  factory :product, class: 'Product' do
    transient do
      cost 555.55
    end

    sequence(:title) { |i| FFaker::Book.title + i.to_s }
    price 1.0

    after(:create) do |book, evaluator|
      book.price = evaluator.cost
    end
  end
end
