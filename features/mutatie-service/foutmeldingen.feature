#language: nl

Functionaliteit: Foutmelding voorbeelden voor request validatie conform BRP API Problem Details specificatie

  Scenario: Een verplicht veld is niet opgegeven
    Gegeven de response is een problemdetails met de melding dat de gemeentecode verplicht is
    Dan is de response in json formaat
    """
    {
      "type": "https://www.rfc-editor.org/rfc/rfc9110.html#name-400-bad-request",
      "title": "Een of meerdere parameters zijn niet correct.",
      "status": 400,
      "detail": "De foutieve parameter(s) zijn: gemeentecode.",
      "code": "paramsValidation",
      "instance": "/api/brp/adressen",
      "invalidParams": [
        {
          "code": "required",
          "name": "gemeentecode",
          "reason": "Parameter is verplicht."
        }
      ]
    }
    """

  Scenario: Een ongeldig waarde is opgegeven voor een veld
    Gegeven de response is een problemdetails met de melding dat de opgegeven gemeentecode ongeldig is
    Dan is de response in json formaat
    """
    {
      "type": "https://www.rfc-editor.org/rfc/rfc9110.html#name-400-bad-request",
      "title": "Een of meerdere parameters zijn niet correct.",
      "status": 400,
      "detail": "De foutieve parameter(s) zijn: gemeentecode.",
      "code": "paramsValidation",
      "instance": "/api/brp/adressen",
      "invalidParams": [
        {
          "code": "pattern",
          "name": "gemeentecode",
          "reason": "Waarde voldoet niet aan patroon ^\\d{4}$."
        }
      ]
    }
    """

  Scenario: Een niet-bestaande identificatie code is opgegeven
    Gegeven de response is een problemdetails met de melding dat een gemeente met de opgegeven gemeentecode niet bestaat
    Dan is de response in json formaat
    """
    {
      "type": "https://www.rfc-editor.org/rfc/rfc9110.html#name-400-bad-request",
      "title": "Een of meerdere parameters zijn niet correct.",
      "status": 400,
      "detail": "De foutieve parameter(s) zijn: gemeentecode.",
      "code": "paramsValidation",
      "instance": "/api/brp/adressen",
      "invalidParams": [
        {
          "code": "notFound",
          "name": "gemeentecode",
          "reason": "Gemeente bestaat niet."
        }
      ]
    }
    """
