TRUNCATE TABLE batozina, letenka, priradenie_brany, let, brana, terminal,
letisko, lietadlo, letecka_spolocnost, cestujuci,
stav_batoziny, stav_letu, stav_brany, mesto, krajina
CASCADE;

-- KRAJINA
INSERT INTO krajina (id_krajina, nazov) VALUES
(1, 'Írsko'),
(2, 'Francúzsko'),
(3, 'Nemecko'),
(4, 'USA'),
(5, 'Spojené kráľovstvo'),
(6, 'Spojené arabské emiráty'),
(7, 'Singapur');

-- MESTO
INSERT INTO mesto (id_mesto, nazov, id_krajina) VALUES
(1, 'Dublin', 1),
(2, 'Paríž', 2),
(3, 'Berlín', 3),
(4, 'New York', 4),
(5, 'Londýn', 5),
(6, 'Dubaj', 6),
(7, 'Singapur', 7);

-- STAV_LETU
INSERT INTO stav_letu (id_stav_letu, stav, popis) VALUES
(1, 'pristál', 'Let pristál na letisku'),
(2, 'prebieha', 'Let ešte prebieha'),
(3, 'zrušený', 'Let bol zrušený'),
(4, 'mešká', 'Let mešká');

-- STAV_BRANY
INSERT INTO stav_brany (id_stav_brany, stav, popis) VALUES
(1, 'údržba', 'Brána je v údržbe'),
(2, 'zatvorená', 'Brána je zatvorená'),
(3, 'otvorená', 'Brána je v prevádzke');

-- STAV_BATOZINY
INSERT INTO stav_batoziny (id_stav_batoziny, stav, popis) VALUES
(1, 'evidovaná', 'Batožina je evidovaná v systéme'),
(2, 'uložená', 'Batožina je uložená'),
(3, 'vyzdvihnutá', 'Batožina bola vyzdvihnutá'),
(4, 'odcudzená', 'Batožina je stratená/odcudzená');

-- CESTUJUCI
INSERT INTO cestujuci (id_cestujuci, meno, priezvisko, cislo_pasu, statna_prislusnost, datum_narodenia) VALUES
(1, 'Ján', 'Novák', 'SK1234567', 'Slovenská', '1985-03-12'),
(2, 'Petra', 'Dvořáková', 'CZ9876543', 'Česká', '1992-07-24'),
(3, 'Hans', 'Müller', 'DE4561237', 'Nemecká', '1978-11-05'),
(4, 'James', 'Thompson', 'GB7894561', 'Anglická', '1990-01-30'),
(5, 'Valentina', 'García', 'AR3216549', 'Argentínska', '1995-06-18'),
(6, 'Hiroshi', 'Tanaka', 'JP6543219', 'Japonská', '1983-09-07'),
(7, 'Wei', 'Zhang', 'CN1597534', 'Čínska', '2000-04-22');

-- LETECKA_SPOLOCNOST
INSERT INTO letecka_spolocnost (id_spolocnost, nazov, iata_kod, id_krajina) VALUES
(1, 'Ryanair', 'FR', 1),
(2, 'Emirates', 'EK', 6),
(3, 'Lufthansa', 'LH', 3),
(4, 'Air France', 'AF', 2),
(5, 'British Airways', 'BA', 5),
(6, 'American Airlines', 'AA', 4),
(7, 'Singapore Airlines', 'SQ', 7);

-- LIETADLO
INSERT INTO lietadlo (id_lietadlo, model, kapacita, rok_vyroby, id_spolocnost) VALUES
(1, 'Boeing 737', 189, 2015, 1),
(2, 'Airbus A380', 525, 2018, 2),
(3, 'Airbus A350', 325, 2020, 3),
(4, 'Airbus A320neo', 180, 2019, 4),
(5, 'Boeing 787', 242, 2017, 5),
(6, 'Boeing 777', 396, 2016, 6),
(7, 'Airbus A350', 317, 2021, 7);