class Micropost < ApplicationRecord
  acts_as_paranoid
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate :picture_size
  scope :search_content, -> (content) { where("content like '%#{content}%'") if content.present? }
  scope :search_name, -> (name) { eager_load(:user).where("users.name like '%#{name}%'") if name.present? }
  scope :search_id, -> (id) { eager_load(:user).where("users.id": id) if id.present? }

  private

  def picture_size
    if picture.size > 5.megabytes
      error.add(:picture,"should be less than 5MB")
    end
  end
end
