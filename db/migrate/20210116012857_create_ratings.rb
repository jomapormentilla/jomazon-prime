class CreateRatings < ActiveRecord::Migration[6.1]
  def change
    create_table :ratings do |t|
      t.integer :value
      t.belongs_to :user
      t.belongs_to :product
      t.timestamps
    end
  end
end
