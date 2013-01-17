class User < ActiveRecord::Base
  attr_accessible :email, :name , :password, :password_confirmation #, :password_hash
    attr_accessor :password
    before_save :encrypt_password
    
    has_many :events, :dependent => :destroy
    validates :name, :presence => true

    validates :password, :confirmation => true, length: { minimum: 5 }
    validates_presence_of :password, :on => :create
    validates :email, :format => { with:/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
    validates_uniqueness_of :email

  def self.authenticate(email, password)
    user = find_by_email(email)
    #if defined? user.password_hash
      if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
        user
 #     end
      else
        nil
      end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)			
    end
  end
end
