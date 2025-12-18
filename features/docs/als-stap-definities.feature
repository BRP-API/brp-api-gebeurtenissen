# language: nl

@mutatie-service
Functionaliteit: als stap definities

  Scenario: Als aangifte van adreswijziging van '[persoon indicatie]' is verwerkt
    Gegeven het adres 'A1'
    * met adresseerbaar object identificatie '0000000000000001'
    En de persoon 'P1'
    * met burgerservicenummer '123456789'
    Als de aangifte van adreswijziging van 'P1' is verwerkt
    * verblijft vanaf '1-9-2025' op het adres 'A1'
    Dan heeft de command de volgende eigenschappen
      | type                      | burgerservicenummer | adresseerbaarObjectIdentificatie | verhuisdatum |
      | AangifteVanAdreswijziging |           123456789 |                 0000000000000001 |   2025-09-01 |

  Regel: de adres regel velden zijn optioneel. Land (code) en verhuisdatum zijn verplicht

    Scenario: Als de aangifte van vertrek van '[persoon indicatie]' is verwerkt
      Gegeven het adres buitenland 'A2'
      * met adres regel 1 'Chemin du Calvaire 19'
      * met adres regel 2 'Lausanne'
      * met adres regel 3 'Vaud'
      * in land 'Zwitserland'
      En de persoon 'P1'
      * met burgerservicenummer '123456789'
      Als de aangifte van vertrek naar het buitenland van 'P1' is verwerkt
      * verblijft vanaf '1-9-2025' op het adres 'A2'
      Dan heeft de command de volgende eigenschappen
        | type               | burgerservicenummer | adres.regel1          | adres.regel2 | adres.regel3 | adres.land | verhuisdatum |
        | AangifteVanVertrek |           123456789 | Chemin du Calvaire 19 | Lausanne     | Vaud         |       5003 |   2025-09-01 |

    Scenario: Als de aangifte van vertrek van '[persoon indicatie]' is verwerkt (naar onbekend land)
      Gegeven het adres buitenland 'A2'
      * in land 'Onbekend'
      En de persoon 'P1'
      * met burgerservicenummer '123456789'
      Als de aangifte van vertrek naar het buitenland van 'P1' is verwerkt
      * verblijft vanaf '1-9-2025' op het adres 'A2'
      Dan heeft de command de volgende eigenschappen
        | type               | burgerservicenummer | adres.land | verhuisdatum |
        | AangifteVanVertrek |           123456789 |       0000 |   2025-09-01 |
