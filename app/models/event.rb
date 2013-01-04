class Event < ActiveRecord::Base
  attr_accessible :description, :dtend, :dtstart, :summary, :user_id
  belongs_to :user
  validate :dtstart_before_dtend
  validate :valid_user_id
  validates :dtstart, :dtend, :summary, presence: true
 # scope :user_events, lambda {|id=6| where("user_id = ?", id)  }
  
  def dtstart_before_dtend
    if :dtstart.present? && :dtend.present? &&
      dtstart > dtend
      errors.add(:dtend, "can't be before start date" )
    end
  end
  
  def valid_user_id
    unless User.exists? user_id
      errors.add(:user_id, "not a valid user id")
    end
  end
  

  def self.user_events(id)
    if User.exists? id
     find(:all, :conditions => ["user_id = ?", id])
    end
  end
  
  def self.search(search, date_start, date_end, uid)
     date_start = to_Date(date_start)
     date_end = to_Date(date_end)

     @result_query = Event.where('user_id = ?', "#{uid}")
     if (date_start < date_end)
     @result_query = @result_query&Event.where('dtstart > ? AND dtstart < ?', "#{date_start}", "#{date_end}")
     end
     if search
       @result_query = @result_query&Event.where('summary LIKE ? OR description LIKE ?', "%#{search}%", "%#{search}%")
     end
     
 
  end
 #{:key1=>"2013", :key2=>"1", :key3=>"1", :key4=>"20", :key5=>"10"}
 #{:key1=>"2012", :key2=>"12", :key3=>"1", :key4=>"20", :key5=>"10"}
 
  def self.to_Date(date)
   # @retString = ""<<date.values[2];
    @retString = date.values[2].clone<<"."<<date.values[1].clone<<"."<<date.values[0].clone<<" "<<date.values[3].clone<<":"<<date.values[4].clone
   puts @retString
   @retVal = DateTime.parse(@retString)
    return @retVal
  end


end
