#language: nl

Functionaliteit: Gebeurtenis dan stap definities

  Scenario: Dan heeft persoon '[persoon aanduiding]' een verblijfplaats met de volgende eigenschappen
    Gegeven het adres 'A1'
    * met adresseerbaar object identificatie '0518000000000001'
    En de persoon 'P1'
    * met A-nummer '1234567890'
    En de verwerkte opgave van verhuizing van 'P1'
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
