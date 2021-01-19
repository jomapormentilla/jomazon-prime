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

    def omniauth
        @user = User.find_or_create_by(provider: auth[:provider], uid: auth[:uid]) do |u|
            u.first_name = auth[:info][:first_name]
            u.last_name = auth[:info][:last_name]
            u.email = auth[:info][:email]
            u.password = SecureRandom.hex(15)
            u.store_id = Store.first.id
        end

        if @user.valid?
            session[:user_id] = @user.id
            if @user.created_at == @user.updated_at
                redirect_to account_type_path
            else
                redirect_to root_path
            end
        else
            flash[:notice] = "Something went wrong!"
            redirect_to login_path
        end
    end

    def account_type
        @user = User.find_by_id(session[:user_id])

        if params[:account_type]
            if params[:account_type].to_i == 1
                @cart = Cart.create(buyer_id: @user.id)
                @user.balance = 5000.0
                @user.account_type = 1
            elsif params[:account_type].to_i == 2
                @user.account_type = 2
            end
            @user.company_name = params[:company_name]
            @user.save

            redirect_to root_path
        end
    end

    def destroy
        session.clear
        redirect_to root_path
    end

    private

    def auth
        request.env['omniauth.auth']
    end
end