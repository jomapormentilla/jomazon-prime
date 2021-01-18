class Product < ApplicationRecord
    belongs_to :store
    belongs_to :seller, class_name: "User"
    belongs_to :department

    has_many :product_categories
    has_many :categories, through: :product_categories

    has_many :ratings
    has_many :comments
    has_many :reviews

    has_many :carts

    # validates :name, presence: true, uniqueness: true
    validates :description, presence: true
    validates :price, numericality: { greater_than: 0 }
    validates :quantity, numericality: { greater_than: 0 }

    # accepts_nested_attributes_for :department, reject_if: proc{ |attr| attr['name'].blank? || attr['store_id'].blank? }

    def department_attributes=(attributes)
        if attributes[:name] != ""
            self.department = Department.find_or_create_by(name: attributes[:name], store_id: attributes[:store_id])
            self.department.update(attributes)
        end
    end
end
