class CreateCartifyDeliveries < ActiveRecord::Migration[5.2]
  def change
    create_table :cartify_deliveries do |t|
      t.string :name
      t.string :duration
      t.decimal :price, precision: 8, scale: 2
    end
  end
end
