class Ticket < ApplicationRecord
  belongs_to :artist, optional: true 
  belongs_to :user, optional: true
  validates :venue, presence: true
  validates :seat, presence: true
  validates :comment, presence: true
  validates :user_id, presence: true
  validates :artist_id, presence: true
  validates :price, presence: true,numericality: { only_integer: true,less_than_or_equal_to: 100000,greater_than_or_equal_to: 0,message: "半角数字で入力してくだい" }
  is_impressionable
end
