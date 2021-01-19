class WelcomeController < ApplicationController
    before_action :current_user
    before_action :redirect_if_signup_incomplete

    def home
        @departments = Department.all.includes(products: [:seller])
        @sellers = User.all.where(account_type: 2).order(:company_name)
    end

    def search
        if !params[:search]
            redirect_to root_path
        end
        
        @results = "You searched for: #{ params[:search] }"
    end

    private

    def redirect_if_signup_incomplete
        if is_logged_in?
            redirect_to account_type_path if current_user.account_type == nil
        end
    end
end