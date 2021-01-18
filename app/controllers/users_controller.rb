class UsersController < ApplicationController
    include UsersHelper
    before_action :redirect_if_not_seller, only: [:new, :create, :edit]
    before_action :redirect_if_already_logged_in, only: [:new]
    before_action :redirect_if_not_logged_in, only: [:show]

    def index
        @sellers = User.all.order(:first_name)
    end

    def sellers
        @sellers = User.all.where("account_type = ?", 2).order(:first_name)
    end

    def new
        @user = User.new
        @store = Store.first
    end

    def create
        @user = User.new(user_params)
        if @user.valid?
            @user.balance = 5000.0 if @user.account_type == 1
            @user.save
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            render :new
        end
    end

    def show
        @user = User.find(params[:id])
        if !is_current_user?( @user )
            redirec_if_buyer( @user )
        end
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

    def redirec_if_buyer( user )
        redirect_to sellers_path if user.account_type == 1
    end
end
