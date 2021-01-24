def start
    create_store
    create_departments
    create_sellers
    create_buyers
    create_products
    
    get_product_images("Books",         "https://www.gettyimages.co.uk/photos/book?family=creative&license=rf&mediatype=photography&phrase=book&sort=best#license")
    get_product_images("Clothing",      "https://www.gettyimages.co.uk/photos/clothes?compositions=stilllife&family=creative&license=rf&mediatype=photography&numberofpeople=none&phrase=clothes&sort=best#license")
    get_product_images("Cell Phones",   "https://www.gettyimages.co.uk/photos/cell-phone?compositions=stilllife&family=creative&license=rf&mediatype=photography&numberofpeople=none&phrase=cell%20phone&sort=best#license")
    get_product_images("Computers",     "https://www.gettyimages.co.uk/photos/computer?compositions=stilllife&family=creative&license=rf&mediatype=photography&numberofpeople=none&phrase=computer&sort=best#license")
    get_product_images("Education",     "https://www.gettyimages.co.uk/photos/education?compositions=stilllife&family=creative&license=rf&mediatype=photography&numberofpeople=none&phrase=education&sort=best#license")
    get_product_images("Electronics",   "https://www.gettyimages.co.uk/photos/electronics?compositions=stilllife&family=creative&license=rf&mediatype=photography&numberofpeople=none&phrase=electronics&sort=best#license")
    get_product_images("Home",          "https://www.gettyimages.co.uk/photos/furniture?compositions=stilllife&family=creative&license=rf&mediatype=photography&numberofpeople=none&phrase=furniture&sort=best#license")
    get_product_images("Movies",        "https://www.gettyimages.co.uk/photos/theatre?compositions=stilllife&family=creative&license=rf&mediatype=photography&numberofpeople=none&phrase=theatre&sort=best#license")
    get_product_images("Music",         "https://www.gettyimages.co.uk/photos/music?compositions=stilllife&family=creative&license=rf&mediatype=photography&numberofpeople=none&phrase=music&sort=best#license")
    get_product_images("Office",        "https://www.gettyimages.co.uk/photos/office-supply?compositions=stilllife&family=creative&license=rf&mediatype=photography&numberofpeople=none&phrase=office%20supply&sort=best#license")
    get_product_images("Pets",          "https://www.gettyimages.co.uk/photos/dog-and-cat?compositions=closeup,portrait&family=creative&license=rf&mediatype=photography&numberofpeople=none&phrase=dog%20and%20cat&sort=best#license")
    get_product_images("Software",      "https://www.gettyimages.co.uk/photos/software?compositions=closeup,portrait&family=creative&license=rf&mediatype=photography&numberofpeople=none&phrase=software&sort=best#license")
    get_product_images("Toys",          "https://www.gettyimages.co.uk/photos/toys?compositions=closeup,portrait&family=creative&license=rf&mediatype=photography&numberofpeople=none&phrase=toys&sort=best#license")
    get_product_images("Video Games",   "https://www.gettyimages.co.uk/photos/video-games?compositions=closeup,portrait&family=creative&license=rf&mediatype=photography&numberofpeople=none&phrase=video%20games&sort=best#license")
    
    get_user_images("https://www.gettyimages.co.uk/photos/interview-person?family=creative&license=rf&numberofpeople=one&phrase=interview%20person&sort=mostpopular#license")
    get_user_images("https://www.gettyimages.co.uk/photos/job-person?family=creative&license=rf&numberofpeople=one&phrase=job%20person&sort=mostpopular#license")
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
        _company = company.gsub(" ","").gsub(",","")

        email = "#{ first_name.downcase }.#{ last_name.downcase }@#{ _company.downcase }.com"

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
        _company = company.gsub(" ","").gsub(",","")

        email = "#{ first_name.downcase }.#{ last_name.downcase }@#{ _company.downcase }.com"

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
    300.times do
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

def get_product_images( department, url )
    html = Nokogiri::HTML(open(url))

    Department.where(name: department).first.products.where(image: nil).each.with_index do |product, index|
        if !html.css(".gallery-asset__thumb")[index].nil?
            product.image = html.css(".gallery-asset__thumb")[index].attr("src")
            product.save
        end
    end
end

def get_user_images( url )
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
    1500.times do
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