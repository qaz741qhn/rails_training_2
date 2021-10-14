class Session < ApplicationRecord
  belongs_to :user
  after_update :login_streak_count

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

  def login_streak_count
    time_since_login = Time.now - self.updated_at
    if time_since_login.between?(1.day, 2.day)
      self.login_streak += 1
    else
      self.login_streak = 1
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
