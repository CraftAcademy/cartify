module Cartify
  class Delivery < ApplicationRecord
    has_many :orders
    validates :name, :duration, :price, presence: true
    validates_length_of :name, in: 3..100
  end
end
