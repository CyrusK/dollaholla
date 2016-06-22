class MoreAttachmentsForPins < ActiveRecord::Migration
  def self.up
    change_table :pins do |t|
      t.attachment :image2
      t.attachment :image3
      t.attachment :image4
      t.attachment :image5
    end
  end

  def self.down
    remove_attachment :pins, :image2
    remove_attachment :pins, :image3
    remove_attachment :pins, :image4
    remove_attachment :pins, :image5
  end
end
