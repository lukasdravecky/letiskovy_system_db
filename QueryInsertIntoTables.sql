TRUNCATE TABLE batozina, letenka, priradenie_brany, let, brana, terminal,
    letisko, lietadlo, letecka_spolocnost, cestujuci,
    stav_batoziny, stav_letu, stav_brany, mesto, krajina
    RESTART IDENTITY CASCADE;

-- KRAJINA
INSERT INTO krajina (nazov) VALUES
                                ('Írsko'),
                                ('Francúzsko'),
                                ('Nemecko'),
                                ('USA'),
                                ('Spojené kráľovstvo'),
                                ('Spojené arabské emiráty'),
                                ('Singapur');

-- MESTO
INSERT INTO mesto (nazov, id_krajina) VALUES
                                          ('Dublin',    1),
                                          ('Paríž',     2),
                                          ('Berlín',    3),
                                          ('New York',  4),
                                          ('Londýn',    5),
                                          ('Dubaj',     6),
                                          ('Singapur',  7);

-- STAV_LETU
INSERT INTO stav_letu (stav, popis) VALUES
                                        ('pristál',   'Let pristál na letisku'),
                                        ('prebieha',  'Let ešte prebieha'),
                                        ('zrušený',   'Let bol zrušený'),
                                        ('mešká',     'Let mešká');

-- STAV_BRANY
INSERT INTO stav_brany (stav, popis) VALUES
                                         ('údržba',   'Brána je v údržbe'),
                                         ('zatvorená','Brána je zatvorená'),
                                         ('otvorená', 'Brána je v prevádzke');

-- STAV_BATOZINY
INSERT INTO stav_batoziny (stav, popis) VALUES
                                            ('evidovaná',   'Batožina je evidovaná v systéme'),
                                            ('uložená',     'Batožina je uložená'),
                                            ('vyzdvihnutá', 'Batožina bola vyzdvihnutá'),
                                            ('odcudzená',   'Batožina je stratená/odcudzená');

-- CESTUJUCI
INSERT INTO cestujuci (meno, priezvisko, cislo_pasu, statna_prislusnost, datum_narodenia) VALUES
                                                                                              ('Ján',       'Novák',     'SK1234567', 'Slovenská',   '1985-03-12'),
                                                                                              ('Petra',     'Dvořáková', 'CZ9876543', 'Česká',       '1992-07-24'),
                                                                                              ('Hans',      'Müller',    'DE4561237', 'Nemecká',     '1978-11-05'),
                                                                                              ('James',     'Thompson',  'GB7894561', 'Anglická',    '1990-01-30'),
                                                                                              ('Valentina', 'García',    'AR3216549', 'Argentínska', '1995-06-18'),
                                                                                              ('Hiroshi',   'Tanaka',    'JP6543219', 'Japonská',    '1983-09-07'),
                                                                                              ('Wei',       'Zhang',     'CN1597534', 'Čínska',      '2000-04-22');

-- LETECKA_SPOLOCNOST
INSERT INTO letecka_spolocnost (nazov, iata_kod, id_krajina) VALUES
                                                                 ('Ryanair',           'FR', 1),
                                                                 ('Emirates',          'EK', 6),
                                                                 ('Lufthansa',         'LH', 3),
                                                                 ('Air France',        'AF', 2),
                                                                 ('British Airways',   'BA', 5),
                                                                 ('American Airlines', 'AA', 4),
                                                                 ('Singapore Airlines','SQ', 7);

-- LIETADLO
INSERT INTO lietadlo (model, kapacita, rok_vyroby, id_spolocnost) VALUES
                                                                      ('Boeing 737',      189, 2015, 1),
                                                                      ('Airbus A380',     525, 2018, 2),
                                                                      ('Airbus A350',     325, 2020, 3),
                                                                      ('Airbus A320neo',  180, 2019, 4),
                                                                      ('Boeing 787',      242, 2017, 5),
                                                                      ('Boeing 777',      396, 2016, 6),
                                                                      ('Airbus A350',     317, 2021, 7);

-- LETISKO
INSERT INTO letisko (nazov, iata_kod, icao_kod, id_mesto) VALUES
                                                              ('Dublin Airport',                        'DUB', 'EIDW', 1),
                                                              ('Paris Charles de Gaulle Airport',       'CDG', 'LFPG', 2),
                                                              ('Berlin Brandenburg Airport',            'BER', 'EDDB', 3),
                                                              ('John F. Kennedy International Airport', 'JFK', 'KJFK', 4),
                                                              ('London Heathrow Airport',               'LHR', 'EGLL', 5),
                                                              ('Dubai International Airport',           'DXB', 'OMDB', 6),
                                                              ('Changi Airport',                        'SIN', 'WSSS', 7);

