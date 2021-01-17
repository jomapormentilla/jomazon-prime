def start
    create_store
    create_departments
    create_sellers
    create_buyers
    create_products
    get_images
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
    25.times do
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

def create_buyers
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
            account_type: 1
        }

        User.create(data)
    end
end

def create_products
    100.times do
        data = {
            name: Faker::Commerce.product_name,
            description: Faker::Lorem.sentence(word_count: 25),
            quantity: rand(1...100),
            price: Faker::Commerce.price,
            store_id: Store.first.id,
            department_id: Department.all.sample.id,
            seller_id: User.where("account_type = ?", 2).sample.id
        }

        Product.create(data)
    end
end

def get_images
    # Each Getty Images Search generates 60 results
    url = "https://www.gettyimages.com/photos/clothing?compositions=stilllife&family=creative&license=rf&phrase=clothing&sort=mostpopular#license"
    html = Nokogiri::HTML(open(url))

    Product.all.each.with_index do |product, index|
        product.image = html.css(".gallery-asset__thumb")[index].attr("src")
        product.save
    end
    
    # Another scrape for a different search is required to fill in the remaining products
    url = "https://www.gettyimages.com/photos/electronics?compositions=stilllife&family=creative&license=rf&phrase=electronics&sort=mostpopular#license"  
    html = Nokogiri::HTML(open(url))
    
    Product.all.where(image: nil).each.with_index do |product, index|
        product.image = html.css(".gallery-asset__thumb")[index].attr("src")
        product.save
    end
end

start