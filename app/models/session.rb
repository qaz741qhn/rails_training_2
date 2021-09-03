class Session < ApplicationRecord
  belongs_to :user

  def self.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    token = Session.new_token
    update_attribute(:token_digest, Session.digest(token))
  end

  def authenticated?(token)
    return false if token_digest.nil?
    BCrypt::Password.new(token_digest).is_password?(token)
  end

  def forget
    update_attribute(:token_digest, nil)
  end

end
