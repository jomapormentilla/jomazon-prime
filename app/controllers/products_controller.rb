class ProductsController < ApplicationController
    before_action :redirect_if_not_seller, only: [:new, :create, :edit]
    before_action :redirect_if_not_logged_in, only: [:show]
    before_action :assign_store_and_departments, only: [:index, :new, :create, :edit]
    before_action :find_product, only: [:show, :edit, :update]

    def index
        if params[:user_id]
            @user = User.find_by_id(params[:user_id])
            @sellers = User.where(account_type: 2).order(:company_name)
            @products = @user.products.includes(:seller).order(:name)

        elsif params[:department_id]
            @department = Department.find_by_id(params[:department_id])
            @products = @department.products.includes(:seller).order(:name)

        else
            @products = Product.all.includes(:seller).order(:name)
        end
    end

    def new
        @product = Product.new
        @product.build_department
    end

    def create
        @product = Product.new(product_params)

        if @product.valid?
            @product.save
            redirect_to product_path(@product)
        else
            @product.build_department

            render :new
        end
    end

    def show
        @related_products = Product.where(department_id: @product.department_id).limit(10)
        @review = Review.new
        @reviews = @product.reviews.order(:id)
    end

    def edit
    end

    def update
        if @product.update(product_params)
            redirect_to product_path(@product)
        else
            render :edit
        end
    end

    def addtocart
        @product = Product.find_by_id(params[:id])
        
        if @product
            @cart = Cart.find_or_create_by(buyer_id: current_user.id)
            @cart.products << @product

            flash[:notice] = "Item has been added to your cart."
            redirect_to product_path(@product)
        else
            flash[:notice] = "Error. Product not found."
            redirect_to product_path(@product)
        end
    end

    private

    def product_params
        params.require(:product).permit(
            :name,
            :description,
            :price,
            :quantity,
            :store_id,
            :seller_id,
            :department_id,
            department_attributes: [:name, :store_id]
        )
    end

    def assign_store_and_departments
        @store = Store.first
        @departments = Department.all
    end

    def find_product
        @product = Product.find(params[:id])
    end
end
