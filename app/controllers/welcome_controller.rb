class WelcomeController < ApplicationController
    before_action :current_user

    def home
        @departments = Department.all.includes(products: [:seller])
        @sellers = User.all.where("account_type = ?", 2)
    end
end