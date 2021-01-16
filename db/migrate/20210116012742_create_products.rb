class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.integer :quantity
      t.integer :price
      t.string :image
      t.belongs_to :store
      t.belongs_to :seller
      t.belongs_to :department
      t.timestamps
    end
  end
end
