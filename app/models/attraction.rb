class Attraction < ActiveRecord::Base
  has_many :rides
  has_many :users, through: :rides
  # validates :name, :tickets, :min_height, :nausea_rating, :happiness_rating, presence: true
  # validates :nausea_rating, :happiness_rating, length: { in: 1..5 }

end
