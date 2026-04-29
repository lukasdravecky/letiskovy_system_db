DROP TABLE IF EXISTS batozina CASCADE;
DROP TABLE IF EXISTS letenka CASCADE;
DROP TABLE IF EXISTS priradenie_brany CASCADE;
DROP TABLE IF EXISTS let CASCADE;
DROP TABLE IF EXISTS lietadlo CASCADE;
DROP TABLE IF EXISTS letecka_spolocnost CASCADE;
DROP TABLE IF EXISTS brana CASCADE;
DROP TABLE IF EXISTS stav_brany CASCADE;
DROP TABLE IF EXISTS terminal CASCADE;
DROP TABLE IF EXISTS letisko CASCADE;
DROP TABLE IF EXISTS stav_letu CASCADE;
DROP TABLE IF EXISTS stav_batoziny CASCADE;
DROP TABLE IF EXISTS cestujuci CASCADE;
DROP TABLE IF EXISTS mesto CASCADE;
DROP TABLE IF EXISTS krajina CASCADE;

CREATE TABLE krajina (
                         id_krajina  INT         PRIMARY KEY,
                         nazov       TEXT        NOT NULL CHECK (TRIM(nazov) <> ''),
                         UNIQUE (nazov)
);

CREATE TABLE mesto (
                       id_mesto    INT         PRIMARY KEY,
                       nazov       TEXT        NOT NULL CHECK (TRIM(nazov) <> ''),
                       id_krajina  INT         NOT NULL,
                       UNIQUE (nazov, id_krajina),
                       FOREIGN KEY (id_krajina) REFERENCES krajina (id_krajina)
);

CREATE TABLE letisko (
                         id_letisko  INT         PRIMARY KEY,
                         nazov       TEXT        NOT NULL CHECK (TRIM(nazov) <> ''),
                         id_mesto    INT         NOT NULL,
                         iata_kod    VARCHAR(3)  NOT NULL CHECK (iata_kod ~ '^[A-Z]{3}$'),
                         icao_kod    VARCHAR(4)  NOT NULL CHECK (icao_kod ~ '^[A-Z]{4}$'),
                         UNIQUE (iata_kod),
                         UNIQUE (icao_kod),
                         FOREIGN KEY (id_mesto) REFERENCES mesto (id_mesto)
);

CREATE TABLE terminal (
                          id_terminal INT         PRIMARY KEY,
                          nazov       TEXT        NOT NULL CHECK (TRIM(nazov) <> ''),
                          id_letisko  INT         NOT NULL,
                          UNIQUE (nazov, id_letisko),
                          FOREIGN KEY (id_letisko) REFERENCES letisko (id_letisko)
);

CREATE TABLE stav_brany (
                            id_stav_brany   INT     PRIMARY KEY,
                            stav            TEXT    NOT NULL CHECK (TRIM(stav) <> ''),
                            popis           TEXT
);

CREATE TABLE brana (
                       id_brana        INT     PRIMARY KEY,
                       cislo_brany     TEXT    NOT NULL CHECK (TRIM(cislo_brany) <> ''),
                       id_stav_brany   INT     NOT NULL,
                       id_terminal     INT     NOT NULL,
                       UNIQUE (cislo_brany, id_terminal),
                       FOREIGN KEY (id_stav_brany) REFERENCES stav_brany (id_stav_brany),
                       FOREIGN KEY (id_terminal)   REFERENCES terminal (id_terminal)
);

CREATE TABLE letecka_spolocnost (
                                    id_spolocnost   INT         PRIMARY KEY,
                                    nazov           TEXT        NOT NULL CHECK (TRIM(nazov) <> ''),
                                    iata_kod        VARCHAR(2)  NOT NULL CHECK (iata_kod ~ '^[A-Z]{2}$'),
                                    id_krajina      INT         NOT NULL,
                                    UNIQUE (iata_kod),
                                    UNIQUE (nazov),
                                    FOREIGN KEY (id_krajina) REFERENCES krajina (id_krajina)
);

CREATE TABLE lietadlo (
                          id_lietadlo     INT     PRIMARY KEY,
                          model           TEXT    NOT NULL CHECK (TRIM(model) <> ''),
                          kapacita        INT     NOT NULL CHECK (kapacita > 0),
                          rok_vyroby      INT     CHECK (rok_vyroby >= 1900 AND rok_vyroby <= EXTRACT(YEAR FROM CURRENT_TIMESTAMP)),
                          id_spolocnost   INT     NOT NULL,
                          UNIQUE (model, rok_vyroby, id_spolocnost),
                          FOREIGN KEY (id_spolocnost) REFERENCES letecka_spolocnost (id_spolocnost)
);

