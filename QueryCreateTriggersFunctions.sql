-- =============================================================================
-- ČASŤ 4: SEKVENCIE A TRIGGERY NA AUTOINKREMENTÁCIU
-- =============================================================================
-- Sekvencie začínajú od 8 – nadväzujú na ručne vložené záznamy (id 1–7).
-- BEFORE INSERT trigger nastaví id na NEXTVAL(sekvencia) ak je NULL,
-- čím používateľ pri bežnom INSERT id zadávať nemusí.
-- =============================================================================

DROP SEQUENCE IF EXISTS seq_krajina            CASCADE;
DROP SEQUENCE IF EXISTS seq_mesto              CASCADE;
DROP SEQUENCE IF EXISTS seq_letisko            CASCADE;
DROP SEQUENCE IF EXISTS seq_terminal           CASCADE;
DROP SEQUENCE IF EXISTS seq_stav_brany         CASCADE;
DROP SEQUENCE IF EXISTS seq_brana              CASCADE;
DROP SEQUENCE IF EXISTS seq_letecka_spolocnost CASCADE;
DROP SEQUENCE IF EXISTS seq_lietadlo           CASCADE;
DROP SEQUENCE IF EXISTS seq_stav_letu          CASCADE;
DROP SEQUENCE IF EXISTS seq_let                CASCADE;
DROP SEQUENCE IF EXISTS seq_priradenie_brany   CASCADE;
DROP SEQUENCE IF EXISTS seq_cestujuci          CASCADE;
DROP SEQUENCE IF EXISTS seq_letenka            CASCADE;
DROP SEQUENCE IF EXISTS seq_stav_batoziny      CASCADE;
DROP SEQUENCE IF EXISTS seq_batozina           CASCADE;

CREATE SEQUENCE seq_krajina            START WITH 8 INCREMENT BY 1;
CREATE SEQUENCE seq_mesto              START WITH 8 INCREMENT BY 1;
CREATE SEQUENCE seq_letisko            START WITH 8 INCREMENT BY 1;
CREATE SEQUENCE seq_terminal           START WITH 8 INCREMENT BY 1;
CREATE SEQUENCE seq_stav_brany         START WITH 8 INCREMENT BY 1;
CREATE SEQUENCE seq_brana              START WITH 8 INCREMENT BY 1;
CREATE SEQUENCE seq_letecka_spolocnost START WITH 8 INCREMENT BY 1;
CREATE SEQUENCE seq_lietadlo           START WITH 8 INCREMENT BY 1;
CREATE SEQUENCE seq_stav_letu          START WITH 8 INCREMENT BY 1;
CREATE SEQUENCE seq_let                START WITH 8 INCREMENT BY 1;
CREATE SEQUENCE seq_priradenie_brany   START WITH 8 INCREMENT BY 1;
CREATE SEQUENCE seq_cestujuci          START WITH 8 INCREMENT BY 1;
CREATE SEQUENCE seq_letenka            START WITH 8 INCREMENT BY 1;
CREATE SEQUENCE seq_stav_batoziny      START WITH 8 INCREMENT BY 1;
CREATE SEQUENCE seq_batozina           START WITH 8 INCREMENT BY 1;

-- krajina
CREATE OR REPLACE FUNCTION trg_fn_ai_krajina()
    RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
    IF NEW.id_krajina IS NULL THEN
        NEW.id_krajina := NEXTVAL('seq_krajina');
    END IF;
    RETURN NEW;
END;
$$;
DROP TRIGGER IF EXISTS trg_ai_krajina ON krajina;
CREATE TRIGGER trg_ai_krajina
    BEFORE INSERT ON krajina
    FOR EACH ROW EXECUTE FUNCTION trg_fn_ai_krajina();

-- mesto
CREATE OR REPLACE FUNCTION trg_fn_ai_mesto()
    RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
    IF NEW.id_mesto IS NULL THEN
        NEW.id_mesto := NEXTVAL('seq_mesto');
    END IF;
    RETURN NEW;
END;
$$;
DROP TRIGGER IF EXISTS trg_ai_mesto ON mesto;
CREATE TRIGGER trg_ai_mesto
    BEFORE INSERT ON mesto
    FOR EACH ROW EXECUTE FUNCTION trg_fn_ai_mesto();

