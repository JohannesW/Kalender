class User < ActiveRecord::Base
  attr_accessible :email, :name, :pw, :uid
end
