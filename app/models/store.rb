class Store < ApplicationRecord
    has_many :users
    has_many :products, through: :users
    has_many :departments
end
