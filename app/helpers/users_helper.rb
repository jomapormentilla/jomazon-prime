module UsersHelper
    def account_type
        if @user.account_type == 2
            content_tag :span, 'Seller'
        else
            content_tag :span, 'Buyer'
        end
    end

    def render_account_type_for_form(f)
        if current_user.nil?
            render partial: 'select_account_type'
        else
            f.hidden_field :user_account_type, value: current_user.account_type
        end
    end
end
