class User < ActiveRecord::Base

  has_many :sign_in_records
  has_many :tracked_users
  validates :device_token, presence: true, uniqueness: true

  def self.find_by_token(token)
    user = User.find_by(device_token: token)
  end

end
