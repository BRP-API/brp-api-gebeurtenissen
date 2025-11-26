# language: nl
Functionaliteit: als stap definities

  @mutatie-service
  Scenario: Als de opgaven van verhuizing van '[persoon indicatie]' is verwerkt
    Gegeven het adres 'A1'
    * met adresseerbaar object identificatie '0000000000000001'
    En de persoon 'P1'
    * met burgerservicenummer '123456789'
    Als de aangifte van adreswijziging van 'P1' is verwerkt
    * verblijft vanaf '1-9-2025' op het adres 'A1'
    Dan heeft de command de volgende eigenschappen
      | type                      | burgerservicenummer | adresseerbaarObjectIdentificatie | verhuisdatum |
      | AangifteVanAdreswijziging |           123456789 |                 0000000000000001 |   2025-09-01 |


  Scenario: Als de aangifte van vertrek van '[persoon indicatie]' is verwerkt
    Gegeven het adres 'A1'
    * met adresseerbaar object identificatie '0000000000000001'
    En de persoon 'P1'
    * met burgerservicenummer '123456789'
    Als de aangifte van vertrek van 'P1' is verwerkt
    * verblijft vanaf '1-9-2025' op het adres buitenland 'A2'
    * met land 'Zwitserland'
    Dan heeft de command de volgende eigenschappen
      | type                      | burgerservicenummer | landAdresBuitenland | verhuisdatum |
      | AangifteVanVertrek |           123456789 |                 5003 |   2025-09-01 |
