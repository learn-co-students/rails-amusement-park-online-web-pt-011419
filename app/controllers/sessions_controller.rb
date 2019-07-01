class SessionsController < ApplicationController

  def new

  end

  def create
    if params[:name].nil? || params[:name].empty?
      redirect_to '/signin'
    else
      raise params.inspect
      @user = User.find(params[:id])
      session[:name] = params[:name]
      redirect_to '/'
    end
  end

  def destroy
    session.delete :name
  end

  def home

  end




end
