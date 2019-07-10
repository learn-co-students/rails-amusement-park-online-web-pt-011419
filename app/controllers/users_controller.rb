class UsersController < ApplicationController

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        
        if @user.save
            session[:user_id] = @user.id
            redirect_to @user
        else
            render root_path
        end
    end

    def show
        # @user = User.find(params[:id])
        if !session[:user_id].nil?
            @user = User.find(params[:id])
        else
            redirect_to root_path
        end
    end

    def update
        @user = User.find(params[:id])
        @attraction = Attraction.find(params[:attraction_id])
        @ride = Ride.new(user_id: @user.id, attraction_id: @attraction.id)
        
        flash[:alert] = "#{@ride.take_ride}"

        redirect_to @user
    end

    private

    def user_params
        params.require(:user).permit(:name, :password, :height, :happiness, :nausea, :tickets, :admin)
    end

end
