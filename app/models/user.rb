class User < ActiveRecord::Base
  attr_accessible :email, :name, :pw, :pw_confirmation
    has_many :events, :dependent => :destroy
    validates :name, :presence => true

    validates :pw, :confirmation => true, length: { minimum: 5 }
    validates :email, :format => { with:/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
end
