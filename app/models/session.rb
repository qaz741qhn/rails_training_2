class Session < ApplicationRecord
  belongs_to :user
  after_create :login_streak_count

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
    last_login = self.updated_at.to_date
    yesterday = Time.now.yesterday.to_date
    streak_count = 0
    streak_count += 1 if last_login == yesterday
    update_attribute(:login_streak, streak_count)
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
