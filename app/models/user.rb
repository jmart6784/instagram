class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  VALID_USERNAME_REGEX = /\A[a-zA-Z0-9]+\z/
  validates :username, uniqueness: true, case_sensitive: false, presence: true, length: {minimum: 4, maximum: 16}, format: { with: VALID_USERNAME_REGEX }

  validates :first_name, :last_name, presence: true, length: { minimum: 2, maximum: 60 }

  validates :bio, length: { maximum: 1000 }
end
