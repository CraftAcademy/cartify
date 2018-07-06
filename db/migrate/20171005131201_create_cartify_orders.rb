class CreateCartifyOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :cartify_orders do |t|
      t.decimal :subtotal, precision: 8, scale: 2
      t.decimal :total, precision: 8, scale: 2
      t.integer :user_id, foreign_key: true
      t.references :order_status,
                    foreign_key: { to_table: :cartify_order_statuses }
      t.references :coupon,
                    foreign_key: { to_table: :cartify_coupons }
      t.references :delivery,
                    foreign_key: { to_table: :cartify_deliveries }
      t.references :credit_card,
                    foreign_key: { to_table: :cartify_credit_cards }

      t.timestamps
    end
  end
end