-- letisko
CREATE OR REPLACE FUNCTION trg_fn_ai_letisko()
    RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
    IF NEW.id_letisko IS NULL THEN
        NEW.id_letisko := NEXTVAL('seq_letisko');
    END IF;
    RETURN NEW;
END;
$$;
DROP TRIGGER IF EXISTS trg_ai_letisko ON letisko;
CREATE TRIGGER trg_ai_letisko
    BEFORE INSERT ON letisko
    FOR EACH ROW EXECUTE FUNCTION trg_fn_ai_letisko();

-- terminal
CREATE OR REPLACE FUNCTION trg_fn_ai_terminal()
    RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
    IF NEW.id_terminal IS NULL THEN
        NEW.id_terminal := NEXTVAL('seq_terminal');
    END IF;
    RETURN NEW;
END;
$$;
DROP TRIGGER IF EXISTS trg_ai_terminal ON terminal;
CREATE TRIGGER trg_ai_terminal
    BEFORE INSERT ON terminal
    FOR EACH ROW EXECUTE FUNCTION trg_fn_ai_terminal();

-- stav_brany
CREATE OR REPLACE FUNCTION trg_fn_ai_stav_brany()
    RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
    IF NEW.id_stav_brany IS NULL THEN
        NEW.id_stav_brany := NEXTVAL('seq_stav_brany');
    END IF;
    RETURN NEW;
END;
$$;
DROP TRIGGER IF EXISTS trg_ai_stav_brany ON stav_brany;
CREATE TRIGGER trg_ai_stav_brany
    BEFORE INSERT ON stav_brany
    FOR EACH ROW EXECUTE FUNCTION trg_fn_ai_stav_brany();

-- brana
CREATE OR REPLACE FUNCTION trg_fn_ai_brana()
    RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
    IF NEW.id_brana IS NULL THEN
        NEW.id_brana := NEXTVAL('seq_brana');
    END IF;
    RETURN NEW;
END;
$$;
DROP TRIGGER IF EXISTS trg_ai_brana ON brana;
CREATE TRIGGER trg_ai_brana
    BEFORE INSERT ON brana
    FOR EACH ROW EXECUTE FUNCTION trg_fn_ai_brana();

-- letecka_spolocnost
CREATE OR REPLACE FUNCTION trg_fn_ai_letecka_spolocnost()
    RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
    IF NEW.id_spolocnost IS NULL THEN
        NEW.id_spolocnost := NEXTVAL('seq_letecka_spolocnost');
    END IF;
    RETURN NEW;
END;
$$;
DROP TRIGGER IF EXISTS trg_ai_letecka_spolocnost ON letecka_spolocnost;
CREATE TRIGGER trg_ai_letecka_spolocnost
    BEFORE INSERT ON letecka_spolocnost
    FOR EACH ROW EXECUTE FUNCTION trg_fn_ai_letecka_spolocnost();

-- lietadlo
CREATE OR REPLACE FUNCTION trg_fn_ai_lietadlo()
    RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
    IF NEW.id_lietadlo IS NULL THEN
        NEW.id_lietadlo := NEXTVAL('seq_lietadlo');
    END IF;
    RETURN NEW;
END;
$$;
DROP TRIGGER IF EXISTS trg_ai_lietadlo ON lietadlo;
CREATE TRIGGER trg_ai_lietadlo
    BEFORE INSERT ON lietadlo
    FOR EACH ROW EXECUTE FUNCTION trg_fn_ai_lietadlo();

-- stav_letu
CREATE OR REPLACE FUNCTION trg_fn_ai_stav_letu()
    RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
    IF NEW.id_stav_letu IS NULL THEN
        NEW.id_stav_letu := NEXTVAL('seq_stav_letu');
    END IF;
    RETURN NEW;
END;
$$;
DROP TRIGGER IF EXISTS trg_ai_stav_letu ON stav_letu;
CREATE TRIGGER trg_ai_stav_letu
    BEFORE INSERT ON stav_letu
    FOR EACH ROW EXECUTE FUNCTION trg_fn_ai_stav_letu();

