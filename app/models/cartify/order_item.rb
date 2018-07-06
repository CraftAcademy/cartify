module Cartify
  class OrderItem < ApplicationRecord
    belongs_to :product, class_name: Cartify.product_class.to_s
    belongs_to :order
    has_one :order_status, through: :order
    has_one :category, through: :product, class_name: Cartify.product_class.to_s

    validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
    validate :product_present
    validate :order_present

    before_save :finalize
    default_scope { order(product_id: :asc) }

    def unit_price
      return self[:unit_price] if persisted?
      product.send(Cartify.price_attribute)
    end

    def total_price
      unit_price * quantity
    end

    private

    def product_present
      errors.add(:product, 'is not valid or is not active.') if product.nil?
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
