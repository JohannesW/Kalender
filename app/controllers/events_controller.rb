class EventsController < ApplicationController

  #require "ri_cal"
  # GET /events
  # GET /events.json
  def index
    if "#{params[:uid]}" == "#{session[:user_id]}"
      @events = Event.user_events params[:uid]
      respond_to do |format|
          format.html { render 'events/index'}
          format.json { render text: @events.to_json }
      end
      
    else
      if session[:user_id]
          redirect_to user_events_url(:uid => session[:user_id]) 
      else
        redirect_to log_in_url
      end
    end
  end
  
  def this_day
    if session[:user_id] 
      if "#{params[:uid]}" == "#{session[:user_id]}"
        @events = Event.this_day(params[:uid])
        render "events/index"
      else
        redirect_to user_events_today_url(:uid => session[:user_id])
      end
    else
      redirect_to log_in_url
    end
  end
  
  def this_week
    if session[:user_id]
      if "#{params[:uid]}" == "#{session[:user_id]}"
        @events = Event.this_week(params[:date], params[:uid])
        render "events/index"
      else
        redirect_to user_events_week_url(:date => params[:date], :uid => session[:user_id])
      end
    else
      redirect_to log_in_url
    end
  end
  
  def this_month
    if session[:user_id]
      if "#{params[:uid]}" == "#{session[:user_id]}"
        @events = Event.this_month(params[:date], params[:uid])
        render "events/index"
      else
        redirect to user_events_month_url(:date => params[:date], :uid => session[:user_id])
      end
    else
      redirect_to log_in_url
    end
  end
  
  def get_json
   # render text: " #{params[:uid]},  #{params[:dtstart]},  #{params[:dtend]}" 
   #if params[:uid] && params[:dtstart] && params[:dtend]
   if params[:dtstart] && params[:dtend] && session[:user_id]
      @events = Event.get_events(params[:dtstart], params[:dtend], session[:user_id])
      events=[]
      @events.each do |event|
      events << {'id' => event.id, 'title' => event.summary, 'description' => event.description , 'start' => "#{event.dtstart.iso8601}", :end => "#{event.dtend.iso8601}",  :allDay => false} #strftime('%Y-%m-%d %H:%M:%S')
    end
   end
    render text: events.to_json 
    #"@events.to_json: #{@events.to_json}, #{params[:uid]},  #{params[:dtstart]},  #{params[:dtend]}"
  end
  
  def search
  @events = Event.search(params[:search],params[:dtstart],params[:dtend],params[:uid])
  params[:dtstart] = nil;   #bugfix -> exceeded available parameter key space
  params[:dtend] = nil      #bugfix -> exceeded available parameter key space
 
  respond_to do |format|
          format.html { render 'events/index'}
          format.json { render text: @events.to_json }
  end
  
  end

  
  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
    if @event
  
      respond_to do |format|
        format.html # show.html.erb
        format.json { render text: @event.to_json  }
   #     format.json ( render :json => @event )
   #       format.json  {render :partial => 'modal', :locals => {:event => @event}}
      end
    else redirect_to "events#index"
    end
  end

    
  
  # GET /events/new
  # GET /events/new.json
  def new
   if (params[:uid])
      @event = Event.new
      @event.user_id = params[:uid]
      render "new"
   end
  end 

  

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
    respond_to do |format|
      format.html { render "edit" }
#      format.js {redirect_to "window.location.href = 'events/' + <%= escape_javascript(params[:id]) %> + '/edit'"}
      #format.json {render text: "js"}
        #redirect_to user_edit_event_url(:id => params[:id]) }
    end
    
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event])
    if User.exists? @event.user_id
      u = User.find @event.user_id
      u.events << @event        # associates to user
    end
    
    respond_to do |format|
      if @event.save
        format.html { redirect_to user_events_show_url(:id => @event.id, :uid => @event.user_id), notice: 'Event was successfully created.' }
      #  format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to user_events_url(:uid => @event.user_id), notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to user_events_url(:uid => session[:user_id]) }
      format.json { head :no_content }
    end
  end
end