-- let
CREATE OR REPLACE FUNCTION trg_fn_ai_let()
    RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
    IF NEW.id_let IS NULL THEN
        NEW.id_let := NEXTVAL('seq_let');
    END IF;
    RETURN NEW;
END;
$$;
DROP TRIGGER IF EXISTS trg_ai_let ON let;
CREATE TRIGGER trg_ai_let
    BEFORE INSERT ON let
    FOR EACH ROW EXECUTE FUNCTION trg_fn_ai_let();

-- priradenie_brany
CREATE OR REPLACE FUNCTION trg_fn_ai_priradenie_brany()
    RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
    IF NEW.id_priradenie IS NULL THEN
        NEW.id_priradenie := NEXTVAL('seq_priradenie_brany');
    END IF;
    RETURN NEW;
END;
$$;
DROP TRIGGER IF EXISTS trg_ai_priradenie_brany ON priradenie_brany;
CREATE TRIGGER trg_ai_priradenie_brany
    BEFORE INSERT ON priradenie_brany
    FOR EACH ROW EXECUTE FUNCTION trg_fn_ai_priradenie_brany();

-- cestujuci
CREATE OR REPLACE FUNCTION trg_fn_ai_cestujuci()
    RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
    IF NEW.id_cestujuci IS NULL THEN
        NEW.id_cestujuci := NEXTVAL('seq_cestujuci');
    END IF;
    RETURN NEW;
END;
$$;
DROP TRIGGER IF EXISTS trg_ai_cestujuci ON cestujuci;
CREATE TRIGGER trg_ai_cestujuci
    BEFORE INSERT ON cestujuci
    FOR EACH ROW EXECUTE FUNCTION trg_fn_ai_cestujuci();

-- letenka
CREATE OR REPLACE FUNCTION trg_fn_ai_letenka()
    RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
    IF NEW.id_letenka IS NULL THEN
        NEW.id_letenka := NEXTVAL('seq_letenka');
    END IF;
    RETURN NEW;
END;
$$;
DROP TRIGGER IF EXISTS trg_ai_letenka ON letenka;
CREATE TRIGGER trg_ai_letenka
    BEFORE INSERT ON letenka
    FOR EACH ROW EXECUTE FUNCTION trg_fn_ai_letenka();

-- stav_batoziny
CREATE OR REPLACE FUNCTION trg_fn_ai_stav_batoziny()
    RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
    IF NEW.id_stav_batoziny IS NULL THEN
        NEW.id_stav_batoziny := NEXTVAL('seq_stav_batoziny');
    END IF;
    RETURN NEW;
END;
$$;
DROP TRIGGER IF EXISTS trg_ai_stav_batoziny ON stav_batoziny;
CREATE TRIGGER trg_ai_stav_batoziny
    BEFORE INSERT ON stav_batoziny
    FOR EACH ROW EXECUTE FUNCTION trg_fn_ai_stav_batoziny();

-- batozina
CREATE OR REPLACE FUNCTION trg_fn_ai_batozina()
    RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
    IF NEW.id_batozina IS NULL THEN
        NEW.id_batozina := NEXTVAL('seq_batozina');
    END IF;
    RETURN NEW;
END;
$$;
DROP TRIGGER IF EXISTS trg_ai_batozina ON batozina;
CREATE TRIGGER trg_ai_batozina
    BEFORE INSERT ON batozina
    FOR EACH ROW EXECUTE FUNCTION trg_fn_ai_batozina();


-- =============================================================================
-- ČASŤ 5: TRI NOVÉ POHĽADY (odovzdávka 3)
-- =============================================================================

-- -----------------------------------------------------------------------------
-- POHĽAD 1 – MNOŽINOVÉ OPERÁCIE (UNION)
-- Úloha: Nájdi všetky letiská, ktoré slúžia ako odletové ALEBO priletové
--        letisko aspoň jedného letu, a zisti, v ktorej krajine sa nachádzajú.
--        Každé letisko sa zobrazí len raz bez ohľadu na to, ako často sa
--        vyskytuje v tabuľke letov.
-- -----------------------------------------------------------------------------
CREATE OR REPLACE VIEW letiská_zapojené_do_letov AS
SELECT
    le.id_letisko,
    le.nazov     AS nazov_letiska,
    le.iata_kod,
    m.nazov      AS mesto,
    k.nazov      AS krajina,
    'odletové'   AS typ_ulohy
