module Cartify
  class Order < ApplicationRecord
    belongs_to :order_status
    belongs_to :coupon, optional: true
    belongs_to :user, class_name: Cartify.user_class.to_s, optional: true
    belongs_to :delivery, optional: true
    belongs_to :credit_card, optional: true
    has_many :order_items, dependent: :destroy
    has_many :addresses, dependent: :destroy
    has_one :billing
    has_one :shipping
    has_many Cartify.product_class.to_s.downcase.pluralize(2).to_sym, class_name: Cartify.product_class.to_s, through: :order_items
    before_validation :set_order_status, on: :create
    before_save :update_subtotal, :update_total, :connect_to_user

    scope :where_status, ->(status_name) { joins(:order_status).where(cartify_order_statuses: { name: status_name }) }
    scope :processing_list, -> { joins(:order_status).where(cartify_order_statuses: { name: %i[in_queue in_progress in_delivery] }) }
    scope :processing_order, -> { where_status('in_queue').order('updated_at').last }
    scope :in_progress, -> { where_status('in_progress').first.try(:id) }

    def subtotal
      order_items.sum(&:total_price)
    end

    def total
      subtotal_item_total + shipping_price
    end

    def subtotal_item_total
      subtotal - discount
    end

    def discount
      coupon.try(:value) || 0.00
    end

    def shipping_price
      delivery.try(:price) || 0.00
    end

    def finalize
      set_order_status :in_queue
      save!
    end

    private

    def set_order_status(status = :in_progress)
      self.order_status_id = Cartify::OrderStatus.find_or_create_by(name: status).id
    end

    def update_subtotal
      self[:subtotal] = subtotal
    end

    def update_total
      self[:total] = total
    end

    def connect_to_user
      self[:user_id] = CurrentSession.user.id unless CurrentSession.user.nil?
    end
  end
end
