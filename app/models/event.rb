class Event < ActiveRecord::Base
  attr_accessible :description, :dtend, :dtstart, :summary, :uid
end
