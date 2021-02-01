class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.text :name
      t.text :description
      t.integer :quantity
      t.decimal :price, precision: 10, scale: 2
      t.text :image
      t.belongs_to :store
      t.belongs_to :seller
      t.belongs_to :department
      t.timestamps
    end
  end
end
