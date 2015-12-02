class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if (user && user.authenticate(params['session']['password']))
      session[:user_id] = user.id
      flash[:notice] = "Hello, #{user.username}!"
      redirect_to root_path
    else
      flash[:error] = "Sorry, username or password was invalid."
      render 'sessions/new'
    end
  end

  def destroy
    session.destroy
    redirect_to '/login'
  end

end
