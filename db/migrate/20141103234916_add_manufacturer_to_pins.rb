class AddManufacturerToPins < ActiveRecord::Migration
  def change
    add_column :pins, :manufacturer, :string
  end
end
