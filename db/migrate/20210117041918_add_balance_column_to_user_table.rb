class AddBalanceColumnToUserTable < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :balance, :decimal, precision: 10, scale: 2
  end
end
