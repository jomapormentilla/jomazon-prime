class Product < ApplicationRecord
    belongs_to :store
    belongs_to :seller, class_name: "User"
    belongs_to :department

    has_many :product_categories
    has_many :categories, through: :product_categories

    has_many :ratings
    has_many :comments

    validates :name, presence: true, uniqueness: true
    validates :description, length: { minimum: 25 }
    validates :price, numericality: { greater_than: 0 }

    # accepts_nested_attributes_for :department, reject_if: proc{ |attr| attr['name'].blank? }

    def department_attributes=(attributes)
        self.department = Department.find_or_create_by(name: attributes[:name], store_id: attributes[:store_id])
        byebug
    end
end
