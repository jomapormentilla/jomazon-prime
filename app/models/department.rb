class Department < ApplicationRecord
    belongs_to :store

    has_many :products
    has_many :sellers, through: :products
end
