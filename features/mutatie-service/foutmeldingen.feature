#language: nl

Functionaliteit: Foutmelding voorbeelden voor request validatie conform BRP API Problem Details specificatie

  Abstract Scenario: Een verplicht veld is niet opgegeven
    Gegeven de response is een problemdetails met de melding dat de <parameterNaam> verplicht is
    Dan is de response in json formaat
    """
    {
      "type": "https://www.rfc-editor.org/rfc/rfc9110.html#name-400-bad-request",
      "title": "Een of meerdere parameters zijn niet correct.",
      "status": 400,
      "detail": "De foutieve parameter(s) zijn: <parameterNaam>.",
      "code": "paramsValidation",
      "instance": "/api/brp/adressen",
      "invalidParams": [
        {
          "code": "required",
          "name": "<parameterNaam>",
          "reason": "Parameter is verplicht."
        }
      ]
    }
    """

    Voorbeelden:
    | parameterNaam                      |
    | gemeentecode                       |
    | adresseerbaar object identificatie |
    | verblijfdatum                      |

  Abstract Scenario: Een ongeldig waarde is opgegeven voor een veld
    Gegeven de response is een problemdetails met de melding dat de opgegeven <parameterNaam> ongeldig is
    Dan is de response in json formaat
    """
    {
      "type": "https://www.rfc-editor.org/rfc/rfc9110.html#name-400-bad-request",
      "title": "Een of meerdere parameters zijn niet correct.",
      "status": 400,
      "detail": "De foutieve parameter(s) zijn: <parameterNaam>.",
      "code": "paramsValidation",
      "instance": "/api/brp/adressen",
      "invalidParams": [
        {
          "code": "pattern",
          "name": "<parameterNaam>",
          "reason": "Waarde voldoet niet aan patroon <patroon>."
        }
      ]
    }
    """

    Voorbeelden:
    | parameterNaam                      | patroon     |
    | gemeentecode                       | ^[0-9]{4}$  |
    | adresseerbaar object identificatie | ^[0-9]{16}$ |

  Scenario: Een ongeldig waarde is opgegeven voor een datum veld
    Gegeven de response is een problemdetails met de melding dat de opgegeven verblijfdatum ongeldig is
    Dan is de response in json formaat
    """
    {
      "type": "https://www.rfc-editor.org/rfc/rfc9110.html#name-400-bad-request",
      "title": "Een of meerdere parameters zijn niet correct.",
      "status": 400,
      "detail": "De foutieve parameter(s) zijn: verblijfdatum.",
      "code": "paramsValidation",
      "instance": "/api/brp/adressen",
      "invalidParams": [
        {
          "code": "date",
          "name": "verblijfdatum",
          "reason": "Waarde is geen geldige datum."
        }
      ]
    }
    """

  Abstract Scenario: Een niet-bestaande identificatie code is opgegeven
    Gegeven de response is een problemdetails met de melding dat een <resourceNaam> met de opgegeven <parameterNaam> niet bestaat
    Dan is de response in json formaat
    """
    {
      "type": "https://www.rfc-editor.org/rfc/rfc9110.html#name-400-bad-request",
      "title": "Een of meerdere parameters zijn niet correct.",
      "status": 400,
      "detail": "De foutieve parameter(s) zijn: <parameterNaam>.",
      "code": "paramsValidation",
      "instance": "/api/brp/adressen",
      "invalidParams": [
        {
          "code": "notFound",
          "name": "<parameterNaam>",
          "reason": "<resourceNaam2> bestaat niet."
        }
      ]
    }
    """

    Voorbeelden:
    | resourceNaam | resourceNaam2 | parameterNaam                      |
    | gemeente     | Gemeente      | gemeentecode                       |
    | adres        | Adres         | adresseerbaar object identificatie |
