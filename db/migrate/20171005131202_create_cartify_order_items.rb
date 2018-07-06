class CreateCartifyOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :cartify_order_items do |t|
      t.integer :quantity
      t.decimal :unit_price, precision: 8, scale: 2
      t.decimal :total_price, precision: 8, scale: 2
      t.integer :product_id, foreign_key: true
      t.references :order,
                    foreign_key: { to_table: :cartify_orders }

      t.timestamps
    end
  end
end
