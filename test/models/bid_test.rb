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

require 'test_helper'

class BidTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