FROM letisko le
         INNER JOIN mesto m   ON le.id_mesto  = m.id_mesto
         INNER JOIN krajina k ON m.id_krajina = k.id_krajina
WHERE le.id_letisko IN (SELECT id_odletove_letisko FROM let)

UNION

SELECT
    le.id_letisko,
    le.nazov     AS nazov_letiska,
    le.iata_kod,
    m.nazov      AS mesto,
    k.nazov      AS krajina,
    'priletové'  AS typ_ulohy
FROM letisko le
         INNER JOIN mesto m   ON le.id_mesto  = m.id_mesto
         INNER JOIN krajina k ON m.id_krajina = k.id_krajina
WHERE le.id_letisko IN (SELECT id_priletove_letisko FROM let)

ORDER BY nazov_letiska;

-- -----------------------------------------------------------------------------
-- POHĽAD 2 – VNORENÝ PODDOPYT (EXISTS + skalárny poddopyt)
-- Úloha: Nájdi všetkých cestujúcich, ktorí majú aspoň jednu letenku
--        v business triede, a zobraz ich celé meno, číslo pasu a krajinu
--        príslušnosti. Tieto osoby sú potenciálnymi VIP zákazníkmi.
-- -----------------------------------------------------------------------------
CREATE OR REPLACE VIEW vip_cestujuci AS
SELECT
    c.id_cestujuci,
    c.meno,
    c.priezvisko,
    c.cislo_pasu,
    c.statna_prislusnost,
    c.datum_narodenia,
    (
        SELECT COUNT(*)
        FROM letenka l
        WHERE l.id_cestujuci = c.id_cestujuci
          AND l.je_business = TRUE
    ) AS pocet_business_leteniek
FROM cestujuci c
WHERE EXISTS (
    SELECT 1
    FROM letenka l
    WHERE l.id_cestujuci = c.id_cestujuci
      AND l.je_business = TRUE
)
ORDER BY c.priezvisko, c.meno;

-- -----------------------------------------------------------------------------
-- POHĽAD 3 – VNORENÝ PODDOPYT (HAVING s poddopytom na celkovú priemernú cenu)
-- Úloha: Nájdi všetky lety, ktorých priemerná cena letenky je vyššia ako
--        celková priemerná cena letenky naprieč všetkými letmi. Zobraz
--        aj počet cestujúcich a celkové tržby daného letu.
-- -----------------------------------------------------------------------------
CREATE OR REPLACE VIEW nadpriemerné_lety AS
SELECT
    l.id_let,
    l.cislo_letu,
    l.cas_odletu,
    l.cas_priletu,
    olo.nazov                       AS odletove_letisko,
    plo.nazov                       AS priletove_letisko,
    COUNT(lt.id_letenka)            AS pocet_cestujucich,
    AVG(lt.cena)::NUMERIC(10,2)     AS priemerna_cena_letenky,
    SUM(lt.cena)::NUMERIC(12,2)     AS celkove_trzby
FROM let l
         INNER JOIN letisko olo ON l.id_odletove_letisko  = olo.id_letisko
         INNER JOIN letisko plo ON l.id_priletove_letisko = plo.id_letisko
         INNER JOIN letenka lt  ON l.id_let               = lt.id_let
GROUP BY l.id_let, l.cislo_letu, l.cas_odletu, l.cas_priletu,
         olo.nazov, plo.nazov
HAVING AVG(lt.cena) > (
    SELECT AVG(cena) FROM letenka
)
ORDER BY priemerna_cena_letenky DESC;


-- =============================================================================
-- ČASŤ 6: ZMYSLUPLNÉ TRIGGERY (odovzdávka 3)
-- =============================================================================

