class UsersController < ApplicationController
  before_action :require_logged_in, only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      render root_path
    end
  end

  def show
    @user = User.find(session[:user_id])
  end

  def update
    user = User.find(params[:id])
    attraction = Attraction.find(params[:attraction_id])

    if (user.height < attraction.min_height) && (user.tickets < attraction.tickets)
      flash[:notice] = "Sorry. You are not tall enough to ride the #{attraction.name}. You do not have enough tickets to ride the #{attraction.name}."
      redirect_to user
    elsif user.height < attraction.min_height
      flash[:notice] = "Sorry. You are not tall enough to ride the #{attraction.name}."
      redirect_to user
    elsif user.tickets < attraction.tickets
      flash[:notice] = "You do not have enough tickets to ride the #{attraction.name}."
      redirect_to user
    else
      pay_tickets(user, attraction)
      update_mood(user, attraction)
      if !user.password
        user.password = SecureRandom.hex
      end
      user.save
      flash[:notice] = "Thanks for riding the #{attraction.name}!"
      redirect_to user
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :height, :nausea, :happiness, :tickets, :admin, :password)
  end
end
