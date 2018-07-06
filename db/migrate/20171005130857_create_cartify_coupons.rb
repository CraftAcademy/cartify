class CreateCartifyCoupons < ActiveRecord::Migration[5.2]
  def change
    create_table :cartify_coupons do |t|
      t.string :name
      t.decimal :value, precision: 8, scale: 2
    end
  end
end
