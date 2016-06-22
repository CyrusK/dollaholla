class MakePinsAuctionable < ActiveRecord::Migration
  def change
    add_column :pins, :is_auction, :boolean
    add_column :pins, :auction_start_at, :datetime
    add_column :pins, :auction_end_at, :datetime
    add_column :pins, :reserve, :float
    add_column :pins, :minimum_bid, :float
  end
end
