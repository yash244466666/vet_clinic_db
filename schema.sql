/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
id BIGSERIAL NOT NULL PRIMARY KEY,
name VARCHAR(50),
date_of_birth DATE,
escape_attempts INT,
neutered BOOLEAN,
weight_kg DECIMAL
);


------------------------------------------------------------
------------------------------------------------------------

ALTER TABLE animals ADD species VARCHAR(60);

------------------------------------------------------------
------------------------------------------------------------

--Remove the species column from the animals table.
ALTER TABLE animals DROP COLUMN species;

-- Create a new table named owners
CREATE TABLE owners (
id BIGSERIAL NOT NULL PRIMARY KEY,
full_name VARCHAR(250),
age INT NOT NULL
);

-- Create a table named species

CREATE TABLE species (
id BIGSERIAL NOT NULL PRIMARY KEY,
name VARCHAR(250)
);

-- Add a column named species_id to the animals table

ALTER TABLE animals ADD COLUMN species_id INT REFERENCES species(id);

-- Add a column named owner_id to the animals table

ALTER TABLE animals ADD COLUMN owner_id INT REFERENCES owners(id);