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

  def take_ride
    if (user.tickets < attraction.tickets) && (user.height < attraction.min_height)
      flash[:notice] = "Sorry. You do not have enought tickets to ride the #{attraction.name}."
    elsif user.tickets < attraction.tickets
      flash[:notice] = "Sorry. You do not have enought tickets to ride the #{attraction.name}."
    elsif user.height < attraction.min_height
      flash[:notice] = "Sorry. You are not tall enought to ride the #{attraction.name}."
    else
      pay_tickets(user, attraction)
      update_mood(user, attraction)
      if !user.password
        user.password = SecureRandom.hex
      end
      user.save
      flash[:notice] = "Thanks for riding the #{attraction.name}!"
    end
  end
end
