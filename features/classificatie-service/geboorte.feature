# language: nl
Functionaliteit: gepubliceerde gebeurtenis bij een geboorteaangifte

  Scenario: geboorteaangifte van een kind geboren in Nederland
    Als de aangifte van geboorte van 'Jan' is verwerkt
    Dan is een 'ingeschreven' gebeurtenis met subject 'geboorte' gepubliceerd
    * heeft de volgende gegevens
      | specversion | type                | subject  | id   | time          |
      |         1.0 | nl.brp.ingeschreven | geboorte | guid | timestamp-utc |
    * heeft de volgende 'data' gegevens
      | pl_id |
      |  Jan  |
