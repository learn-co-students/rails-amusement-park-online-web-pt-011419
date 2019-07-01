class SessionsController < ApplicationController

  def new

  end

  def create
     user = User.find_by(name: params[:user][:name])
    if user && user.authenticate(params[:user][:password])
      log_in user
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    session.delete :name
  end

  def home

  end




end
