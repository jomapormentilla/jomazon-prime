class SessionsController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.find_by_email(params[:user][:email])

        if @user && @user.authenticate(params[:user][:password])
            session[:user_id] = @user.id
            redirect_to root_path
        else
            flash[:notice] = "Invalid Username or Password"
            redirect_to login_path
        end
    end

    def destroy
        session.clear
        redirect_to root_path
    end
end