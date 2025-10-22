# language: nl
Functionaliteit: als stap definities

  @mutatie-service
  Scenario: Als de opgaven van verhuizing van '[persoon indicatie]' is verwerkt
    Gegeven het adres 'A1'
    * met adresseerbaar object identificatie '0000000000000001'
    En de persoon 'P1'
    * met burgerservicenummer '123456789'
    Als de opgave van verhuizing van 'P1' is verwerkt
    * verblijft vanaf '1-9-2025' op het adres 'A1'
    Dan heeft de command de volgende eigenschappen
      | type                | burgerservicenummer | adresseerbaarObjectIdentificatie | verhuisdatum |
      | OpgaveVanVerhuizing |           123456789 |                 0000000000000001 |   2025-09-01 |
