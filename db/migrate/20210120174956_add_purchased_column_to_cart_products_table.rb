class AddPurchasedColumnToCartProductsTable < ActiveRecord::Migration[6.1]
  def change
    add_column :cart_products, :purchased, :boolean, default: false
  end
end
