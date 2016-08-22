class User < ApplicationRecord
  #确保删除用户的同时删除微博
  has_many :microposts, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :passive_relationships,class_name: "Relationship",
                                  foreign_key: "followed_id",
                                  dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
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

  #关注另一个用户
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end
  #取消关注一个用户
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end
  #如果当前用户关注了指定的用户，返回　true
  def following?(other_user)
    following.include?(other_user)
  end
end
