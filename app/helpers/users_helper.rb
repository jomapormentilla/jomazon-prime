module UsersHelper
    def account_type
        if @user.account_type == 2
            content_tag :span, 'Seller'
        else
            content_tag :span, 'Buyer'
        end
    end
end
