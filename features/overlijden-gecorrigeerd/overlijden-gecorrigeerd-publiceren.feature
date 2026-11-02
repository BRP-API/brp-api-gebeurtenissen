# language: nl
Functionaliteit: Publiceren van overlijden gecorrigeerd gebeurtenis

  Regel: Een correctie op het overlijden van een persoon wordt als overlijden gecorrigeerd gebeurtenis gepubliceerd ongeacht of er al een overleden gebeurtenis is gepubliceerd voor deze persoon

    Scenario: Er wordt melding gedaan dat het overlijden van een persoon is gecorrigeerd
      Gegeven de persoon 'Jan' is geregistreerd in de BRP
      Als het overlijden van 'Jan' wordt gecorrigeerd
      Dan is een overlijden gecorrigeerd gebeurtenis voor 'Jan' gepubliceerd

  Regel: Een correctie op het overlijden van een persoon wordt afgewezen als er meerdere personen hetzelfde burgerservicenummer hebben als de betreffende persoon

    Scenario: Er wordt melding gedaan dat het overlijden van een persoon is gecorrigeerd, maar er zijn meerdere personen met hetzelfde burgerservicenummer
      Gegeven de persoon 'Jan' is geregistreerd in de BRP
      En de persoon 'Jan' heeft hetzelfde burgerservicenummer als de persoon 'Piet'
      Als het overlijden van 'Jan' wordt gecorrigeerd
      Dan wordt de correctie op het overlijden van 'Jan' afgewezen 
