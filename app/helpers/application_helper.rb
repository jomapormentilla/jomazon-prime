module ApplicationHelper
    def navigation_by_account_type
        if is_logged_in? && !current_user.account_type.nil?
            if current_user.account_type == 2
                render partial: 'layouts/nav_seller'
            else
                render partial: 'layouts/nav_buyer'
            end
        end
    end

    def login_button
        if is_logged_in?
            link_to current_user.first_name, user_path(current_user), class: 'btn btn-sm btn-outline-light btn-sm'
        else
            link_to 'Sign In', login_path, class: 'btn btn-outline-light btn-sm'
        end
    end

    def parse_timestamp( timestamp )
        time = timestamp.in_time_zone('Eastern Time (US & Canada)')
        time.strftime("%B %d, %Y at %l:%M%P")
    end
end
