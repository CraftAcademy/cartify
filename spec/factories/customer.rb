FactoryBot.define do
  factory :customer do
    email      { FFaker::Internet.email }
    password   { FFaker::Internet.password }
  end
end
