class Session < ApplicationRecord
  belongs_to :user

  def digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    token = new_token
    token_digest = digest(token)
    update_attribute(:token_digest, token_digest)
    update_attribute(:expires_at, expires_at)
  end

  def authenticated?(token_digest)
    token_digest.nil? ? false : true
  end

  def forget
    update_attribute(:token_digest, nil)
  end

  private

  def expires_at
    now = Time.current
    now.since(3.days)
  end

end
