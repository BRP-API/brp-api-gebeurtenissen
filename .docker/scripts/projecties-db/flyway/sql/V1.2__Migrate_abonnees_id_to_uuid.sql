DROP TABLE public.gebeurtenissen;
DROP TABLE public.abonnementen;
DROP TABLE public.abonnees;

CREATE TABLE public.abonnees
(
	id           uuid        NOT NULL PRIMARY KEY,
	afnemer_id   varchar(64) NOT NULL,
	abonnee_naam varchar(64) NOT NULL,
	CONSTRAINT abonnees_afnemer_id_abonnee_naam_unique UNIQUE (afnemer_id, abonnee_naam)
);
ALTER TABLE public.abonnees
	OWNER TO brp_gebeurtenissen_eigenaar;

CREATE TABLE public.groepen
(
	id         uuid        NOT NULL PRIMARY KEY,
	abonnee_id uuid        NOT NULL
		CONSTRAINT fk_groepen_abonnee_id__id
			REFERENCES public.abonnees ON UPDATE RESTRICT ON DELETE CASCADE,
	groep_naam varchar(64) NOT NULL,
	CONSTRAINT abonnee_id_groep_naam_unique UNIQUE (abonnee_id, groep_naam)
);

CREATE TABLE public.abonnementen
(
	id       uuid       NOT NULL PRIMARY KEY,
	groep_id uuid       NOT NULL
		CONSTRAINT fk_abonnementen_groep_id__id
			REFERENCES public.groepen ON UPDATE RESTRICT ON DELETE CASCADE,
	bsn      varchar(9) NOT NULL,
	sequence bigint     NOT NULL
		CONSTRAINT abonnementen_sequence_unique UNIQUE,
	CONSTRAINT abonnementen_groep_id_bsn_unique UNIQUE (groep_id, bsn)
);
ALTER TABLE public.abonnementen
	OWNER TO brp_gebeurtenissen_eigenaar;

CREATE TABLE public.gebeurtenissen
(
	gebeurtenis_id   uuid        NOT NULL,
	abonnee_id       uuid        NOT NULL
		CONSTRAINT fk_gebeurtenissen_abonnee_id__id
			REFERENCES public.abonnees ON UPDATE RESTRICT ON DELETE CASCADE,
	gebeurtenis_type varchar(50) NOT NULL,
	data             jsonb       NOT NULL,
	sequence         bigint      NOT NULL
		CONSTRAINT gebeurtenissen_sequence_unique UNIQUE,
	timestamp        timestamp   NOT NULL,
	CONSTRAINT pk_gebeurtenissen PRIMARY KEY (gebeurtenis_id, abonnee_id),
	CONSTRAINT gebeurtenissen_abonnee_id_sequence_unique UNIQUE (abonnee_id, sequence)
);
ALTER TABLE public.gebeurtenissen
	OWNER TO brp_gebeurtenissen_eigenaar;

CREATE INDEX gebeurtenissen_abonnee_id_timestamp
	ON public.gebeurtenissen (abonnee_id, timestamp);
