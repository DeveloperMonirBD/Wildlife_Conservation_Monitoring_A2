-- rangers Table:
CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    region TEXT NOT NULL
);

INSERT INTO rangers (name, region) VALUES
('Alice Green', 'Northern Hills'),
('Bob White', 'River Delta'),
('Carol King', 'Mountain Range');

SELECT * from rangers;

-- species Table:
CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name TEXT NOT NULL,
    scientific_name TEXT NOT NULL,
    discovery_date DATE DEFAULT CURRENT_DATE,
    conservation_status TEXT CHECK (conservation_status IN ('Endangered', 'Vulnerable', 'Least Concern'))
);

INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status) VALUES
('Shadow Leopard', 'Panthera umbra', '1995-08-21', 'Endangered'),
('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');

SELECT * from species;

-- sightings Table:
CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    ranger_id INT REFERENCES rangers(ranger_id) ON DELETE CASCADE,
    species_id INT REFERENCES species(species_id) ON DELETE CASCADE,
    sighting_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    location TEXT NOT NULL,
    notes TEXT
);

INSERT INTO sightings (ranger_id, species_id, sighting_time, location, notes) VALUES
(1, 1, '2024-05-10 07:45:00', 'Peak Ridge', 'Camera trap image captured'),
(2, 2, '2024-05-12 16:20:00', 'Bankwood Area', 'Juvenile seen'),
(3, 3, '2024-05-15 09:10:00', 'Bamboo Grove East', 'Feeding observed'),
(2, 1, '2024-05-18 18:30:00', 'Snowfall Pass', NULL);

SELECT * FROM sightings;

-- Problem: 1
SELECT * from rangers;
INSERT INTO rangers (name, region) VALUES ('Derek Fox', 'Coastal Plains');

-- Problem: 2
SELECT * from sightings;
SELECT COUNT(DISTINCT species_id) AS unique_species_count FROM sightings;

-- Problem: 3
SELECT * from sightings;
SELECT * FROM sightings WHERE location LIKE '%Pass%';

-- Problem: 4
SELECT * from rangers;
SELECT * from sightings;
SELECT r.name, COUNT(s.sighting_id) AS total_sightings
FROM rangers r
LEFT JOIN sightings s ON r.ranger_id = s.ranger_id
GROUP BY r.name;

-- Problem: 5
SELECT * from species;
SELECT * from sightings;
SELECT common_name FROM species 
WHERE species_id NOT IN (SELECT DISTINCT species_id FROM sightings);

-- Problem: 6
SELECT * from rangers;
SELECT * from species;
SELECT * from sightings;
SELECT sp.common_name, s.sighting_time, r.name
FROM sightings s
JOIN species sp ON s.species_id = sp.species_id
JOIN rangers r ON s.ranger_id = r.ranger_id
ORDER BY s.sighting_time DESC
LIMIT 2;

-- Problem: 7
SELECT * from species;
UPDATE species 
SET conservation_status = 'Historic' 
WHERE discovery_date < '1800-01-01';

-- Problem: 8
SELECT * from sightings;
SELECT sighting_id, 
       CASE 
           WHEN EXTRACT(HOUR FROM sighting_time) < 12 THEN 'Morning'
           WHEN EXTRACT(HOUR FROM sighting_time) BETWEEN 12 AND 17 THEN 'Afternoon'
           ELSE 'Evening'
       END AS time_of_day
FROM sightings;

-- Problem: 9
SELECT * from rangers;
SELECT * from sightings;
DELETE FROM rangers 
WHERE ranger_id NOT IN (SELECT DISTINCT ranger_id FROM sightings);