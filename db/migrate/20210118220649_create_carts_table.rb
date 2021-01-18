class CreateCartsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :carts_tables do |t|
      t.belongs_to :buyer
      t.timestamps
    end
  end
end
