-- Script om een aantal personen toe te voegen
-- Gebruik hiervoor SELECT * FROM insert_personen({{gemeenteCode}}, {{aantal personen}});
-- dit maakt 1 adres aan waar de personen op ingeschreven worden, 
-- dit adres heeft adresseerbaar object identificatie {{gemeenteCode}}010000000001 (bijvoorbeeld 0530010000000001).
-- en dit maakt het opgegeven aantal personen
-- alle aangemaakte personen zijn identiek, met uitzondering van burgerservicenummer en A-nummer
-- de aangemaakte personen hebben een burgerservicenummer met '99' + gemeentecode + teller (bijvoorbeeld 990530001, 990530002, enz.)
-- de aangemaakte personen hebben een A-nummer met '999' + gemeentecode + teller (bijvoorbeeld 9990530001, 9990530002, enz.)
-- optioneel kan je personen in verschillende adressen inschrijven, al dan niet gegroepeerd.
-- bijvoorbeeld voor 4 personen per adres gebruik je SELECT * FROM insert_personen({{gemeenteCode}}, {{aantal personen}}, 4);
-- bijvoorbeeld als je elke persoon op een eigen adres wilt laten wonen gebruik je SELECT * FROM insert_personen({{gemeenteCode}}, {{aantal personen}}, 1);

-- Gebruik SELECT * FROM wis_testpersoon({{gemeenteCode}}, {{vanafDatum}}) om alle de vanafDatum (bijvoorbeeld current_date, of '2026-03-01') voor deze gemeente aangemaakte personen te wissen


--SELECT * FROM wis_testpersonen(518, current_date);
SELECT * FROM wis_testpersonen(530, '2026-03-01');

SELECT * FROM insert_personen(530, 5);
--SELECT * FROM insert_personen(1895, 20, 3);

-- SELECT a_nr, burger_service_nr, verblijf_plaats_ident_code FROM lo3_pl_persoon p
-- 	JOIN lo3_pl_verblijfplaats v
-- 	ON v.pl_id=p.pl_id
-- 	JOIN lo3_adres a
-- 	ON a.adres_id = v.adres_id
-- 	WHERE p.pl_id in (
-- 		SELECT pl_id FROM lo3_pl WHERE creatie_dt > current_date AND pk_gemeente_code = 518
-- 	) AND persoon_type='P';

DROP FUNCTION IF EXISTS vandaag;
CREATE OR REPLACE FUNCTION vandaag()
RETURNS bigint AS $$
BEGIN
    RETURN TO_CHAR(current_date, 'YYYYMMDD');
END;
$$ LANGUAGE plpgsql IMMUTABLE;

DROP FUNCTION IF EXISTS wis_testpersonen;
CREATE OR REPLACE FUNCTION wis_testpersonen(gemeenteCode int, vanafDatum date)
RETURNS text AS $$
BEGIN
	DELETE FROM lo3_pl_nationaliteit WHERE pl_id in (SELECT pl_id FROM lo3_pl WHERE creatie_dt > vanafDatum and pk_gemeente_code = gemeenteCode);
	DELETE FROM lo3_pl_verblijfplaats WHERE pl_id in (SELECT pl_id FROM lo3_pl WHERE creatie_dt > vanafDatum and pk_gemeente_code = gemeenteCode);
	DELETE FROM lo3_pl_persoon WHERE pl_id in (SELECT pl_id FROM lo3_pl WHERE creatie_dt > vanafDatum and pk_gemeente_code = gemeenteCode);
	DELETE FROM lo3_pl WHERE creatie_dt > vanafDatum and pk_gemeente_code = gemeenteCode;
	DELETE FROM lo3_adres WHERE creatie_dt > vanafDatum and gemeente_code = gemeenteCode;
    RETURN 'De personen en het adres zijn gewist.';
END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS maak_testadres;
CREATE OR REPLACE FUNCTION maak_testadres(gemeenteCode int, teller int)
RETURNS bigint AS $$
DECLARE
	adoId text := TRIM(TO_CHAR(gemeenteCode, '0000')) || '010000000' || TRIM(TO_CHAR(teller, '000'));
	numId text := TRIM(TO_CHAR(gemeenteCode, '0000')) || '200000000' || TRIM(TO_CHAR(teller, '000'));
	adresId bigint := (SELECT adres_id FROM lo3_adres WHERE verblijf_plaats_ident_code = adoId LIMIT 1);
	woonplaats text := (SELECT gemeente_naam FROM lo3_gemeente WHERE gemeente_code = gemeenteCode);
