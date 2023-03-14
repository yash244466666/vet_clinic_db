--  Create a database named vet_clinic
CREATE DATABASE vet_clinic;

-- Create a table named animal with the following columns:
CREATE TABLE animal (
    id INTEGER GENERATED BY DEFAULT AS IDENTITY,
    name VARCHAR(100),
    date_of_birth DATE,
    escape_attempts INTEGER,
    neutered BOOLEAN,
    weight_kg DECIMAL,
    PRIMARY KEY(id)
);

-- Add a column species of type string to animal table
ALTER TABLE animal
ADD species VARCHAR(100);

--  Create owners table
CREATE TABLE owners (
    id INTEGER GENERATED BY DEFAULT AS IDENTITY,
    full_name VARCHAR(100),
    age INTEGER,
    PRIMARY KEY(id)
);

-- Create Species table
CREATE TABLE species (
    id INTEGER GENERATED BY DEFAULT AS IDENTITY,
    name VARCHAR(100),
    PRIMARY KEY(id)
);

-- Remove species column from animal table
ALTER TABLE animal
DROP COLUMN species;


-- Add species_id column to animal table
ALTER TABLE animal
ADD COLUMN species_id INTEGER REFERENCES species(id);

-- Add owner_id column to animal table
ALTER TABLE animal
ADD COLUMN owner_id INTEGER REFERENCES owners(id);

-- Create vets table
CREATE TABLE vets (
    id INTEGER GENERATED BY DEFAULT AS IDENTITY,
    name VARCHAR(100),
    age INTEGER,
    date_of_graduation DATE,
    PRIMARY KEY(id)
);

-- create specializations table
CREATE TABLE specializations (
    vet_id int REFERENCES vets (id),
    species_id int REFERENCES species (id)
);

-- Create visits table
CREATE TABLE visits (
    animal_id int REFERENCES animal (id),
    vet_id int REFERENCES vets (id),
    date_of_visit date
);
------------------------------------------------------------------
-- project requirements;
SELECT COUNT(*) FROM visits where animal_id = 4;
SELECT * FROM visits where vet_id = 2;
SELECT * FROM owners where email = 'owner_18327@mail.com';

-- Use EXPLAIN ANALYZE on the previous queries to check what is happening. Take screenshots of them -

-- before improve
EXPLAIN ANALYSE SELECT COUNT(*) FROM visits where animal_id = 4;
SELECT COUNT(*) FROM visits where animal_id = 4;

-- after improve
CREATE INDEX visits_animal_id ON visits(animal_id);
EXPLAIN ANALYSE SELECT COUNT(*) FROM visits WHERE animal_id = 4;

-- SELECT * FROM visits where vet_id = 2; Before improve
SELECT * FROM visits WHERE vet_id = 2;
explain analyse SELECT COUNT(*) FROM visits where animal_id = 2;

-- Querie : SELECT * FROM visits where vet_id = 2; After improve
CREATE INDEX visits_vet_id ON visits(vet_id);
EXPLAIN ANALYSE SELECT * FROM visits WHERE animal_id = 2;

