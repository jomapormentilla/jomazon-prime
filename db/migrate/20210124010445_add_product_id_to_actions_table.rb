class AddProductIdToActionsTable < ActiveRecord::Migration[6.1]
  def change
    add_column :actions, :product_id, :integer
    add_column :actions, :seller_id, :integer
    add_column :actions, :buyer_id, :integer
    remove_column :actions, :user_id, :integer
    remove_column :actions, :content, :text
  end
end
