class CreateProductCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :product_categories do |t|
      t.belongs_to :product
      t.belongs_to :category
      t.timestamps
    end
  end
end
