# == Schema Information
#
# Table name: pins
#
#  id                  :integer          not null, primary key
#  description         :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  user_id             :integer
#  image_file_name     :string(255)
#  image_content_type  :string(255)
#  image_file_size     :integer
#  image_updated_at    :datetime
#  manufacturer        :string(255)
#  model               :string(255)
#  image2_file_name    :string(255)
#  image2_content_type :string(255)
#  image2_file_size    :integer
#  image2_updated_at   :datetime
#  image3_file_name    :string(255)
#  image3_content_type :string(255)
#  image3_file_size    :integer
#  image3_updated_at   :datetime
#  image4_file_name    :string(255)
#  image4_content_type :string(255)
#  image4_file_size    :integer
#  image4_updated_at   :datetime
#  image5_file_name    :string(255)
#  image5_content_type :string(255)
#  image5_file_size    :integer
#  image5_updated_at   :datetime
#  is_auction          :boolean
#  auction_start_at    :datetime
#  auction_end_at      :datetime
#  reserve             :float
#  quantity            :integer          default(1)
#
# Indexes
#
#  index_pins_on_user_id  (user_id)
#

class Pin < ActiveRecord::Base
  belongs_to :user

  has_attached_file :image, :styles => { :medium => "400x400>", :thumb => "200x200>" }
  has_attached_file :image2, :styles => { :medium => "400x400>", :thumb => "200x200>" }
  has_attached_file :image3, :styles => { :medium => "400x400>", :thumb => "200x200>" }
  has_attached_file :image4, :styles => { :medium => "400x400>", :thumb => "200x200>" }
  has_attached_file :image5, :styles => { :medium => "400x400>", :thumb => "200x200>" }
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates_attachment_content_type :image2, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates_attachment_content_type :image3, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates_attachment_content_type :image4, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates_attachment_content_type :image5, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  validates :image, presence: true
  validates :description, presence: true
  validates :price, presence: true

  has_many :users
  has_many :bids

  def active_bids
    self.bids.where(is_cancelled: false).order("price DESC")
  end

  def cancelled_bids
    self.bids.where(is_cancelled: true).order("price DESC")
  end

  def bid_increment
    1.00
  end

  def bid_for(user)
    if user.nil?
      return nil
    end
    self.bids.where(is_cancelled: false, user_id: user.id).first
  end

  def is_multi?
    !self.quantity.nil? && self.quantity > 1
  end

  def minimum_bid
    bids_meet_reserve = false
    quantity_remaining = self.quantity
    lowest_price = self.reserve.nil? ? 1.00 : self.reserve
    self.active_bids.order("price DESC").each do |bid|
      if bid.price < lowest_price
        next
      end

      if bid.price >= self.reserve
        bids_meet_reserve = true
      end

      lowest_price = bid.price
      quantity_remaining -= bid.quantity
      if quantity_remaining < 0
        quantity_remaining = 0
        break
      end
    end

    if bids_meet_reserve && quantity_remaining <= 0
      return lowest_price + bid_increment
    else
      return self.reserve
    end
  end

  def time_to_auction

  end

  def is_auction_started?
    DateTime.now.to_f - self.auction_start_at.to_f > 0
  end

  def is_auction_ended?
    DateTime.now.to_f - self.auction_end_at.to_f > 0
  end

  def single_image_only?
    !self.image2_file_name &&
    !self.image3_file_name &&
    !self.image4_file_name &&
    !self.image5_file_name
  end
end
