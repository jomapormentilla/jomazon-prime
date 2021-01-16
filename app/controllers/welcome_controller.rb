class WelcomeController < ApplicationController
    before_action :current_user

    def home
        @departments = Department.all.includes(:products)
    end
end