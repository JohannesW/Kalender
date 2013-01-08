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
  

  def self.user_events(uid)
    if User.exists? uid
     find(:all, :conditions => ["user_id = ?", uid])
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
  
  def self.this_day(uid)
   where('dtstart BETWEEN ? AND ? AND user_id = ?', DateTime.now.beginning_of_day, DateTime.now.end_of_day, "#{uid}")
  end
  
  def self.this_week(date, uid)
    unless date
      date = DateTime.now
    else
      date = Event.to_Date(date)
    end
    @date_start = date.clone.to_date.beginning_of_week
    @date_start = @date_start.to_datetime.beginning_of_day
    @date_end = date.clone.to_date.end_of_week
    @date_end = @date_end.to_datetime.end_of_day
    Event.where('dtstart BETWEEN ? AND ? AND user_id = ?', "#{@date_start}", "#{@date_end}", "#{uid}")

  end
  
  def self.begin_of_week(date)
    @offset = date.cwday
    (date - @offset)
  end
  
 #{:key1=>"2013", :key2=>"1", :key3=>"1", :key4=>"20", :key5=>"10"}
 #{:key1=>"2012", :key2=>"12", :key3=>"1", :key4=>"20", :key5=>"10"}
  def self.to_Date(date)
    @retString = date.values[2].clone<<"."<<date.values[1].clone<<"."<<date.values[0].clone<<" "<<date.values[3].clone<<":"<<date.values[4].clone
   @retVal = DateTime.parse(@retString)
    return @retVal
  end


end
