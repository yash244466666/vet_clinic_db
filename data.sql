INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES 
('Agumon', '2020-02-03', 0, TRUE, 10.23),
('Gabumon', '2018-11-15',2, TRUE, 8),
('Pikachu', '2021-01-07', 1, FALSE, 15.04),
('Devimon', '2017-05-12', 5, TRUE, 11);


------------------------------------------------------------------------------
------------------------------------------------------------------------------

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES 
('Charmander', '2020-02-08', 0, TRUE, -11),
postgres-# ('Plantmon', '2021-11-15', 2, FALSE, -5.7),
postgres-# ('Squirtle', '1993-04-02', 3, FALSE, -12.13),
postgres-# ('Angemon', '2005-06-12', 1, TRUE, -45),
postgres-# ('Boarmon', '2005-06-07', 7, TRUE, 20.4),
postgres-# ('Blossmon', '1998-10-13', 3, TRUE, 17),
postgres-# ('Ditto', '2022-05-14', 4, TRUE, 22);

------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- Insert the following data into the owners table:

INSERT INTO owners (full_name, age) VALUES 
('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);

-- Insert the following data into the species table:

INSERT INTO species (name) VALUES 
('Pokemon'),
('Digimon');

-- Update the animals table by adding these new columns:

UPDATE animals SET species_id = CASE
WHEN name LIKE '%mon' THEN(SELECT id FROM species WHERE name = 'Digimon')
ELSE (SELECT id FROM species WHERE name = 'Pokemon')
END;

-- Update the animals table by adding these new columns:

UPDATE animals SET owner_id = CASE
WHEN name = 'Agumon' THEN (SELECT id FROM owners WHERE full_name = 'Sam Smith')
WHEN name = 'Gabumon' OR name = 'Pikachu' THEN (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
WHEN name = 'Devimon' OR name = 'Plantmon' THEN ( SELECT id FROM owners WHERE full_name = 'Bob')
WHEN name = 'Charmander' OR name = 'Squirtle' THEN (SELECT id FROM owners WHERE full_name = 'Melody Pond')
WHEN name = 'Angemon' OR name = 'Boarmon' THEN (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
END;