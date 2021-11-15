class User < ApplicationRecord
  has_one :session, dependent: :destroy
  has_many :diaries, dependent: :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }, presence: true
  has_secure_password

  def login_streak_count!
    if self.updated_at >= Time.current - 1.day
      self.login_streak += 1
    elsif self.updated_at < Time.current - 1.day || self.updated_at.to_date == self.created_at.to_date
      self.login_streak = 1
    end
    self.save
  end

end
