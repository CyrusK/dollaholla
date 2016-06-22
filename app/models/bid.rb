# == Schema Information
#
# Table name: bids
#
#  id           :integer          not null, primary key
#  pin_id       :integer          not null
#  user_id      :integer          not null
#  quantity     :integer          default(1), not null
#  price        :float            not null
#  is_cancelled :boolean          default(FALSE), not null
#  created_at   :datetime
#  updated_at   :datetime
#

class Bid < ActiveRecord::Base
  belongs_to :pin
  belongs_to :user

  def cancel!
    self.is_cancelled = true
    self.save
  end

  def cancelled?
    self.is_cancelled
  end
end
