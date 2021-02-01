class CreateActions < ActiveRecord::Migration[6.1]
  def change
    create_table :actions do |t|
      t.text :content
      t.decimal :price, precision: 10, scale: 2
      t.belongs_to :user
      t.timestamps
    end
  end
end
