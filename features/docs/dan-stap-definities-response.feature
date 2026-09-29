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

  Scenario: Dan worden de volgende abonnementen geleverd
    Gegeven de persoon 'Jan'
    * met burgerservicenummer '123456789'
    En de persoon 'Piet'
    * met burgerservicenummer '987654321'
    En de response
    """
    {
        "abonnementen": [
        {
          "burgerservicenummer": "123456789",
          "groepnaam": "client"
        },
        {
          "burgerservicenummer": "987654321",
          "groepnaam": "relatie"
        }
      ]
    }
    """
    Dan worden volgende abonnementen geleverd
      | burgerservicenummer | groepnaam |
      | Jan                 | client    |
      | Piet                | relatie   |