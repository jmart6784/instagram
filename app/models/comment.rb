class Comment < ApplicationRecord
  belongs_to :post
  has_many :likes, as: :likeable, dependent: :destroy

  validates :body, presence: true
  validates :body, length: { maximum: 5000 }
end
