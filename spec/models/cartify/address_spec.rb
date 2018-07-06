require 'rails_helper'

module Cartify
  RSpec.describe Address, type: :model do
    include_examples 'address_validations'

    describe 'scopes' do
      before(:all) { create_list(:address, 6) }

      describe 'shipping' do
        subject { Address.shipping }

        it 'contain only one type of addresses' do
          expect(subject.map(&:type).uniq.size).to eq 1
        end

        it 'only shipping' do
          expect(subject.sample.type).to eq 'Cartify::Shipping'
        end
      end

      describe 'billing' do
        subject { Address.billing }

        it 'contain only one type of addresses' do
          expect(subject.map(&:type).uniq.size).to eq 1
        end

        it 'only shipping' do
          expect(subject.sample.type).to eq 'Cartify::Billing'
        end
      end
    end
  end
end
