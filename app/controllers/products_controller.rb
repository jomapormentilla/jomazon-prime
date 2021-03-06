class ProductsController < ApplicationController
    before_action :assign_store_and_departments,    only: [:index, :new, :create, :edit]
    before_action :redirect_if_not_seller,          only: [:new, :create, :edit]
    before_action :redirect_if_not_logged_in,       only: [:show]
    before_action :find_product,                    only: [:show, :edit, :update, :destroy]
    before_action :redirect_if_not_product_owner,   only: [:edit, :destroy]

    def index
        if params[:user_id]
            @user = User.find_by_id(params[:user_id])
            @sellers = User.is_a_seller.order(:company_name)
            @products = @user.products.includes(:seller, :ratings)

        elsif params[:department_id]
            @department = Department.find_by_id(params[:department_id])
            @products = @department.products.includes(:seller, :ratings)

        else
            @products = Product.all.includes(:seller, :ratings)
        end
            
        if params[:sort]
            if params[:sort] == "name"
                @products = @products.order(:name)
            elsif params[:sort] == "recent"
                @products = @products.order(id: :desc)
            elsif params[:sort] == "price-asc"
                @products = @products.order(price: :asc)
            elsif params[:sort] == "price-desc"
                @products = @products.order(price: :desc)
            elsif params[:sort] == "quantity"
                @products = @products.order(quantity: :asc)
            end
        else
            @products = @products.order(:name)
        end

        @products = @products.with_attached_product_image
    end

    def new
        if params[:user_id]
            @user = User.find_by_id(params[:user_id])

            if @user
                if @user.id != current_user.id
                    flash[:notice] = "Error: Access Denied."
                    redirect_to user_path( current_user )
                end
            else
                flash[:notice] = "Error: User not found."
                redirect_to user_path( current_user )
            end
        end
        
        @product = Product.new
        @product.build_department
    end

    def create
        @product = Product.new(product_params)
        @product.seller_id = current_user.id
        @product.store_id = @store.id

        if @product.valid?
            @product.save

            redirect_to product_path(@product)
        else
            @product.build_department

            render :new
        end
    end

    def show
        @related_products = Product.related_to(@product).with_attached_product_image
        @review = Review.new
        @reviews = @product.reviews.order(id: :desc)
        @cart = current_user.cart.nil? ? [] : current_user.cart.cart_products.not_purchased
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

    def destroy
        @product.delete
        flash[:notice] = "Product successfully deleted."
        redirect_to user_path( current_user )
    end

    private

    def product_params
        params.require(:product).permit(
            :name,
            :description,
            :price,
            :quantity,
            :department_id,
            :product_image,
            department_attributes: [:name, :store_id]
        )
    end

    def assign_store_and_departments
        @store = Store.first
        @departments = Department.all.order(:name)
    end

    def find_product
        @product = Product.find(params[:id])
    end

    def redirect_if_not_product_owner
        if @product.seller.id != current_user.id
            flash[:notice] = "Error: You do not own this product."
            redirect_to user_path( current_user )
        end
    end
end
