class User < ActiveRecord::Base

  has_many :sign_in_records
  validates :device_token, presence: true, uniqueness: true

end