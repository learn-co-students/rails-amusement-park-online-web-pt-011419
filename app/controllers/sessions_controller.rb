class SessionsController < ApplicationController

    def new
    end

    def create
        @user = User.find_by(name: params[:user][:name])
        
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect_to @user
        else
            flash[:danger] = "Invalid Credentials. Please Try Again."
            redirect_to '/'
        end
    end 

    def destroy
        session.delete(:user_id)
        redirect_to '/'
    end
end
