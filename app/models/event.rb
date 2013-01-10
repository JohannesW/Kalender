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
     Event.where("user_id = ?", uid).order("dtstart")
    end
  end
  
  def self.search(search, date_start, date_end, uid)
     date_start = to_Date(date_start)
     date_end = to_Date(date_end)

     @result_query = Event.where('user_id = ?', "#{uid}").order('dtstart')
     if (date_start < date_end)
     @result_query = @result_query&Event.where('dtstart > ? AND dtstart < ?', "#{date_start-1.day}", "#{date_end}").order('dtstart') # bugfix, damit startdate richtig ausgew�hlt wird: -1.day
     end
     if search
       @result_query = @result_query&Event.where('summary LIKE ? OR description LIKE ?', "%#{search}%", "%#{search}%").order('dtstart')
     end
     
 
  end
  
  def self.this_day(uid)
   where('dtstart BETWEEN ? AND ? AND user_id = ?', DateTime.now.beginning_of_day, DateTime.now.end_of_day, "#{uid}").order('dtstart')
  end
  
  def self.this_week(date, uid)
    unless date
      date = DateTime.now
    else
      date = Event.to_Date(date)
    end
    @date_start = date.clone.to_date.at_beginning_of_week
    puts @date_start
    @date_start = @date_start.clone.to_datetime
    puts @date_start
    @date_end = date.clone.to_date.end_of_week
    puts @date_end
    @date_end = @date_end.clone.to_datetime.end_of_day
    puts @date_end
    Event.where('dtstart BETWEEN ? AND ? AND user_id = ?', "#{@date_start-1.day}", "#{@date_end}", "#{uid}").order('dtstart')
  end
  
  def self.this_month(date, uid)
    unless date
      date = DateTime.now
    else
      date = Event.to_Date(date)
    end
    @date_start = date.clone.to_date.beginning_of_month
    @date_start = @date_start.clone.to_datetime
    puts @date_start
    @date_end = date.clone.to_date.end_of_month
    @date_end = @date_end.clone.to_datetime.end_of_day
    puts @date_end
    Event.where('dtstart BETWEEN ? AND ? AND user_id = ?', "#{@date_start-1.day}", "#{@date_end}", "#{uid}").order('dtstart')
  end

  
 #{:key1=>"2013", :key2=>"7", :key3=>"1", :key4=>"00", :key5=>"10"} => 1.7.2012
 #{:key1=>"2012", :key2=>"12", :key3=>"1", :key4=>"20", :key5=>"10"}
  def self.to_Date(date)
    @retString = date.values[2].clone<<"."<<date.values[1].clone<<"."<<date.values[0].clone<<" "<<date.values[3].clone<<":"<<date.values[4].clone
   @retVal = DateTime.parse(@retString)
    return @retVal
  end


end

