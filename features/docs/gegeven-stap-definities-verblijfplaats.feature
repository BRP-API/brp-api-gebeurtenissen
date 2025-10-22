# language: nl
Functionaliteit: Verblijfplaats gegeven stap definities

  Scenario: Gegeven verblijft vanaf '[datum]' op het adres '[adres aanduiding]'
    Gegeven het adres 'A1'
    * in gemeente 'Den Haag'
    * met adresseerbaar object identificatie '0518000000000001'
    * heeft id '123'
    En de persoon 'P1'
    * verblijft vanaf '14-4-2020' op het adres 'A1'
    Dan heeft persoon 'P1' een verblijfplaats met de volgende eigenschappen
      | volg_nr | adres_id | inschrijving_gemeente_code | inschrijving_datum | adres_functie | adreshouding_start_datum | aangifte_adreshouding_oms | geldigheid_start_datum |
      |       0 |      123 |                       0518 |           20200414 | W             |                 20200414 | I                         |               20200414 |