-- TERMINAL
INSERT INTO terminal (nazov, id_letisko) VALUES
                                             ('Terminal 1',  1),
                                             ('Terminal 2E', 2),
                                             ('Terminal 1',  3),
                                             ('Terminal 4',  4),
                                             ('Terminal 5',  5),
                                             ('Terminal 3',  6),
                                             ('Terminal 3',  7);

-- BRANA
INSERT INTO brana (cislo_brany, id_stav_brany, id_terminal) VALUES
                                                                ('B12',   3, 1),
                                                                ('E45',   3, 2),
                                                                ('T1-23', 3, 3),
                                                                ('4A',    3, 4),
                                                                ('5C',    3, 5),
                                                                ('C32',   3, 6),
                                                                ('T3-18', 3, 7);

-- LET
INSERT INTO let (cislo_letu, cas_odletu, cas_priletu, id_lietadlo, id_stav_letu, id_odletove_letisko, id_priletove_letisko) VALUES
-- LH456: Berlín (BER, +01) -> Paríž (CDG, +01)
('LH456', '2026-03-05 08:30:00+01', '2026-03-05 10:45:00+01', 3, 2, 3, 2),
-- EK789: Dubaj (DXB, +04) -> Londýn (LHR, +00)
('EK789', '2026-03-05 14:15:00+04', '2026-03-05 23:30:00+00', 2, 2, 6, 5),
-- FR123: Dublin (DUB, +00) -> Berlín (BER, +01)
('FR123', '2026-03-05 07:00:00+00', '2026-03-05 08:25:00+01', 1, 2, 1, 3),
-- AF456: Paríž (CDG, +01) -> Londýn (LHR, +00)
('AF456', '2026-03-05 10:00:00+01', '2026-03-05 11:30:00+00', 4, 2, 2, 5),
-- BA789: Londýn (LHR, +00) -> New York (JFK, -05)
('BA789', '2026-03-05 16:45:00+00', '2026-03-05 19:15:00-05', 5, 2, 5, 4),
-- AA321: New York (JFK, -05) -> Londýn (LHR, +00)
('AA321', '2026-03-05 09:15:00-05', '2026-03-05 16:15:00+00', 6, 2, 4, 5),
-- SQ654: Singapur (SIN, +08) -> Dubaj (DXB, +04)
('SQ654', '2026-03-05 22:00:00+08', '2026-03-06 06:30:00+04', 7, 2, 7, 6);-- PRIRADENIE_BRANY

-- PRIRADENIE_BRANY
INSERT INTO priradenie_brany (id_brana, id_let, cas_od, cas_do) VALUES
                                                                    (3, 1, '2026-03-05 05:00:00+01', '2026-03-05 06:30:00+01'), -- BER
                                                                    (6, 2, '2026-03-05 12:15:00+04', '2026-03-05 13:45:00+04'), -- DXB
                                                                    (1, 3, '2026-03-05 06:30:00+00', '2026-03-05 08:00:00+00'), -- DUB
                                                                    (2, 4, '2026-03-05 08:00:00+01', '2026-03-05 09:30:00+01'), -- CDG
                                                                    (5, 5, '2026-03-05 14:45:00+00', '2026-03-05 16:15:00+00'), -- LHR
                                                                    (4, 6, '2026-03-05 07:15:00-05', '2026-03-05 08:45:00-05'), -- JFK
                                                                    (7, 7, '2026-03-05 20:00:00+08', '2026-03-05 21:30:00+08'); -- SIN

-- LETENKA
INSERT INTO letenka (cislo_sedadla, je_business, cena, datum_rezervacie, id_cestujuci, id_let) VALUES
                                                                                                   ('12A', TRUE,    450.00, '2026-02-05 08:00:00+01', 1, 1), -- rezervované z EU
                                                                                                   ('5B',  FALSE,   120.50, '2026-02-05 14:15:00+04', 2, 2), -- Dubaj
                                                                                                   ('3C',  TRUE,    890.00, '2026-02-05 07:00:00+00', 3, 3), -- Dublin
                                                                                                   ('22F', FALSE,    75.00, '2026-02-05 10:00:00+01', 4, 4), -- Paríž
                                                                                                   ('7D',  FALSE,   200.00, '2026-02-05 16:45:00+00', 5, 5), -- Londýn
                                                                                                   ('1A',  TRUE,   1200.00, '2026-02-05 09:15:00-05', 6, 6), -- New York
                                                                                                   ('14E', FALSE,    95.00, '2026-02-05 22:00:00+08', 7, 7); -- Singapur-- BATOZINA

INSERT INTO batozina (hmotnost, typ, id_stav_batoziny, id_letenka) VALUES
                                                                       (23.5, 'kufor',          1, 1),
                                                                       ( 8.0, 'ruksak',         1, 2),
                                                                       (32.0, 'kufor',          1, 3),
                                                                       ( 5.5, 'taška',          1, 4),
                                                                       (18.0, 'kufor',          1, 5),
                                                                       (12.0, 'ruksak',         1, 6),
                                                                       (27.3, 'športová taška', 1, 7);