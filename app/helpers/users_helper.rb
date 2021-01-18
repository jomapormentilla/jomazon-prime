module UsersHelper
    def account_type
        if @user.account_type == 2
            content_tag :span, 'Seller'
        else
            content_tag :span, 'Buyer'
        end
    end

    def display_account_settings
        if @user.id == current_user.id
            render partial: 'users/account_settings'
        end
    end
end
