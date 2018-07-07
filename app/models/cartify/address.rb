module Cartify
  class Address < ApplicationRecord
    belongs_to :user, class_name: Cartify.user_class.to_s, optional: true
    belongs_to :order, optional: true

    scope :shipping, -> { where(type: 'Cartify::Shipping') }
    scope :billing, -> { where(type: 'Cartify::Billing') }

    validates :first_name, :last_name, :address, :city, :zip, :country, :phone, presence: true
    validates_length_of :first_name, :last_name, :address, :city, :country, maximum: 49
    validates :first_name, :last_name, format: { with: /\A[A-Za-z]{0,49}\z/ }
    validates_presence_of :city, :country
    #validates :city, :country, format: { with: /\A[A-Za-z\s]{0,49}\z/ }
    #validates :address, format: { with: /\A[-A-Za-z\s\d,]{0,49}\z/ }

    validates_length_of :phone, maximum: 15
    validates_length_of :zip, maximum: 10
    before_validation :clear_mask

    def clear_mask
      phone&.gsub!(/[-\s()]/, '')
    end
  end
end
