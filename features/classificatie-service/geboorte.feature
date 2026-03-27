# language: nl
@to-do @skip-verify
Functionaliteit: gepubliceerde gebeurtenis bij een geboorteaangifte

  Scenario: geboorteaangifte van een kind geboren in Nederland
    Als de aangifte van geboorte van 'Jan' is verwerkt
    Dan is een 'ingeschreven.geboorte' gebeurtenis gepubliceerd
    * bevat de 'data' de pl_id van 'Jan'