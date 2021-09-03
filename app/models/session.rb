class Session < ApplicationRecord
  belongs_to :user
  attr_accessor :remember_token

  def self.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = Session.new_token
    update_attribute(:remember_digest, Session.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

end
