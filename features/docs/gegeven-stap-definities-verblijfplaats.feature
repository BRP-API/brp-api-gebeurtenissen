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

  Scenario: Gegeven verblijft vanaf '[datum]' op het adres '[adres aanduiding]' (buitenland)
    Gegeven het adres buitenland 'A2'
    * met adres regel 1 'Chemin du Calvaire 19'
    * met adres regel 2 'Lausanne'
    * met adres regel 3 'Vaud'
    * in land 'Zwitserland'
    En de persoon 'P1'
    * verblijft vanaf '1-9-2025' op het adres 'A2'
    Dan heeft persoon 'P1' een verblijfplaats met de volgende eigenschappen
      | volg_nr | vertrek_datum | vertrek_land_adres_1  | vertrek_land_adres_2 | vertrek_land_adres_3 | vertrek_land_code | geldigheid_start_datum |
      |       0 |      20250901 | Chemin du Calvaire 19 | Lausanne             | Vaud                 |              5003 |               20250901 |
