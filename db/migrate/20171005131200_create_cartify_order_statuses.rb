class CreateCartifyOrderStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :cartify_order_statuses do |t|
      t.string :name
    end
  end
end
