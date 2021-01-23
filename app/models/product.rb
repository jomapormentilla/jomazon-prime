class Product < ApplicationRecord
    belongs_to :store
    belongs_to :seller, class_name: "User", dependent: :destroy
    belongs_to :department

    has_many :product_categories
    has_many :categories, through: :product_categories

    has_many :ratings
    has_many :comments
    has_many :reviews

    has_many :cart_products
    has_many :carts, through: :cart_products

    validates :description, presence: true
    validates :price, numericality: { greater_than: 0 }
    validates :quantity, numericality: { greater_than: -1 }

    scope :related_to, ->( product ){ where(department_id: product.department_id).limit(10) }
    scope :most_expensive, -> { order(price: :desc).limit(10) }

    def department_attributes=(attributes)
        if attributes[:name] != ""
            self.department = Department.find_or_create_by(name: attributes[:name], store_id: attributes[:store_id])
            self.department.update(attributes)
        end
    end

    def get_rating
        total = 0
        self.ratings.each{ |r| total += r.value }

        if total == 0
            "0.0"
        else
            result = total / self.ratings.size
            result.round(2)
        end
    end
end
