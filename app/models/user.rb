class User < ApplicationRecord
  has_one :session, dependent: :destroy
  has_many :diaries, dependent: :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }, presence: true
  has_secure_password

  def login_streak_count!
    if self.updated_at <= 2.days.ago.end_of_day || self.updated_at.to_date == self.created_at.to_date
      self.login_streak = 1
    elsif self.updated_at.between?(1.day.ago.beginning_of_day, 1.day.ago.end_of_day)
      self.login_streak += 1
    end
    self.save
  end

  def daily_login_count!
    if self.updated_at <= Time.current.prev_month.end_of_month || self.updated_at.to_date == self.created_at.to_date
      self.daily_logins = 1
    elsif self.updated_at.between?(Time.current.beginning_of_month, 1.day.ago.end_of_day)
      self.daily_logins += 1
    end
    self.save
  end

end
