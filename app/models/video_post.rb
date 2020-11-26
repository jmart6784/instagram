class VideoPost < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  validates :caption, presence: true
  validates :caption, length: { maximum: 250 }
  # validates :clip, presence: true, unless: :body?
  # has_one_attached :clip, dependent: :destroy

  # validate :video_type, unless: ->(x) { x.clip.blank? }
  
  # private

  # def video_type
  #   if video.attached? && !video.content_type.in?(%(image/jpeg image/png))
  #     errors.add(:video, "must be a JPEG or PNG.")
  #   end
  # end
end
