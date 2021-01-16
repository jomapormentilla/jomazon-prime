class UsersController < ApplicationController
    include UsersHelper

    def index
        @sellers = User.all.where("account_type = ?", 2)
    end

    def new
        @user = User.new
        @store = Store.first
    end

    def create
        @user = User.new(user_params)
        if @user.valid?
            @user.save
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            render :new
        end
    end

    def show
        @user = User.find(params[:id])
    end

    private

    def user_params
        params.require(:user).permit(
            :username,
            :email,
            :password,
            :first_name,
            :last_name,
            :company_name,
            :account_type,
            :store_id
        )
    end
end
