def start
    # create_store
    # create_departments
    # create_sellers
    create_products
end

def create_store
    Store.create(name: "Jomazon")
end

def create_departments
    data = ["Books", "Clothing", "Cell Phones", "Computers", "Education", "Electronics", "Home", "Movies", "Music", "Office", "Pets", "Software", "Toys", "Video Games"]

    data.each do |d|
        Department.create(name: d, store_id: Store.first.id)
    end
end

def create_sellers
    20.times do
        first_name = Faker::Name.first_name
        last_name = Faker::Name.last_name
        company = Faker::Company.name

        email = "#{ first_name.downcase }.#{ last_name.downcase }@#{ company.downcase }.com"

        data = {
            first_name: first_name,
            last_name: last_name,
            email: email,
            company_name: company,
            password: 'plokijuh',
            store_id: Store.first.id,
            account_type: 2
        }

        User.create(data)
    end
end

def create_products
    20.times do
        data = {
            name: Faker::Commerce.product_name,
            description: Faker::Lorem.sentence(word_count: 25),
            quantity: rand(1...100),
            price: Faker::Commerce.price,
            store_id: Store.first.id,
            department_id: Department.all.sample.id,
            seller_id: User.all.sample.id
        }

        Product.create(data)
    end
end

start