BEGIN
	IF woonplaats IS NULL THEN
		woonplaats := 'Testdorp';
	END IF;

	--raise notice 'adoId: %', adoId || length(adoId);
	--raise notice 'numId: % ', numId || length(numId);

	adresId := (SELECT MAX(adres_id) + 1 FROM lo3_adres);
	raise notice 'Maak adres met adresId: %', adresId;
	
	INSERT INTO public.lo3_adres(
		adres_id, 
		gemeente_code, gemeente_deel, 
		straat_naam, diak_straat_naam, huis_nr, huis_letter, huis_nr_toevoeging, huis_nr_aand, postcode, 
		locatie_beschrijving, diak_locatie_beschrijving, 
		creatie_dt, 
		open_ruimte_naam, diak_open_ruimte_naam, woon_plaats_naam, diak_woon_plaats_naam, 
		verblijf_plaats_ident_code, nummer_aand_ident_code)
	VALUES (
		adresId,
		gemeenteCode, NULL, 
		'Gebeurtenissenplein', NULL, teller, NULL, NULL, NULL, '1234AA', 
		NULL, NULL, 
		current_timestamp, 
		'Gebeurtenissenplein', NULL, woonplaats, NULL, 
		adoId, numId
	);

    RETURN adresId;
END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS maak_testpersoon;
CREATE OR REPLACE FUNCTION maak_testpersoon(bsn bigint, gemeenteCode int, teller int, adresId bigint)
RETURNS bigint AS $$
DECLARE
	plId bigint := (SELECT MAX(pl_id) + 1 FROM lo3_pl);
BEGIN
	INSERT INTO public.lo3_pl(
		pl_id, 
		pl_blokkering_start_datum, bijhouding_opschort_datum, bijhouding_opschort_reden, 
		gba_eerste_inschrijving_datum, pk_gemeente_code, geheim_ind, volledig_geconverteerd_pk, 
		europees_kiesrecht_aand, europees_kiesrecht_datum, europees_uitsluit_eind_datum, 
		kiesrecht_uitgesl_aand, kiesrecht_uitgesl_eind_datum, kiesrecht_doc_gemeente_code, kiesrecht_doc_datum, kiesrecht_doc_beschrijving, 
		mutatie_activiteit_id, creatie_dt, mutatie_dt, versie_nr, stempel_dt, 
		verificatie_datum, verificatie_oms, rni_deelnemer, verdrag_oms, adres_eu_lidstaat_van_herkomst, plaats_eu_lidstaat_van_herkomst, land_eu_lidstaat_van_herkomst)
	VALUES (
		plId, 
		NULL, NULL, NULL, 
		vandaag(), gemeenteCode, 0, 'P', 
		NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL, 
		9000000 + teller, current_timestamp, current_date, 0, vandaag() * 1000000000, 
		NULL, NULL, NULL, NULL, NULL, NULL, NULL
	);

	INSERT INTO public.lo3_pl_persoon(
		pl_id, persoon_type, stapel_nr, volg_nr, 
		a_nr, burger_service_nr, 
		voor_naam, diak_voor_naam, titel_predicaat, geslachts_naam_voorvoegsel, geslachts_naam, diak_geslachts_naam, 
		geboorte_datum, geboorte_plaats, geboorte_land_code, 
		geslachts_aand, naam_gebruik_aand, 
		akte_register_gemeente_code, akte_nr, doc_gemeente_code, doc_datum, doc_beschrijving, 
		onderzoek_gegevens_aand, onderzoek_start_datum, onderzoek_eind_datum, onjuist_ind, 
		geldigheid_start_datum, opneming_datum, 
		relatie_start_datum, relatie_start_plaats, relatie_start_land_code, relatie_eind_datum, relatie_eind_plaats, relatie_eind_land_code, relatie_eind_reden, verbintenis_soort, 
		familie_betrek_start_datum, 
		vorig_a_nr, volgend_a_nr, 
		rni_deelnemer, verdrag_oms, registratie_betrekking)
	VALUES (
		plId, 'P', 0, 0, 
		bsn + 9000000000, bsn, 
		'Test', NULL, NULL, NULL, 'Gebeurtenissen Persoon', NULL, 
		20060301, TRIM(TO_CHAR(gemeenteCode, '0000')), 6030, 
		'M', 'E', 
		gemeenteCode, '1AA2001', NULL, NULL, NULL,
		NULL, NULL, NULL, NULL, 
		20060301, 20060301, 
		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
		NULL, 
		NULL, NULL, 
		NULL, NULL, NULL
	), (
		plId, '1', 0, 0, 
		NULL, NULL, 
		'Moeder', NULL, NULL, NULL, 'Gebeurtenissen Persoon', NULL, 
		19750102, TRIM(TO_CHAR(gemeenteCode, '0000')), 6030, 
		'V', NULL, 
		NULL, '1AA2001', NULL, NULL, NULL,
		NULL, NULL, NULL, NULL, 
		19750102, 19750102, 
		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
		20060301, 
		NULL, NULL, 
		NULL, NULL, NULL
	), (
		plId, '2', 0, 0, 
		NULL, NULL, 
		'Vader', NULL, NULL, NULL, 'Gebeurtenissen Persoon', NULL, 
		19700103, TRIM(TO_CHAR(gemeenteCode, '0000')), 6030, 
		'M', NULL, 
		NULL, '1AA2001', NULL, NULL, NULL,
		NULL, NULL, NULL, NULL, 
		19700103, 19700103, 
		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
		20060301, 
		NULL, NULL, 
		NULL, NULL, NULL
	);

	INSERT INTO public.lo3_pl_nationaliteit(
		pl_id, stapel_nr, volg_nr, 
		nationaliteit_code, nl_nat_verkrijg_reden, nl_nat_verlies_reden, bijzonder_nl_aand, 
		doc_gemeente_code, doc_datum, doc_beschrijving, 
		onderzoek_gegevens_aand, onderzoek_start_datum, onderzoek_eind_datum, onjuist_ind, 
		geldigheid_start_datum, opneming_datum, 
		rni_deelnemer, verdrag_oms, eu_persoon_nr)
	VALUES (
		plId, 0, 0, 
		1, 17, NULL, NULL, 
		gemeenteCode, 20060301, NULL, 
		NULL, NULL, NULL, NULL, 
		20060301, vandaag(), 
		NULL, NULL, NULL
	);
	
	INSERT INTO public.lo3_pl_verblijfplaats(
		pl_id, volg_nr, inschrijving_gemeente_code, adres_id, 
		inschrijving_datum, adres_functie, gemeente_deel, adreshouding_start_datum, 
		vertrek_land_code, vertrek_datum, vertrek_land_adres_1, vertrek_land_adres_2, vertrek_land_adres_3, 
		vestiging_land_code, vestiging_datum, 
		aangifte_adreshouding_oms, doc_ind, 
		onderzoek_gegevens_aand, onderzoek_start_datum, onderzoek_eind_datum, onjuist_ind, 
		geldigheid_start_datum, opneming_datum, 
		rni_deelnemer, verdrag_oms
	) VALUES (
		plId, 0, gemeenteCode, adresId, 
		20060301, 'W', '', '20060301', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, 
		'A', NULL, 
		NULL, NULL, NULL, NULL, 
		20060301, vandaag(), 
		NULL, NULL
	);
	
    RETURN plId;
