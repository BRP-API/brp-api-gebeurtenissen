#language: nl

Functionaliteit: Response dan stap definities

  Scenario: Dan is de response '409 Conflict'
    Gegeven de response
    """
    {
      "type": "https://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10.4.10",
      "title": "Conflict",
      "status": 409,
      "detail": "Uw verzoek kan niet worden uitgevoerd omdat u al als abonnee geregistreerd bent.",
      "instance": "/abonnees"
    }
    """
    Dan is de response '409 Conflict' met de volgende velden
    * 'detail' met tekst 'Uw verzoek kan niet worden uitgevoerd omdat u al als abonnee geregistreerd bent.'
    * 'instance' met tekst '/abonnees'
