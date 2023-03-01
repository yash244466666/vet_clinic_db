SELECT * FROM animals WHERE name LIKE '%mon';

SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

SELECT name FROM animals WHERE neutered=TRUE AND escape_attempts < 3;

SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

SELECT * FROM animals WHERE neutered=TRUE;

SELECT * FROM animals WHERE name NOT IN ('Gabumon');

SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------

BEGIN;
UPDATE animals
SET species = 'unspecified';
SELECT * FROM animals
ROLLBACK;
SELECT * FROM animals;

BEGIN;
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';
UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;
COMMIT;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals;
SELECT * FROM animals;

ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT DELETED_BORN_AFTER_2022;
UPDATE animals SET weight_kg = weight_kg * (-1);
ROLLBACK TO DELETED_BORN_AFTER_2022;
UPDATE animals
SET weight_kg = weight_kg * (-1)
WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animals;

---------------------------------------------------------------------------

SELECT COUNT(id) FROM animals;
-- 10 animals

SELECT COUNT(escape_attempts) FROM animals WHERE escape_attempts = 0;
-- 2 animals

SELECT AVG(weight_kg) FROM animals;
-- 15.55 kg

SELECT neutered, MAX(escape_attempts) as escape_attempts FROM animals GROUP BY neutered;

SELECT species, MAX(weight_kg) as maximum_weight, MIN(weight_kg) as minimum_weight FROM animals GROUP BY species;

SELECT species, AVG(escape_attempts) as escape_attempts FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------

-- Anmials belongs to Melody Pond?

SELECT animals.name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Melody Pond';

-- List all the animals that are pokemon (their type is Pokemon).

SELECT animals.name FROM animals JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.

SELECT owners.full_name, animals.name FROM owners LEFT JOIN animals ON owners.id = animals.owner_id ORDER BY owners.full_name;

-- Animal count per species

SELECT species.name, COUNT(*) as total FROM animals JOIN species ON animals.species_id = species.id GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell

SELECT animals.name FROM animals JOIN species ON animals.species_id = species.id JOIN owners ON animals.owner_id = owners.id WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

-- List all animals owned by Dean Winchester that haven't tried to escape

SELECT animals.name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

-- Who owns the most animals?

SELECT owners.full_name, COUNT(*) as total FROM animals JOIN owners ON animals.owner_id = owners.id GROUP BY owners.full_name ORDER BY total DESC LIMIT 1;