END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS check_11_proef;
CREATE OR REPLACE FUNCTION check_11_proef(bsn bigint)
RETURNS BOOLEAN AS $$
DECLARE
    som INTEGER := 0;
    lengte INTEGER;
    cijfer INTEGER;
	nummer TEXT;
BEGIN
    -- Verwijder niet-numerieke tekens (indien nodig)
	nummer := CAST (bsn AS text);
    nummer := regexp_replace(nummer, '\D', '', 'g');
    lengte := length(nummer);

    IF lengte < 2 THEN
        RETURN FALSE;
    END IF;

	-- begin met laatste cijfer die wordt afgetrokken in plaats van opgeteld
	cijfer := substring(nummer FROM lengte FOR 1)::INTEGER;
	som := - (cijfer * 1);
	
    -- Berekening: van rechts naar links, vermenigvuldig met 2, 3...
	
    FOR i IN 2..lengte LOOP
        cijfer := substring(nummer FROM lengte - i + 1 FOR 1)::INTEGER;
        som := som + (cijfer * i);
		--raise notice 'som: %', som;
    END LOOP;

    -- Controleer of de som deelbaar is door 11
    RETURN (som % 11 = 0);
END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS insert_personen;
CREATE OR REPLACE FUNCTION insert_personen(gemeenteCode int, aantal int, aantalAdresBewoners int default 1000) 
RETURNS int AS
$BODY$
DECLARE
    bs_num bigint := 990000000 + gemeenteCode * 1000 + 1;
	bsn_max bigint := bs_num + 999;
	teller int := 0;
	plId bigint;
	adresId bigint;
BEGIN
	PERFORM wis_testpersonen(gemeenteCode, current_date);
	
    WHILE bs_num <= bsn_max AND teller < aantal
    LOOP
		-- alleen burgerservicenummers die aan 11-proef voldoen gebruiken
        IF check_11_proef(bs_num) AND teller < aantal THEN
			IF teller % aantalAdresBewoners = 0 THEN
				adresId := (SELECT * FROM maak_testadres(gemeenteCode, teller % aantalAdresBewoners + 1));
			END IF;
			
			teller := teller +1;
			plId := (SELECT * FROM maak_testpersoon(bs_num, gemeenteCode, teller, adresId));
			raise notice 'toegevoegde PL: %', plId;
		END IF;
		bs_num := bs_num + 1;
    END LOOP;
	raise notice 'aantal toegevoegde personen: %', teller;
	RETURN teller;
END;
$BODY$
LANGUAGE plpgsql;


