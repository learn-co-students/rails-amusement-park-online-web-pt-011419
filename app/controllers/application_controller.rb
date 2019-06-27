class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :logged_in?, :current_user

  def logged_in?
    session[:user_id]
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def require_logged_in
    return redirect_to(controller: 'users', action: 'new') unless logged_in?
  end

  def pay_tickets(user, attraction)
    if user.tickets >= attraction.tickets
      user.tickets -= attraction.tickets
      user
    end
  end

  def update_mood(user, attraction)
    user.nausea += attraction.nausea_rating
  end

  
end
