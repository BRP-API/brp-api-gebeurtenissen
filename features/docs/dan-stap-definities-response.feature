#language: nl

@stap-documentatie
Functionaliteit: Response dan stap definities

  Scenario: Dan is de response '409 Conflict'
    Gegeven de response met '409 Conflict'
    """
    {
      "type": "https://www.rfc-editor.org/rfc/rfc9110.html#name-409-conflict",
      "title": "Conflict",
      "status": 409,
      "detail": "Uw verzoek kan niet worden uitgevoerd omdat u al als abonnee geregistreerd bent.",
      "instance": "/abonnees"
    }
    """
    Dan is de response '409 Conflict' met de volgende velden
    * 'detail' met tekst 'Uw verzoek kan niet worden uitgevoerd omdat u al als abonnee geregistreerd bent.'
    * 'instance' met tekst '/abonnees'
