module RatingsHelper
    def display_ratings_options( product )
        i = 0
        until i == 5
            link_to '5', "#{ product_ratings_path( product ) }?rating=5", method: 'post'
            i += 1
        end
    end
end
