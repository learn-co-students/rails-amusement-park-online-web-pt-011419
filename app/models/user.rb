class User < ActiveRecord::Base
  has_many :rides
  has_many :attractions, through: :rides
  # validates :name, :password_digest, presence: true
  # validates :nausea, :happiness, length: { in: 1..5 }
  has_secure_password

  def mood
    if self.happiness > self.nausea
      "happy"
    else
      "sad"
    end
  end

end
