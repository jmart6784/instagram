class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :saved_posts, dependent: :destroy

  validates :caption, presence: true
  validates :caption, length: { maximum: 250 }

  has_one_attached :media, dependent: :destroy
  validates :media, presence: true

  validate :media_type, unless: ->(x) { x.media.blank? }
  
  private

  def media_type
    if media.attached? && !media.content_type.in?(%(image/jpeg image/png))
      errors.add(:media, "must be a JPEG or PNG.")
    end
  end
end
