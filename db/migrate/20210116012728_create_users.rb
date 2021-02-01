class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.text :username
      t.text :email
      t.text :password_digest
      t.text :first_name
      t.text :last_name
      t.text :company_name
      t.text :image
      t.integer :account_type
      t.belongs_to :store
      t.timestamps
    end
  end
end
