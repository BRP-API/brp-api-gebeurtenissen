DROP DATABASE IF EXISTS rvig_brpapi_projecties;

CREATE DATABASE rvig_brpapi_projecties WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';

ALTER DATABASE rvig_brpapi_projecties OWNER TO root;

\connect rvig_brpapi_projecties

CREATE TABLE IF NOT EXISTS abonnees (
    id BIGSERIAL PRIMARY KEY,
    afnemer_id VARCHAR(255) NOT NULL,
    abonnee_naam VARCHAR(255) NOT NULL
);

CREATE UNIQUE INDEX IF NOT EXISTS ux_abonnees_afnemer_abonnee ON abonnees(afnemer_id, abonnee_naam);

CREATE TABLE IF NOT EXISTS abonnee_gebeurtenissen (
    id BIGSERIAL,
    abonnee_id BIGINT NOT NULL REFERENCES abonnees(id) ON DELETE CASCADE,
    gebeurtenis_id VARCHAR(255) NOT NULL,
    PRIMARY KEY (abonnee_id, gebeurtenis_id)
);

CREATE TABLE IF NOT EXISTS abonnementen (
    id BIGSERIAL,
    abonnee_id BIGINT NOT NULL REFERENCES abonnees(id) ON DELETE CASCADE,
    gebeurtenis_criteria VARCHAR(255) NOT NULL,
    PRIMARY KEY (abonnee_id, gebeurtenis_criteria)
);
