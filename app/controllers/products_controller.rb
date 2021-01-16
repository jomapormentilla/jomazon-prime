class ProductsController < ApplicationController
    def new
        @product = Product.new
        @product.build_department

        @store = Store.first
        @departments = Department.all
        @user = User.find_by_id(session[:user_id])
    end

    def create
        @product = Product.new(product_params)

        if @product.valid?
            @product.save
            redirect_to product_path(@product)
        else
            render :new
        end
    end

    def show
        @product = Product.find(params[:id])
        @user = User.find_by_id(session[:user_id])
    end

    private

    def product_params
        params.require(:product).permit(
            :name,
            :description,
            :price,
            :store_id,
            :seller_id,
            department_attributes: [:name, :store_id]
        )
    end
end
