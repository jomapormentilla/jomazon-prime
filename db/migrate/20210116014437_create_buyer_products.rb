class CreateBuyerProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :buyer_products do |t|
      t.belongs_to :buyer
      t.belongs_to :product
      t.timestamps
    end
  end
end
