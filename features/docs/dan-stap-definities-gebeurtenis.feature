#language: nl

Functionaliteit: Gebeurtenis dan stap definities

  Scenario: Dan is een '[gebeurtenis type]' gebeurtenis gepubliceerd met de volgende data
    Gegeven het adres 'A1'
    * met adresseerbaar object identificatie '0518000000000001'
    En de persoon 'P1'
    * met A-nummer '1234567890'
    En de verwerkte aangifte van adreswijziging van 'P1'
    * verblijft vanaf '1-9-2025' op het adres 'A1'
    En de gepubliceerde gebeurtenis
    ```
    {
      "type": "nl.brp.verhuisd.intergemeentelijk",
      "data": {
        "c01": {
          "g01": {
            "e0110": "1234567890"
          }
        },
        "c08": {
          "g10": {
            "e1030": "20250901"
          },
          "g11": {
            "e1180": "0518000000000001"
          }
        }
      }
    }
    ```
    Dan is een 'verhuisd.intergemeentelijk' gebeurtenis gepubliceerd met de volgende data
    * het A-nummer van 'P1'
    * de vanaf datum van de opgave van verhuizing van 'P1'
    * de adresseerbaar object identificatie van het adres 'A1'

  Scenario: Dan wordt een '[gebeurtenis type]' gebeurtenis geleverd met de volgende data
    Gegeven het adres 'A1'
    * met adresseerbaar object identificatie '0518000000000001'
    En de persoon 'P1'
    * met burgerservicenummer '123456789'
    En de verwerkte aangifte van adreswijziging van 'P1'
    * verblijft vanaf '1-12-2025' op het adres 'A1'
    En de geleverde gebeurtenis
    ```
    {
      "type": "nl.brp.verhuisd.intergemeentelijk",
      "data": {
        "burgerservicenummer": "123456789",
        "adresseerbaarObjectIdentificatie": "0518000000000001",
        "datumVan": {
          "type": "Datum",
          "datum": "2025-12-01",
          "langFormaat": "1 december 2025"
        }
      }
    }
    ```
    Dan is een 'verhuisd.intergemeentelijk' gebeurtenis geleverd met de volgende data
    * het burgerservicenummer van 'P1'
    * de vanaf datum van de opgave van verhuizing van 'P1'
    * de adresseerbaar object identificatie van het adres 'A1'
