# language: nl
Functionaliteit: Registreer abonnee
  Als consumer van BRP API Gebeurtenissen
  wil ik mij kunnen registreren als abonnee
  zodat ik gebeurtenissen kan krijgen van personen aan wie ik diensten verleen om daarmee mijn dienstverlening te verbeteren

  Regel: een afnemer kan een of meerdere abonnees registreren
    Een afnemer kan dit gebruiken wanneer er meerdere interne afnemers (applicaties, processen) zijn die eigen abonnementen kunnen zetten

    Scenario: Een afnemer die al geregistreerd is als abonnee registreert zich met een tweede abonnee
      Gegeven de afnemer 'Gemeente Den Haag'
      * is geregistreerd als abonnee 'szw' van BRP API Gebeurtenissen
      Als de afnemer zich registreert als abonnee 'JZ'
      Dan is een 'abonnee-geregistreerd' gebeurtenis gepubliceerd met de volgende velden
      * 'afnemerId' met de afnemer id van 'Gemeente Den Haag'
      * 'abonnee' met de waarde 'JZ'
      En is de response '201 Created'

    Scenario: Een niet-geautheniceerde gebruiker probeert zich te registreren als abonnee
      Als een niet-geauthenticeerde gebruiker zich registreert als abonnee
      Dan zijn er geen gebeurtenissen gepubliceerd
      En is de response '401 Unauthorized'

  Regel: Bij het registreren moet een naam van de abonnee worden opgegeven

    Scenario: Een afnemer probeert zich te registreren zonder de naam van de abonnee op te geven
      Als een niet-geauthenticeerde gebruiker zich registreert als abonnee
      Dan zijn er geen gebeurtenissen gepubliceerd
      En is de response '400 Bad Request'
      * 'detail' met tekst 'De foutieve parameter(s) zijn: abonnee.'
      * een 'invalidParams' met de volgende gegevens
        | code     | name    | reason                  |
        | required | abonnee | Parameter is verplicht. |

  Regel: Een abonnee kan zich alleen registreren als hij nog niet staat geregistreerd als abonnee van BRP API Gebeurtenissen

    Scenario: Een reeds geregistreerde abonnee registreert zich opnieuw
      Gegeven de afnemer 'Gemeente Den Haag'
      * is geregistreerd als abonnee 'szw' van BRP API Gebeurtenissen
      Als de afnemer zich registreert als abonnee 'szw'
      Dan zijn er geen gebeurtenissen gepubliceerd
      En is de response '409 Conflict' met de volgende velden
      * 'detail' met tekst 'Uw verzoek kan niet worden uitgevoerd omdat u al als abonnee geregistreerd bent.'

    Scenario: Een afnemer mag zich registreren met een abonneenaam die door een andere afnemer ook al gebruikt wordt
      Gegeven de afnemer 'Gemeente Rotterdam'
      * is geregistreerd als abonnee 'szw' van BRP API Gebeurtenissen
      En de afnemer 'Gemeente Den Haag'
      * is niet geregistreerd als abonnee van BRP API Gebeurtenissen
      Als de afnemer 'Gemeente Den Haag' zich registreert als abonnee 'szw'
      Dan is een 'abonnee-geregistreerd' gebeurtenis gepubliceerd met de volgende velden
      * 'afnemerId' met de afnemer id van 'Gemeente Den Haag'
      * 'abonnee' met de waarde 'szw'
      En is de response '201 Created'
