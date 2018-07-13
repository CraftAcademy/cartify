module Cartify
  class OrderItem < ApplicationRecord
    belongs_to Cartify.product_class.to_s.downcase.to_sym, class_name: Cartify.product_class.name
    belongs_to :order
    has_one :order_status, through: :order
    has_one :category, through: Cartify.product_class.to_s.downcase.to_sym, class_name: Cartify.product_class.to_s

    validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
    validate :product_present
    validate :order_present

    before_save :finalize
    default_scope { order("#{Cartify.product_class.to_s.downcase}_id".to_sym => :asc) }

    def unit_price
      return self[:unit_price] if persisted?
      send(Cartify.product_class.to_s.downcase.to_sym,).send(Cartify.price_attribute)
    end

    def total_price
      unit_price * quantity
    end

    private

    def product_present
      errors.add(Cartify.product_class.to_s.downcase.to_sym, 'is not valid or is not active.') if send(Cartify.product_class.to_s.downcase.to_sym).nil?
    end

    def order_present
      errors.add(:order, 'is not a valid order.') if order.nil?
    end

    def finalize
      self[:unit_price] = unit_price
      self[:total_price] = quantity * self[:unit_price]
    end
  end
end
