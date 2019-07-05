class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login, only: [:show, :edit]
  helper_method :current_user

  private

  def require_login
    if !logged_in?
      redirect_to '/'
    end
  end

   def logged_in?
    session[:user_id]
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
