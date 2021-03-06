class UsersController < ApplicationController
    before_action :redirect_if_not_seller,          only: [:new, :create]
    before_action :redirect_if_already_logged_in,   only: [:new]
    before_action :redirect_if_not_logged_in,       only: [:show]
    before_action :redirect_if_signup_incomplete,   only: [:show]

    def sellers
        @sellers = User.is_a_seller.with_attached_profile_image.alpha_order
        
        if params[:q]
            @sellers = @sellers.where("first_name LIKE ?", "%#{ params[:q] }%")
            .or(User.where("last_name LIKE ?", "%#{ params[:q] }%"))
            .or(User.where("company_name LIKE ?", "%#{ params[:q] }%"))
        end
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        @user.store_id = Store.first.id
        
        if @user.valid?
            @user.balance = 5000.0 if @user.account_type == 1
            @user.balance = 0 if @user.account_type == 2
            @user.save
            @cart = Cart.create(buyer_id: @user.id)

            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            render :new
        end
    end

    def show
        @user = User.find(params[:id])
        @sellers = User.is_a_seller.order(:company_name)
        @products = @user.products.limit(10)
        
        @cart = current_user.cart.nil? ? [] : current_user.cart.cart_products.not_purchased
        @purchased_items = current_user.cart.nil? ? [] : current_user.cart.cart_products.purchased.order(id: :desc).limit(10)
        
        @comment = Comment.new
        @comments = @user.comments.order(id: :desc)

        @actions = @user.seller_actions if @user.account_type == 2
        @actions = @user.buyer_actions if @user.account_type == 1
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

    private

    def user_params
        params.require(:user).permit(
            :email,
            :password,
            :first_name,
            :last_name,
            :company_name,
            :account_type,
            :password_confirmation,
            :profile_image
        )
    end

    def redirec_if_buyer( user )
        redirect_to sellers_path if user.account_type == 1
    end
end
