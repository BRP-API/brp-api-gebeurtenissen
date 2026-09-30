# language: nl
Functionaliteit: Gebeurtenis wanneer er een onderzoek gestart is naar het overlijden

  Achtergrond:
    Gegeven de persoon 'Jan'

  Regel: Als een onderzoek gestart is naar het overlijden, heeft de gebeurtenis 'overlijden-onderzoek-gestart' plaatsgevonden

    Scenario: Er start een onderzoek of de persoon nog in leven is
      Gegeven het overlijden van 'Jan' op '12-08-2026' in 'Gemeente Roosendaal' is verwerkt
      Als een onderzoek is gestart naar 'de hele categorie overlijden' van 'Jan'
      Dan is een 'overlijden-onderzoek-gestart' gebeurtenis gepubliceerd

    Abstract Scenario: Er start een onderzoek of <betwijfelde gegeven> van overlijden juist is
      Gegeven het overlijden van 'Jan' op '12-08-2026' in 'Gemeente Roosendaal' is verwerkt
      Als een onderzoek is gestart naar '<betwijfelde gegeven>' van 'Jan'
      Dan is een 'overlijden-onderzoek-gestart' gebeurtenis gepubliceerd

      Voorbeelden:
        | betwijfelde gegeven  |
        | datum van overlijden |
        | plaats van overijden |
        | land van overlijden  |
