class AddQuantityToPins < ActiveRecord::Migration
  def change
    add_column :pins, :quantity, :integer, default: 1
  end
end