CREATE TABLE stav_letu (
                           id_stav_letu    INT     PRIMARY KEY,
                           stav            TEXT    NOT NULL CHECK (TRIM(stav) <> ''),
                           popis           TEXT
);

CREATE TABLE let (
                     id_let                  INT         PRIMARY KEY,
                     cislo_letu              TEXT        NOT NULL CHECK (TRIM(cislo_letu) <> ''),
                     cas_odletu              TIMESTAMP WITH TIME ZONE NOT NULL,
                     cas_priletu             TIMESTAMP WITH TIME ZONE NOT NULL CHECK (cas_priletu > cas_odletu),
                     id_lietadlo             INT         NOT NULL,
                     id_stav_letu            INT         NOT NULL,
                     id_odletove_letisko     INT         NOT NULL,
                     id_priletove_letisko    INT         NOT NULL,
                     UNIQUE (cislo_letu, cas_odletu),
                     FOREIGN KEY (id_lietadlo)          REFERENCES lietadlo (id_lietadlo),
                     FOREIGN KEY (id_stav_letu)         REFERENCES stav_letu (id_stav_letu),
                     FOREIGN KEY (id_odletove_letisko)  REFERENCES letisko (id_letisko),
                     FOREIGN KEY (id_priletove_letisko) REFERENCES letisko (id_letisko)
);

CREATE TABLE priradenie_brany (
                                  id_priradenie   INT         PRIMARY KEY,
                                  id_let          INT         NOT NULL,
                                  id_brana        INT         NOT NULL,
                                  cas_od          TIMESTAMP WITH TIME ZONE NOT NULL,
                                  cas_do          TIMESTAMP WITH TIME ZONE CHECK (cas_do IS NULL OR cas_do > cas_od),
                                  UNIQUE (id_let, id_brana, cas_od),
                                  FOREIGN KEY (id_let)   REFERENCES let (id_let),
                                  FOREIGN KEY (id_brana) REFERENCES brana (id_brana)
);

CREATE TABLE cestujuci (
                           id_cestujuci        INT     PRIMARY KEY,
                           meno                TEXT    NOT NULL CHECK (TRIM(meno) <> ''),
                           priezvisko          TEXT    NOT NULL CHECK (TRIM(priezvisko) <> ''),
                           cislo_pasu          TEXT    NOT NULL CHECK (TRIM(cislo_pasu) <> ''),
                           statna_prislusnost  TEXT    NOT NULL CHECK (TRIM(statna_prislusnost) <> ''),
                           datum_narodenia     DATE    NOT NULL CHECK (datum_narodenia <= CURRENT_DATE),
                           UNIQUE (cislo_pasu)
);

CREATE TABLE letenka (
                         id_letenka          INT         PRIMARY KEY,
                         cislo_sedadla       TEXT        NOT NULL CHECK (TRIM(cislo_sedadla) <> ''),
                         je_business         BOOLEAN     NOT NULL,
                         cena                NUMERIC     NOT NULL CHECK (cena > 0),
                         datum_rezervacie    TIMESTAMP WITH TIME ZONE NOT NULL,
                         id_cestujuci        INT         NOT NULL,
                         id_let              INT         NOT NULL,
                         UNIQUE (cislo_sedadla, id_let),
                         UNIQUE (id_cestujuci, id_let),
                         FOREIGN KEY (id_cestujuci) REFERENCES cestujuci (id_cestujuci),
                         FOREIGN KEY (id_let)       REFERENCES let (id_let)
);

CREATE TABLE stav_batoziny (
                               id_stav_batoziny    INT     PRIMARY KEY,
                               stav                TEXT    NOT NULL CHECK (TRIM(stav) <> ''),
                               popis               TEXT
);

CREATE TABLE batozina (
                          id_batozina         INT         PRIMARY KEY,
                          hmotnost            NUMERIC     NOT NULL CHECK (hmotnost > 0),
                          typ                 TEXT        NOT NULL CHECK (TRIM(typ) <> ''),
                          id_stav_batoziny    INT         NOT NULL,
                          id_letenka          INT         NOT NULL,
                          UNIQUE (id_letenka),
                          FOREIGN KEY (id_stav_batoziny) REFERENCES stav_batoziny (id_stav_batoziny),
                          FOREIGN KEY (id_letenka)       REFERENCES letenka (id_letenka)
);