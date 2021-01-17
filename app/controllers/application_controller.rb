class ApplicationController < ActionController::Base
    include ApplicationHelper
    helper_method :current_user, :is_logged_in?, :redirect_if_not_logged_in, :redirect_if_not_seller, :is_current_user?, :redirect_if_already_logged_in
    
    private

    def current_user
        @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id] != nil
    end

    def is_logged_in?
        session[:user_id] != nil
    end

    def redirect_if_not_logged_in
        redirect_to root_path, :notice => "You must sign in to continue." if !is_logged_in?
    end

    def redirect_if_not_seller
        if current_user.account_type != 2
            flash[:message] = "Access Denied."
            redirect_to user_path(current_user)
        end
    end

    def redirect_if_already_logged_in
        redirect_to user_path(current_user), :notice => "You are already signed in." if is_logged_in?
    end

    def is_current_user?
        current_user.id == session[:user_id]
    end
end