-- -----------------------------------------------------------------------------
-- ZMYSLUPLNÝ TRIGGER 1: Kontrola obsadenosti lietadla (anti-overbooking)
-- Účel: Pred vložením novej letenky overí, či počet predaných leteniek
--       na daný let neprekročil kapacitu priradeného lietadla.
--       Ak áno, vloženie zamietne s chybovým hlásením.
-- -----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION trg_fn_kontrola_kapacity()
    RETURNS TRIGGER LANGUAGE plpgsql AS $$
DECLARE
    v_kapacita  INT;
    v_predane   INT;
BEGIN
    SELECT lp.kapacita
    INTO v_kapacita
    FROM let l
             INNER JOIN lietadlo lp ON l.id_lietadlo = lp.id_lietadlo
    WHERE l.id_let = NEW.id_let;

    SELECT COUNT(*)
    INTO v_predane
    FROM letenka
    WHERE id_let = NEW.id_let;

    IF v_predane >= v_kapacita THEN
        RAISE EXCEPTION
            'Let % je plne obsadený. Kapacita lietadla: %, predané letenky: %.',
            NEW.id_let, v_kapacita, v_predane;
    END IF;

    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_kontrola_kapacity ON letenka;
CREATE TRIGGER trg_kontrola_kapacity
    BEFORE INSERT ON letenka
    FOR EACH ROW EXECUTE FUNCTION trg_fn_kontrola_kapacity();

-- -----------------------------------------------------------------------------
-- ZMYSLUPLNÝ TRIGGER 2: INSTEAD OF INSERT + UPDATE na pohľade vip_cestujuci
-- Účel: Pohľad vip_cestujuci nie je inherentne editovateľný (obsahuje
--       EXISTS poddopyt a skalárnu agregáciu). Trigger umožní vkladať
--       a upravovať cestujúcich priamo cez pohľad.
-- -----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION trg_fn_insert_vip_cestujuci()
    RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO cestujuci (
        meno, priezvisko, cislo_pasu, statna_prislusnost, datum_narodenia
    ) VALUES (
                 NEW.meno, NEW.priezvisko, NEW.cislo_pasu,
                 NEW.statna_prislusnost, NEW.datum_narodenia
             );
    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_insert_vip_cestujuci ON vip_cestujuci;
CREATE TRIGGER trg_insert_vip_cestujuci
    INSTEAD OF INSERT ON vip_cestujuci
    FOR EACH ROW EXECUTE FUNCTION trg_fn_insert_vip_cestujuci();

CREATE OR REPLACE FUNCTION trg_fn_update_vip_cestujuci()
    RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
    UPDATE cestujuci
    SET meno               = NEW.meno,
        priezvisko         = NEW.priezvisko,
        cislo_pasu         = NEW.cislo_pasu,
        statna_prislusnost = NEW.statna_prislusnost,
        datum_narodenia    = NEW.datum_narodenia
    WHERE id_cestujuci = OLD.id_cestujuci;
    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_update_vip_cestujuci ON vip_cestujuci;
CREATE TRIGGER trg_update_vip_cestujuci
    INSTEAD OF UPDATE ON vip_cestujuci
    FOR EACH ROW EXECUTE FUNCTION trg_fn_update_vip_cestujuci();


-- =============================================================================
-- ČASŤ 7: ULOŽENÁ PROCEDÚRA A FUNKCIA (odovzdávka 3)
-- =============================================================================

-- -----------------------------------------------------------------------------
-- ULOŽENÁ PROCEDÚRA: zrušenie letu
-- Účel: Nastaví stav zadaného letu (podľa čísla letu a dátumu odletu)
--       na 'zrušený' a vypíše počet ovplyvnených leteniek. Zabezpečuje
--       konzistentné zrušenie letu jedným volaním bez manuálnych UPDATE.
-- Použitie: CALL zrus_let('FR123', '2026-03-05');
-- -----------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE zrus_let(
    p_cislo_letu    TEXT,
    p_datum_odletu  DATE
)
    LANGUAGE plpgsql AS $$
DECLARE
    v_id_let        INT;
    v_id_stav_zrus  INT;
    v_pocet         INT;
