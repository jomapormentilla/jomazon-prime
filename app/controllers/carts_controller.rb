class CartsController < ApplicationRecord
    def show
        @user = current_user
    end
end