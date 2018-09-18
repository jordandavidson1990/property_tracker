DROP TABLE IF EXISTS properties;

CREATE TABLE properties(
id SERIAL4 PRIMARY KEY,
address VARCHAR(255),
value INT2,
number_of_bedrooms VARCHAR(255),
year_built VARCHAR(255)
);
