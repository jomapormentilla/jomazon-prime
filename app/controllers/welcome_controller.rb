class WelcomeController < ApplicationController
    before_action :redirect_if_not_logged_in
    
    def home
    end
end