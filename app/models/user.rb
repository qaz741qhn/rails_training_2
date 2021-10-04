class User < ApplicationRecord
  has_one :session, dependent: :destroy
  has_many :diaries, dependent: :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }, presence: true
  has_secure_password

end
