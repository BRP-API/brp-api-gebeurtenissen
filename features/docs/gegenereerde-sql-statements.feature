# language: nl
Functionaliteit: gegenereerde sql statements

  Regel: Voor een standaard adres is gemeente_code gelijk aan MAX(gemeente_code)+1 en is verblijf_plaats_ident_code gelijk aan MAX(verblijf_plaats_ident_code)+1

    Scenario: Gegeven het adres '[adres aanduiding]'
      Gegeven het adres 'A1'
      Dan zijn de gegenereerde sql statements voor adres 'A1'
        | statementText                                                                                                                                                                                                                                                                                                                               | values |
        | INSERT INTO public.lo3_adres(adres_id,gemeente_code,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),(SELECT COALESCE(MAX(gemeente_code), 0)+1 FROM public.lo3_adres),(SELECT LPAD((COALESCE(MAX(gemeente_code), 0)+1)::text, 4, '0') \|\| '000000000001' FROM public.lo3_adres)) RETURNING * |        |

  Regel: Voor een standaard persoon is a_nr gelijk aan MAX(a_nr)+1 en is burger_service_nr gelijk aan MAX(burger_service_nr)+1

    Scenario: Gegeven de persoon 'P1'
      Gegeven de persoon 'P1'
      * heeft id '12345'
      Dan zijn de gegenereerde sql statements voor persoon 'P1'
        | statementText                                                                                                                                                                                                                                                         | values      |
        | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *                                                                                                                 |           0 |
        | INSERT INTO public.lo3_pl_persoon(pl_id,persoon_type,stapel_nr,volg_nr,a_nr,burger_service_nr) VALUES($1,$2,$3,$4,(SELECT COALESCE(MAX(a_nr), 0)+1 FROM public.lo3_pl_persoon),(SELECT COALESCE(MAX(burger_service_nr), 0)+1 FROM public.lo3_pl_persoon)) RETURNING * | 12345,P,0,0 |

    Scenario: Gegeven verblijft vanaf '[verhuis datum]' op het adres 'A1'
      Gegeven het adres 'A1'
      * in gemeente 'Rotterdam'
      * heeft id '67890'
      En de persoon 'P1'
      * verblijft vanaf '14-04-2020' op het adres 'A1'
      * heeft id '12345'
      Dan zijn de gegenereerde sql statements voor persoon 'P1'
        | statementText                                                                                                                                                                                                                                                         | values                                            |
        | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *                                                                                                                 |                                                 0 |
        | INSERT INTO public.lo3_pl_persoon(pl_id,persoon_type,stapel_nr,volg_nr,a_nr,burger_service_nr) VALUES($1,$2,$3,$4,(SELECT COALESCE(MAX(a_nr), 0)+1 FROM public.lo3_pl_persoon),(SELECT COALESCE(MAX(burger_service_nr), 0)+1 FROM public.lo3_pl_persoon)) RETURNING * |                                       12345,P,0,0 |
        | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,volg_nr,inschrijving_gemeente_code,inschrijving_datum,adres_id,adres_functie,adreshouding_start_datum,aangifte_adreshouding_oms,geldigheid_start_datum) VALUES($1,$2,$3,$4,$5,$6,$7,$8,$9)                             | 12345,0,0599,20200414,67890,W,20200414,I,20200414 |
