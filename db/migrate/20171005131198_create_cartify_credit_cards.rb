class CreateCartifyCreditCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cartify_credit_cards do |t|
      t.string :number
      t.string :name
      t.string :mm_yy
      t.string :cvv

      t.timestamps
    end
  end
end
