class Session < ApplicationRecord
  belongs_to :user

  def remember!
    token_digest = digest(new_token)
    update_attribute(:token_digest, token_digest)
    update_attribute(:expires_at, expires_after)
  end

  def authenticated?(token_digest)
    token_digest.nil? ? false : true
  end

  def forget!
    update_attribute(:token_digest, nil)
  end

  def login_streak_count!(login_streak)
    if self.updated_at.between?(1.day.ago.beginning_of_day, 1.day.ago.end_of_day)
      login_streak += 1
    elsif self.updated_at <= 2.days.ago.end_of_day || self.updated_at.to_date == self.created_at.to_date
      login_streak = 1
    end
  end

  private

  def digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def new_token
    SecureRandom.urlsafe_base64
  end

  def expires_after
    Time.current.since(3.days)
  end

end
