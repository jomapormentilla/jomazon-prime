class User < ApplicationRecord
    belongs_to :store
    
    has_many :products, foreign_key: "seller_id"
    has_many :departments, through: :products

    has_many :comments
    has_many :reviews
    has_many :ratings

    has_one :cart
end
