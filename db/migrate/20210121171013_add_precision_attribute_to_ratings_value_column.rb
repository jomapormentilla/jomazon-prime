class AddPrecisionAttributeToRatingsValueColumn < ActiveRecord::Migration[6.1]
  def change
    change_column :ratings, :value, :decimal, precision: 10, scale: 2
  end
end
