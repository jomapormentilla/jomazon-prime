module ApplicationHelper
    def navigation_by_account_type
        if is_logged_in?
            if @user.account_type == 2
                render partial: 'layouts/seller_nav'
            else
                render partial: 'layouts/buyer_nav'
            end
        end
    end
end
