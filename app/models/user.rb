class User < ApplicationRecord
    belongs_to :store
    
    has_many :products, foreign_key: "seller_id"
    has_many :departments, through: :products

    has_many :comments
    has_many :reviews
    has_many :ratings

    has_one :cart, foreign_key: "buyer_id"

    has_secure_password

    validates :email, presence: true, uniqueness: true
    validates :password, presence: true
    validates :password, confirmation: true
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :company_name, presence: true

    scope :is_a_seller, -> { where(account_type: 2) }
    scope :is_a_buyer, -> { where(account_type: 1) }

    def slug
        string = "#{ self.first_name } #{ self.last_name }"
        string.downcase.gsub(/\W/," ").gsub(/\s+/," ").gsub(" ","-")
    end

    def self.find_by_slug( slug )
        self.all.detect{ |obj| obj.slug == slug }
    end

    def cart_size
        self.cart.products.size
    end
end
