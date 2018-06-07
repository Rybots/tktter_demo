class User < ApplicationRecord
  has_one :devise_user, dependent: :destroy
  has_many :tickets, dependent: :destroy
  validates :screen_name, uniqueness: true, exclusion: { in: %w(privacy terms fav login signout my_page report devise_users :romaji / sell tickets edit_ticket update_ticket destroy_ticket users u screen_name name id), message: "(ID) に %{value} は使えません" }
end
