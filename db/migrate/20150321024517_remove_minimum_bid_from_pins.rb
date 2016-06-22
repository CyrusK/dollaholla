class RemoveMinimumBidFromPins < ActiveRecord::Migration
  def change
    remove_column :pins, :minimum_bid
  end
end
