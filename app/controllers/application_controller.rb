class ApplicationController < ActionController::Base
    include ApplicationHelper
    helper_method :current_user, :is_logged_in?, :redirect_if_not_logged_in
    
    private

    def current_user
        @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id] != nil
    end

    def is_logged_in?
        session[:user_id] != nil
    end

    def redirect_if_not_logged_in
        redirect_to root_path if !is_logged_in?
    end
end
