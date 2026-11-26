create table public.abonnees
(
	id           bigserial primary key,
	afnemer_id   varchar(64) not null,
	abonnee_naam varchar(64) not null,
	constraint abonnees_afnemer_id_abonnee_naam_unique unique (afnemer_id, abonnee_naam)
);
alter table public.abonnees
	owner to brp_gebeurtenissen_eigenaar;

create table public.abonnementen
(
	id         uuid        not null primary key,
	groep_naam varchar(64) not null,
	abonnee_id bigint      not null
		constraint fk_abonnementen_abonnee_id__id references public.abonnees on update restrict on delete cascade,
	bsn        varchar(9)  not null,
	sequence   bigint      not null
		constraint abonnementen_sequence_unique unique,
	constraint abonnementen_groep_naam_abonnee_id_bsn_unique unique (groep_naam, abonnee_id, bsn),
	constraint abonnementen_abonnee_id_sequence_unique unique (abonnee_id, sequence)
);
alter table public.abonnementen
	owner to brp_gebeurtenissen_eigenaar;

create table public.tokenentry
(
	processorname varchar(255) not null,
	segment       integer      not null,
	mask          integer      not null,
	token         bytea,
	tokentype     varchar(255),
	timestamp     varchar(255),
	owner         varchar(255),
	primary key (processorname, segment)
);
alter table public.tokenentry
	owner to brp_gebeurtenissen_eigenaar;

create table public.gebeurtenissen
(
	gebeurtenis_id   uuid        not null,
	abonnee_id       bigint      not null
		constraint fk_gebeurtenissen_abonnee_id__id references public.abonnees on update restrict on delete cascade,
	gebeurtenis_type varchar(50) not null,
	data             jsonb       not null,
	sequence         bigint      not null
		constraint gebeurtenissen_sequence_unique unique,
	timestamp        timestamp   not null,
	constraint pk_gebeurtenissen primary key (gebeurtenis_id, abonnee_id),
	constraint gebeurtenissen_abonnee_id_sequence_unique unique (abonnee_id, sequence)
);
alter table public.gebeurtenissen
	owner to brp_gebeurtenissen_eigenaar;
create index gebeurtenissen_abonnee_id_timestamp on public.gebeurtenissen (abonnee_id, timestamp);
