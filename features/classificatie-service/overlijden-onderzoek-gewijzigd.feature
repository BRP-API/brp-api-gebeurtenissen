# language: nl
Functionaliteit: Gebeurtenis wanneer er een onderzoek naar het overlijden is gewijzigd

  Achtergrond:
    Gegeven de persoon 'Jan'

  Regel: Als een onderzoek naar het overlijden is gewijzigd, heeft de gebeurtenis 'overlijden-onderzoek-gewijzigd' plaatsgevonden

    Abstract Scenario: <omschrijving>
      Gegeven het overlijden van 'Jan' op '12-08-2026' in 'Gemeente Roosendaal' is verwerkt
      En een onderzoek loopt naar '<betwijfeld gegeven oorspronkelijk>' op het overlijden op '12-08-2026' van 'Jan'
      Als het onderzoek naar het overlijden van 'Jan' op '12-08-2026' is gewijzigd naar 'betwijfelde gegevens na wijziging'
      Dan is een 'overlijden-onderzoek-gewijzigd' gebeurtenis gepubliceerd

      Voorbeelden:
        | omschrijving                   | betwijfelde gegevens oorspronkelijk | betwijfelde gegevens na wijziging |
        | Het onderzoek wordt uitgebreid | plaats van overlijden               | de hele categorie overlijden      |
        | Het onderzoek wordt beperkt    | de hele categorie overlijden        | datum van overlijden              |