BEGIN
    SELECT id_let
    INTO v_id_let
    FROM let
    WHERE cislo_letu = p_cislo_letu
      AND DATE(cas_odletu AT TIME ZONE 'UTC') = p_datum_odletu;

    IF v_id_let IS NULL THEN
        RAISE EXCEPTION 'Let % dňa % nebol nájdený.', p_cislo_letu, p_datum_odletu;
    END IF;

    SELECT id_stav_letu
    INTO v_id_stav_zrus
    FROM stav_letu
    WHERE stav = 'zrušený';

    IF v_id_stav_zrus IS NULL THEN
        RAISE EXCEPTION 'Stav "zrušený" neexistuje v tabuľke stav_letu.';
    END IF;

    UPDATE let
    SET id_stav_letu = v_id_stav_zrus
    WHERE id_let = v_id_let;

    SELECT COUNT(*) INTO v_pocet
    FROM letenka WHERE id_let = v_id_let;

    RAISE NOTICE 'Let % (id=%) bol zrušený. Ovplyvnených leteniek: %.',
        p_cislo_letu, v_id_let, v_pocet;
END;
$$;

-- -----------------------------------------------------------------------------
-- FUNKCIA: celkové tržby leteckej spoločnosti za zadané obdobie
-- Účel: Vráti sumu cien leteniek pre danú leteckú spoločnosť (IATA kód)
--       v zadanom rozsahu dátumov rezervácie. Použiteľná v reportoch
--       a finančných analýzach výkonnosti leteckých spoločností.
-- Použitie: SELECT trzby_spolocnosti('EK', '2026-01-01', '2026-12-31');
-- -----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION trzby_spolocnosti(
    p_iata_kod  VARCHAR(2),
    p_od        DATE,
    p_do        DATE
)
    RETURNS NUMERIC
    LANGUAGE plpgsql AS $$
DECLARE
    v_trzby NUMERIC;
BEGIN
    SELECT COALESCE(SUM(lt.cena), 0)
    INTO v_trzby
    FROM letenka lt
             INNER JOIN let l               ON lt.id_let        = l.id_let
             INNER JOIN lietadlo lp         ON l.id_lietadlo     = lp.id_lietadlo
             INNER JOIN letecka_spolocnost ls ON lp.id_spolocnost = ls.id_spolocnost
    WHERE ls.iata_kod = p_iata_kod
      AND DATE(lt.datum_rezervacie AT TIME ZONE 'UTC') BETWEEN p_od AND p_do;

    RETURN v_trzby;
END;
$$;


-- =============================================================================
-- UKÁŽKY POUŽITIA (odkomentovať pre testovanie)
-- =============================================================================

-- Pohľady z odovzdávky 2:
-- SELECT * FROM cestujuci_narodeni_80_roky;
-- SELECT * FROM lietadla_vysoka_kapacita;
-- SELECT * FROM lety_s_detailmi;
-- SELECT * FROM letenky_a_batoziny;
-- SELECT * FROM statistiky_letov_podla_spolocnosti;
-- SELECT * FROM financna_analyza_leteniek;

-- Nové pohľady (odovzdávka 3):
-- SELECT * FROM letiská_zapojené_do_letov;
-- SELECT * FROM vip_cestujuci;
-- SELECT * FROM nadpriemerné_lety;

-- Autoinkrementácia – id sa generuje automaticky:
-- INSERT INTO krajina (nazov) VALUES ('Taliansko'); SELECT id_krajina,nazov FROM krajina;
-- DELETE FROM krajina where nazov = 'Taliansko'
-- INSERT INTO cestujuci (meno, priezvisko, cislo_pasu, statna_prislusnost, datum_narodenia)
--     VALUES ('Anna', 'Kováčová', 'SK9999999', 'Slovenská', '1990-05-10');

-- INSTEAD OF INSERT cez pohľad (id sa opäť generuje automaticky):
-- INSERT INTO vip_cestujuci (meno, priezvisko, cislo_pasu, statna_prislusnost, datum_narodenia)
--     VALUES ('Mária', 'Horáková', 'SK1111111', 'Slovenská', '1988-08-15');

-- Procedúra:
-- CALL zrus_let('FR123', '2026-03-05');

-- Funkcia:
-- SELECT trzby_spolocnosti('EK', '2026-01-01', '2026-12-31');
-- SELECT trzby_spolocnosti('LH', '2026-01-01', '2026-12-31');