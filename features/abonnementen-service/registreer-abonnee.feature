#language: nl

Functionaliteit: Registreer abonnee

  Als consumer van BRP API Gebeurtenissen
  wil ik mij kunnen registreren als abonnee
  zodat ik gebeurtenissen krijg van personen aan wie ik diensten verleen om daarmee mijn dienstverlening te verbeteren

  Regel: Alleen een niet als abonnee geregistreerde afnemer kan zich registreren als abonnee van BRP API Gebeurtenissen

    Scenario: Een niet-geregistreerde afnemer registreert zich als abonnee
      Gegeven de afnemer 'Gemeente Den Haag'
      * is niet geregistreerd als abonnee van BRP API Gebeurtenissen
      Als een registreer abonnee verzoek wordt gedaan door afnemer 'Gemeente Den Haag'
      Dan is een 'abonnee-geregistreerd' gebeurtenis gepubliceerd
      * bevat de 'data' de afnemer id van 'Gemeente Den Haag'
      En wordt een '201 Created' bericht geleverd

    Scenario: Een reeds geregistreerde afnemer registreert zich als abonnee
      Gegeven de afnemer 'Gemeente Den Haag'
      En de verwerkte registreer abonnee verzoek gedaan door afnemer 'Gemeente Den Haag'
      Als nog een registreer abonnee verzoek wordt gedaan door afnemer 'Gemeente Den Haag'
      Dan zijn er geen gebeurtenissen gepubliceerd
      En wordt een '409 Conflict' bericht geleverd
      * bevat detail de tekst 'Uw verzoek kan niet worden uitgevoerd omdat u al als abonnee geregistreerd bent.'

    Scenario: Een niet-geautheniceerde gebruiker probeert zich te registreren als abonnee
      Als een registreer abonnee verzoek wordt gedaan door een niet-geauthenticeerde gebruiker
      Dan zijn er geen gebeurtenissen gepubliceerd
      En wordt een '401 Unauthorized' bericht geleverd
