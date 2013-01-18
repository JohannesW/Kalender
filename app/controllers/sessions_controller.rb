class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.authenticate(params[:email], params[:password])
  	if user
  		session[:user_id] = user.id
  		session[:user_name] = user.name
  		#redirect_to root_url, :notice => "Logged in!"
  		#render text: session[:user_id]
  		redirect_to :controller => 'events', :action => 'index', :uid => user.id
  		
  	else
  		flash.now.alert = "Invalid email or password"
  		render "new"
  	end
  end

	def destroy
  		session[:user_id] = nil
  		session[:user_name] = nil
  		redirect_to root_url, :notice => "Logged out!"
	end
end
