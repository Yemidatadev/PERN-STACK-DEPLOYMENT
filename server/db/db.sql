-- First create the restaurants table
CREATE TABLE restaurants (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    location VARCHAR(50) NOT NULL,
    price_range INT NOT NULL check(price_range >= 1 and price_range <= 5)
);

-- Then create the reviews table that references restaurants
CREATE TABLE reviews (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    restaurant_id BIGINT NOT NULL REFERENCES restaurants(id),
    name VARCHAR(50) NOT NULL,
    review TEXT NOT NULL,
    rating INT NOT NULL check(
        rating >= 1
        and rating <= 5
    )
);

-- Your existing select query
SELECT *
FROM restaurants
    LEFT JOIN(
        SELECT restaurant_id,
            COUNT(*),
            TRUNC(AVG(rating), 1) as average_rating
        FROM reviews
        GROUP BY restaurant_id
    ) reviews ON restaurants.id = reviews.restaurant_id;


-- Optional: Insert sample data for testing
INSERT INTO restaurants (name, location, price_range)
VALUES ('Restaurant A', 'Location A', 3),
       ('Restaurant B', 'Location B', 4);

INSERT INTO reviews (restaurant_id, name, review, rating)
VALUES (1, 'John Doe', 'Great food!', 5),
       (2, 'Jane Doe', 'Excellent service!', 4);