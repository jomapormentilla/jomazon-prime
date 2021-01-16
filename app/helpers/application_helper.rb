module ApplicationHelper
    def navigation_by_account_type
        if is_logged_in?
            if current_user.account_type == 2
                render partial: 'layouts/seller_nav'
            else
                render partial: 'layouts/buyer_nav'
            end
        end
    end

    def login_logout_button
        if is_logged_in?
            link_to 'Log Out', logout_path, class: 'nav-link btn btn-sm btn-outline-danger'
        else
            link_to 'Sign In', login_path, class: 'nav-link btn btn-sm btn-outline-primary'
        end
    end
end
