class CreateCartifyAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :cartify_addresses do |t|
      t.string :type
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :city
      t.integer :zip
      t.string :country
      t.string :phone
      t.integer :user_id, foreign_key: true
      t.references :order,
                    foreign_key: { to_table: :cartify_orders }
    end
  end
end
