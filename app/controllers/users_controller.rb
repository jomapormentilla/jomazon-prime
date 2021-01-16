class UsersController < ApplicationController
    def new
        @user = User.new
        @store = Store.first
    end

    def create
        @user = User.new(user_params)
        if @user.valid?
            @user.save
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
            :first_name,
            :last_name,
            :company_name,
            :account_type,
            :store_id
        )
    end
end
