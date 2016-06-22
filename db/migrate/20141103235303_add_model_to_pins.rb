class AddModelToPins < ActiveRecord::Migration
  def change
    add_column :pins, :model, :string
  end
end
