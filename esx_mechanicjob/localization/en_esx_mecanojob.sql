USE `es_extended`;

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_mechanic', 'Mechaniker', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_mechanic', 'Mechaniker', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('mechanic', 'Mechaniker')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('mechanic',0,'recrue','Pannenhilfe',12,'{}','{}'),
	('mechanic',1,'novice','Auszubildender',24,'{}','{}'),
	('mechanic',2,'experimente','Tuner',36,'{}','{}'),
	('mechanic',3,'chief','Stv.Geschäftsführer',48,'{}','{}'),
	('mechanic',4,'boss','Geschäftsführer',0,'{}','{}')
;

INSERT INTO `items` (name, label, weight) VALUES
	('gazbottle', 'Benzin Kanister', 2),
	('fixtool', 'Reparatur-Werkzeuge', 2),
	('carotool', 'Werkzeuge', 2),
	('blowpipe', 'Schweißbrenner', 2),
	('fixkit', 'Reparatur-Set', 3),
	('carokit', 'Karosserie-Bausatz', 3)
;
