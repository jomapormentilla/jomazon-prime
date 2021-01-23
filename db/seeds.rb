def start
    create_store
    create_departments
    create_sellers
    create_buyers
    create_products
    get_images
    get_reviews
    get_ratings
    get_comments
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
    50.times do
        first_name = Faker::Name.first_name
        last_name = Faker::Name.last_name
        company = Faker::Company.name

        email = "#{ first_name.downcase }.#{ last_name.downcase }@#{ company.downcase }.com"

        data = {
            first_name: first_name,
            last_name: last_name,
            email: email,
            company_name: company,
            password: ENV['FAKE_PASSWORD'],
            store_id: Store.first.id,
            account_type: 2,
            balance: 0
        }

        user = User.create(data)
        Cart.create(buyer_id: user.id)
    end
end

def create_buyers
    50.times do
        first_name = Faker::Name.first_name
        last_name = Faker::Name.last_name
        company = Faker::Company.name

        email = "#{ first_name.downcase }.#{ last_name.downcase }@#{ company.downcase }.com"

        data = {
            first_name: first_name,
            last_name: last_name,
            email: email,
            company_name: company,
            password: ENV['FAKE_PASSWORD'],
            store_id: Store.first.id,
            account_type: 1,
            balance: 5000.0
        }

        user = User.create(data)
        Cart.create(buyer_id: user.id)
    end
end

def create_products
    120.times do
        data = {
            name: Faker::Commerce.product_name,
            description: Faker::Movies::StarWars.quote,
            quantity: rand(0...50),
            price: Faker::Commerce.price(range: 10...1000.0),
            store_id: Store.first.id,
            department_id: Department.all.sample.id,
            seller_id: User.where(account_type: 2).sample.id
        }

        Product.create(data)
    end
end

def get_images
    # Each Getty Images Search generates 60 results
    url = "https://www.gettyimages.com/photos/clothing?compositions=stilllife&family=creative&license=rf&phrase=clothing&sort=mostpopular#license"
    html = Nokogiri::HTML(open(url))

    Product.all.each.with_index do |product, index|
        if !html.css(".gallery-asset__thumb")[index].nil?
            product.image = html.css(".gallery-asset__thumb")[index].attr("src")
            product.save
        end
    end
    
    # Another scrape for a different search is required to fill in the remaining products
    url = "https://www.gettyimages.com/photos/electronics?compositions=stilllife&family=creative&license=rf&phrase=electronics&sort=mostpopular#license"  
    html = Nokogiri::HTML(open(url))
    
    Product.all.where(image: nil).each.with_index do |product, index|
        if !html.css(".gallery-asset__thumb")[index].nil?
            product.image = html.css(".gallery-asset__thumb")[index].attr("src")
            product.save
        end
    end
    
    # Scrape pictures for users
    url = "https://www.gettyimages.co.uk/photos/interview-person?family=creative&license=rf&numberofpeople=one&phrase=interview%20person&sort=mostpopular#license"  
    html = Nokogiri::HTML(open(url))
    
    User.all.each.with_index do |user, index|
        if !html.css(".gallery-asset__thumb")[index].nil?
            user.image = html.css(".gallery-asset__thumb")[index].attr("src")
            user.save
        end
    end

    # Scrape pictures for users
    url = "https://www.gettyimages.co.uk/photos/job-person?family=creative&license=rf&numberofpeople=one&phrase=job%20person&sort=mostpopular#license"  
    html = Nokogiri::HTML(open(url))
    
    User.where(image: nil).each.with_index do |user, index|
        if !html.css(".gallery-asset__thumb")[index].nil?
            user.image = html.css(".gallery-asset__thumb")[index].attr("src")
            user.save
        end
    end
end

def get_reviews
    200.times do
        data = {
            content: Faker::TvShows::MichaelScott.quote,
            user_id: User.where(account_type: 1).sample.id,
            product_id: Product.all.sample.id
        }

        Review.create(data)
    end
end

def get_ratings
    1000.times do
        data = {
            value: rand(1..5),
            user_id: User.where(account_type: 1).sample.id,
            product_id: Product.all.sample.id
        }
        
        Rating.create(data)
    end
end

def get_comments
    200.times do
        data = {
            content: Faker::TvShows::RickAndMorty.quote,
            user_id: User.all.sample.id,
            commenter_id: User.all.sample.id
        }

        Comment.create(data)
    end
end

start