FactoryBot.define do
  ADDRESSES_TYPE = %w[Cartify::Billing Cartify::Shipping].freeze

  factory :address, class: 'Cartify::Address' do
    type { ADDRESSES_TYPE.sample }
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.html_safe_last_name }
    address { FFaker::AddressUS.street_address.gsub(/[\W_]/, '') }
    city { FFaker::AddressUS.city.gsub(/[\W_]/, '') }
    zip { FFaker::AddressUS.zip_code }
    country { FFaker::AddressUS.country.gsub(/[\W_]/, '') }
    phone '+12345678910'
  end
end
