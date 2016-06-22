class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.integer :pin_id, null: false
      t.integer :user_id, null: false
      t.integer :quantity, null: false, default: 1
      t.float :price, null: false
      t.boolean :is_cancelled, null: false, default: false

      t.timestamps
    end
  end
end
