-- Pohľad: Nájdi všetkých cestujúcich narodených v 80. rokoch (minulosť z pohľadu 2026 roku)
CREATE OR REPLACE VIEW cestujuci_narodeni_80_roky AS
SELECT
    id_cestujuci,
    meno,
    priezvisko,
    cislo_pasu,
    statna_prislusnost,
    datum_narodenia,
    EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM datum_narodenia) AS vek
FROM cestujuci
WHERE EXTRACT(YEAR FROM datum_narodenia) BETWEEN 1980 AND 1989
ORDER BY datum_narodenia DESC;

-- Pohľad: Nájdi všetky lietadlá s vysokou kapacitou (viac ako 300 miest)
CREATE OR REPLACE VIEW lietadla_vysoka_kapacita AS
SELECT
    id_lietadlo,
    model,
    kapacita,
    rok_vyroby,
    id_spolocnost,
    CASE
        WHEN kapacita >= 500 THEN 'Veľmi vysoká kapacita'
        WHEN kapacita >= 300 THEN 'Vysoká kapacita'
    END AS kategoria_kapacity
FROM lietadlo
WHERE kapacita > 300
ORDER BY kapacita DESC;

-- ===========================================================================================
-- POHĽADY SO SPÁJANÍM TABULIEK
-- ===========================================================================================

-- Pohľad: Zoznam všetkých lietadiel s informáciami o leteckej spoločnosti (spojenie 2 tabuliek)
-- Úloha: Nájdi všetky lietadlá a identifikuj, ktorej leteckej spoločnosti patria
CREATE OR REPLACE VIEW lietadla_so_spolocnostami AS
SELECT
    l.id_lietadlo,
    l.model,
    l.kapacita,
    l.rok_vyroby,
    ls.nazov AS nazov_spolocnosti,
    ls.iata_kod AS iata_kod_spolocnosti,
    k.nazov AS krajina_spolocnosti
FROM lietadlo l
INNER JOIN letecka_spolocnost ls ON l.id_spolocnost = ls.id_spolocnost
INNER JOIN krajina k ON ls.id_krajina = k.id_krajina
ORDER BY ls.nazov, l.model;

-- Pohľad: Detailný zoznam letov s úplnými informáciami (spojenie 3+ tabuliek)
-- Úloha: Nájdi informácie o letoch vrátane lietadiel, leteckých spoločností a letísk
CREATE OR REPLACE VIEW lety_s_detailmi AS
SELECT
    l.id_let,
    l.cislo_letu,
    l.cas_odletu,
    l.cas_priletu,
    lp.model AS model_lietadla,
    ls.nazov AS letecka_spolocnost,
    leto.stav AS stav_letu,
    odo.nazov AS odletove_letisko,
    odo.iata_kod AS iata_odletove,
    pri.nazov AS priletove_letisko,
    pri.iata_kod AS iata_priletove,
    m_odo.nazov AS mesto_odletu,
    m_pri.nazov AS mesto_priletu
FROM let l
INNER JOIN lietadlo lp ON l.id_lietadlo = lp.id_lietadlo
INNER JOIN letecka_spolocnost ls ON lp.id_spolocnost = ls.id_spolocnost
INNER JOIN stav_letu leto ON l.id_stav_letu = leto.id_stav_letu
INNER JOIN letisko odo ON l.id_odletove_letisko = odo.id_letisko
INNER JOIN letisko pri ON l.id_priletove_letisko = pri.id_letisko
INNER JOIN mesto m_odo ON odo.id_mesto = m_odo.id_mesto
INNER JOIN mesto m_pri ON pri.id_mesto = m_pri.id_mesto
ORDER BY l.cas_odletu DESC;

-- Pohľad: Cestujúci a ich letenky (s OUTER JOIN pre prípad budúcich rozšírení)
-- Úloha: Nájdi všetkých cestujúcich a ich letenky, vrátane info o letoch
CREATE OR REPLACE VIEW cestujuci_a_letenky AS
SELECT
    c.id_cestujuci,
    c.meno,
    c.priezvisko,
    c.cislo_pasu,
    c.statna_prislusnost,
    CASE WHEN l.id_letenka IS NOT NULL THEN 'Má letenku'::TEXT ELSE 'Bez letenky'::TEXT END AS stav,
    l.id_letenka,
    l.cislo_sedadla,
    l.je_business,
    l.cena,
    l.datum_rezervacie,
    let.cislo_letu,
    let.cas_odletu,
    let.cas_priletu
FROM cestujuci c
LEFT OUTER JOIN letenka l ON c.id_cestujuci = l.id_cestujuci
LEFT OUTER JOIN let ON l.id_let = let.id_let
ORDER BY c.priezvisko, c.meno;

-- ===========================================================================================
-- POHĽADY S AGREGAČNÝMI FUNKCIAMI ALEBO ZOSKUPENÍM
-- ===========================================================================================

-- Pohľad: Počet letov a priemerný čas letu podľa leteckej spoločnosti
-- Úloha: Nájdi štatistiky letov (počet a priemerný čas) pre každú leteckú spoločnosť
CREATE OR REPLACE VIEW statistiky_letov_podla_spolocnosti AS
SELECT
    ls.id_spolocnost,
    ls.nazov AS nazov_spolocnosti,
    ls.iata_kod,
    COUNT(l.id_let) AS pocet_letov,
    AVG(EXTRACT(EPOCH FROM (l.cas_priletu - l.cas_odletu))/3600)::NUMERIC(5,2) AS priemerna_dlzka_letu_hodiny,
    MIN(l.cas_odletu) AS najstarsi_odlet,
    MAX(l.cas_priletu) AS najnovsi_prilet
FROM letecka_spolocnost ls
LEFT JOIN lietadlo lp ON ls.id_spolocnost = lp.id_spolocnost
LEFT JOIN let l ON lp.id_lietadlo = l.id_lietadlo
GROUP BY ls.id_spolocnost, ls.nazov, ls.iata_kod
ORDER BY COUNT(l.id_let) DESC;

-- Pohľad: Priemerná cena leteniek, počet rezervácií a celkové tržby podľa typu kabíny
-- Úloha: Nájdi finančnú analýzu leteniek rozdelenú na business a ekonomickú triedu
CREATE OR REPLACE VIEW financna_analyza_leteniek AS
SELECT
    CASE WHEN je_business = TRUE THEN 'Business trieda' ELSE 'Ekonomická trieda' END AS trieda_letenky,
    COUNT(id_letenka) AS pocet_leteniek,
    AVG(cena)::NUMERIC(10,2) AS priemerna_cena,
    MIN(cena)::NUMERIC(10,2) AS minimalna_cena,
    MAX(cena)::NUMERIC(10,2) AS maximalna_cena,
    SUM(cena)::NUMERIC(12,2) AS celkove_trzby,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY cena)::NUMERIC(10,2) AS median_ceny
FROM letenka
GROUP BY je_business
ORDER BY je_business DESC;

