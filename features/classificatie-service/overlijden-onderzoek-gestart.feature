# language: nl
Functionaliteit: Gebeurtenis wanneer er een onderzoek gestart is naar het overlijden
  In de gebeurtenis wordt alleen de identificatie - het A-nummer - van de betreffende persoon in de data opgenomen.
  Meer gegevens zijn niet nodig, omdat overlijden geen historie heeft.

  Er wordt geen data meegestuurd waaruit af te leiden is wat exact onderzocht wordt, omdat we niet weten voor welke gegevens de abonnee geautoriseerd is.

  De abonnee kan meer informatie over het onderzoek desgewenst ophalen in de BRP-API, met enkele kanttekeningen:
  - Als het onderzoek alleen gaat over een gegeven waar de abonnee niet voor geautoriseerd is, kan de abonnee het onderzoek niet zien in de BRP-API
  - Als aanvullende gegevens over het onderzoek worden gevraagd nadat het onderzoek al is afgerond, kan de abonnee het onderzoek niet meer zien in de BRP-API

  Achtergrond:
    Gegeven de persoon 'Jan'

  Regel: Als een onderzoek gestart is naar het overlijden, heeft de gebeurtenis 'overlijden-onderzoek-gestart' plaatsgevonden

    Scenario: Er start een onderzoek of de persoon nog in leven is
      Gegeven het overlijden van 'Jan' op '12-08-2026' in 'Gemeente Roosendaal' is verwerkt
      Als een onderzoek is gestart naar 'de hele categorie overlijden' van 'Jan'
      Dan is een 'overlijden-onderzoek-gestart' gebeurtenis gepubliceerd

    Abstract Scenario: Er start een onderzoek of <betwijfelde gegeven> van overlijden juist is
      Gegeven het overlijden van 'Jan' op '12-08-2026' in 'Gemeente Roosendaal' is verwerkt
      Als een onderzoek is gestart naar '<betwijfelde gegeven>' van 'Jan'
      Dan is een 'overlijden-onderzoek-gestart' gebeurtenis gepubliceerd

      Voorbeelden:
        | betwijfelde gegeven  |
        | datum van overlijden |
        | plaats van overijden |
        | land van overlijden  |

  Regel: Bij gebeurtenistype 'overlijden-onderzoek-gestart' wordt het A-nummer van de persoon meegeleverd
      
    Scenario: Er start een onderzoek of de persoon nog in leven is
      Gegeven het overlijden van 'Jan' op '12-08-2026' in 'Gemeente Roosendaal' is verwerkt
      Als een onderzoek is gestart naar 'de hele categorie overlijden' van 'Jan'
      Dan is een 'overlijden-onderzoek-gestart' gebeurtenis gepubliceerd met de volgende data
      * het A-nummer van 'Jan'

