class UsersController < ApplicationController
    before_action :redirect_if_not_seller,          only: [:new, :create]
    before_action :redirect_if_already_logged_in,   only: [:new]
    before_action :redirect_if_not_logged_in,       only: [:show]
    before_action :redirect_if_signup_incomplete,   only: [:show]

    def index
        @sellers = User.all.order(:first_name)
    end

    def sellers
        @sellers = User.is_a_seller.order(:first_name)
    end

    def new
        if params[:test]
            byebug
        end

        @user = User.new
    end

    def create
        @user = User.new(user_params)
        @user.store_id = Store.first.id
        
        if @user.valid?
            @user.balance = 5000.0 if @user.account_type == 1
            @user.save
            @cart = Cart.create(buyer_id: @user.id) if @user.account_type == 1
            byebug
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            render :new
        end
    end

    def edit
        @user = User.find(params[:id])
        @store = Store.first
    end

    def update
        @user = User.find(params[:id])

        if @user.update(user_params)
            redirect_to user_path( @user ), notice: "Profile Updated"
        else
            render :edit
        end
    end

    def show
        @user = User.find(params[:id])
        @sellers = User.is_a_seller.order(:company_name)
        @products = @user.products.limit(10)

        # if !is_current_user?( @user )
        #     redirec_if_buyer( @user )
        # end
    end

    private

    def user_params
        params.require(:user).permit(
            :email,
            :password,
            :first_name,
            :last_name,
            :company_name,
            :account_type,
            :password_confirmation
        )
    end

    def redirec_if_buyer( user )
        redirect_to sellers_path if user.account_type == 1
    end
end
