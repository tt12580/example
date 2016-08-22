class User < ApplicationRecord
  #确保删除用户的同时删除微博
  has_many :microposts,dependent: :destroy
  before_save { self.email = email.downcase }
  validates :name,presence: true,length:{ maximum:50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,presence: true,length:{ maximum:144 },
                  format: { with: VALID_EMAIL_REGEX },
                  uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password,presence: true,length:{ minimum:5},allow_nil: true

  def feed
    Micropost.where("user_id = ?",id)
  end
end
