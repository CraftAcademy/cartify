FactoryBot.define do
  factory :credit_card, class: 'Cartify::CreditCard' do
    number '1234567891234567'
    name 'name on card'
    mm_yy '12/18'
    cvv 123
  end
end
