#language: nl

Functionaliteit: Registreer abonnee

  Als consumer van BRP API Gebeurtenissen
  wil ik mij kunnen registreren als abonnee
  zodat ik gebeurtenissen krijg van personen aan wie ik diensten verleen om daarmee mijn dienstverlening te verbeteren

  Regel: Alleen een niet als abonnee geregistreerde afnemer kan zich registreren als abonnee van BRP API Gebeurtenissen

    Scenario: Een niet-geregistreerde afnemer registreert zich als abonnee
      Gegeven de afnemer 'Gemeente Den Haag'
      * is niet geregistreerd als abonnee van BRP API Gebeurtenissen
      Als de afnemer zich registreert als abonnee
      Dan is een 'abonnee-geregistreerd' gebeurtenis gepubliceerd met de volgende velden
      * 'afnemerId' met de afnemer id van 'Gemeente Den Haag'
      En is de response '201 Created'

    Scenario: Een reeds geregistreerde afnemer registreert zich als abonnee
      Gegeven de afnemer 'Gemeente Den Haag'
      * is geregistreerd als abonnee van BRP API Gebeurtenissen
      Als de afnemer zich registreert als abonnee
      Dan zijn er geen gebeurtenissen gepubliceerd
      En is de response '409 Conflict' met de volgende velden
      * 'detail' met tekst 'Uw verzoek kan niet worden uitgevoerd omdat u al als abonnee geregistreerd bent.'

    Scenario: Een niet-geautheniceerde gebruiker probeert zich te registreren als abonnee
      Als een niet-geauthenticeerde gebruiker zich registreert als abonnee
      Dan zijn er geen gebeurtenissen gepubliceerd
      En is de response '401 Unauthorized'
