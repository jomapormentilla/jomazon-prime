class CreateCartsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :carts do |t|
      t.belongs_to :buyer
      t.timestamps
    end
  end
end
