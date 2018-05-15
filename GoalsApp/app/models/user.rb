class User < ApplicationRecord
  validates_presence_of :username, :password_digest, :session_token
  validates :password, length: {minimum: 6, allow_nil:true}
  before_validation :ensure_st
  
  attr_reader :password
  def password=(pw)
    @password = pw
    self.password_digest = BCrypt::Password.create(pw)
  end
  
  def is_password?(pw)
    BCrypt::Password.new(self.password_digest).is_password?(pw)
  end
  
  def generate_st
    SecureRandom.urlsafe_base64
  end
  
  def reset_st
    self.session_token = generate_st
    self.save
    self.session_token
  end
  
  def ensure_st
    self.session_token ||= generate_st
  end

  
  def self.find_by_credentials(u,pp)
    user = User.find_by_username(u)
    user && user.is_password?(pp) ? user : nil
  end
end
