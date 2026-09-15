#language: nl
@stap-documentatie
Functionaliteit: Gebeurtenis dan stap definities

  Scenario: Dan wordt een '[gebeurtenis type]' gebeurtenis geleverd met de volgende data
    Gegeven het adres 'A1'
    En de persoon 'P1'
    * met burgerservicenummer '123456789'
    En de verwerkte aangifte van adreswijziging van 'P1'
    * verblijft vanaf '1-12-2025' op het adres 'A1'
    En de geleverde gebeurtenis
    ```
    {
      "id": "een unieke gebeurtenis id",
      "source": "brp",
      "specversion": "1.0.2",
      "type": "nl.brp.verhuisd.intergemeentelijk",
      "data": {
        "burgerservicenummer": "123456789",
        "verblijfplaats": {
          "datumVan": {
            "type": "Datum",
            "datum": "2025-12-01",
            "langFormaat": "1 december 2025"
          }
        }
      }
    }
    ```
    Dan is een 'verhuisd.intergemeentelijk' gebeurtenis geleverd met de volgende data
    * het burgerservicenummer van 'P1'
    * de vanaf datum van de opgave van verhuizing van 'P1'
