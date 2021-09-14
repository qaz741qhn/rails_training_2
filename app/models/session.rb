class Session < ApplicationRecord
  belongs_to :user

  def remember!
    token_digest = digest(new_token)
    update_attribute(:token_digest, token_digest)
    update_attribute(:expires_at, expires_at)
  end

  def authenticated?(token_digest)
    token_digest.nil? ? false : true
  end

  def forget!
    update_attribute(:token_digest, nil)
  end

  private

  def digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def new_token
    SecureRandom.urlsafe_base64
  end

  def expires_at
    Time.current.since(3.days)
  end

end
