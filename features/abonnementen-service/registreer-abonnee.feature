#language: nl

Functionaliteit: Registreer abonnee

  Als consumer van BRP API Gebeurtenissen
  wil ik mij kunnen registreren als abonnee
  zodat ik gebeurtenissen kan krijgen van personen aan wie ik diensten verleen om daarmee mijn dienstverlening te verbeteren

  Regel: Een afnemer kan zich alleen registreren als hij nog niet staat geregistreerd als abonnee van BRP API Gebeurtenissen

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

  Regel: een afnemer kan een of meerdere rollen registreren
    Een afnemer kan dit gebruiken wanneer er meerdere interne afnemers (applicaties, processen) zijn die eigen abonnementen kunnen zetten

    Scenario: Een niet-geregistreerde afnemer registreert zich met een rol als abonnee
      Gegeven de afnemer 'Gemeente Den Haag'
      * is niet geregistreerd als abonnee van BRP API Gebeurtenissen
      Als de afnemer zich registreert als abonnee met de rol 'szw'
      Dan is een 'abonnee-geregistreerd' gebeurtenis gepubliceerd met de volgende velden
      * 'afnemerId' met de afnemer id van 'Gemeente Den Haag'
      * 'rol' met de waarde 'szw'
      En is de response '201 Created'

    Scenario: Een afnemer die al geregistreerd is met een rol registreert zich met een tweede rol als abonnee
      Gegeven de afnemer 'Gemeente Den Haag'
      * is geregistreerd als abonnee van BRP API Gebeurtenissen met rol 'szw'
      Als de afnemer zich registreert als abonnee met de rol 'JZ'
      Dan is een 'abonnee-geregistreerd' gebeurtenis gepubliceerd met de volgende velden
      * 'afnemerId' met de afnemer id van 'Gemeente Den Haag'
      * 'rol' met de waarde 'JZ'
      En is de response '201 Created'

    Scenario: Een afnemer die al geregistreerd is zonder rol registreert zich met een rol als abonnee
      Gegeven de afnemer 'Gemeente Den Haag'
      * is geregistreerd als abonnee van BRP API Gebeurtenissen
      Als de afnemer zich registreert als abonnee met de rol 'JZ'
      Dan is een 'abonnee-geregistreerd' gebeurtenis gepubliceerd met de volgende velden
      * 'afnemerId' met de afnemer id van 'Gemeente Den Haag'
      * 'rol' met de waarde 'JZ'
      En is de response '201 Created'
