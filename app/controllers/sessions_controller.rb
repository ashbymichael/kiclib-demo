class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if (user && user.authenticate(params['session']['password']))
      session[:user_id] = user.id
      flash[:notice] = "Hello, #{user.name}!"
      redirect_to root_path
    else
      render 'sessions/new'
    end
  end

  def destroy
    session.destroy
    redirect_to '/login'
  end

end
