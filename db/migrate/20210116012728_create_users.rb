class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.string :first_name
      t.string :last_name
      t.string :company_name
      t.string :image
      t.integer :account_type
      t.belongs_to :store
      t.timestamps
    end
  end
end
