class Product < ApplicationRecord
    belongs_to :store
    belongs_to :seller, class_name: "User"
    belongs_to :department

    has_many :product_categories
    has_many :categories, through: :product_categories

    has_many :ratings
    has_many :comments
end
