# language: nl
Functionaliteit: Gebeurtenis wanneer er een onderzoek gestart is naar het overlijden
  Als abonnee wil ik weten dat een onderzoek naar het overlijden is gestart,
  zodat ik een onderzoek kan starten naar de consequenties van dit onderzoek op mijn dienstverlening.

  In de gebeurtenis wordt de identificatie - het A-nummer - van de betreffende persoon en het onderzoek in de data opgenomen.

  Aan de abonnee wordt geen data meegestuurd waaruit af te leiden is wat exact onderzocht wordt, omdat we niet weten voor welke gegevens de abonnee geautoriseerd is.
  De abonnee kan meer informatie over het onderzoek desgewenst ophalen in de BRP-API, met enkele kanttekeningen:
  - Als het onderzoek alleen gaat over een gegeven waar de abonnee niet voor geautoriseerd is, kan de abonnee het onderzoek niet zien in de BRP-API
  - Als aanvullende gegevens over het onderzoek worden gevraagd nadat het onderzoek al is afgerond, kan de abonnee het onderzoek niet meer zien in de BRP-API
  
  In onderstaande scenarios wordt de aanduiding gegevens in onderzoek omschreven. Deze omschrijvingen vertalen naar codes elementnummers die in de BRP zijn opgeslagen:
  | omschrijving gegevens in onderzoek | aanduiding in onderzoek in BRP |
  | de hele categorie overlijden       |                         060000 |
  | datum van overlijden               |                         060810 |
  | plaats van overijden               |                         060820 |
  | land van overlijden                |                         060830 |

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

  Regel: Bij gebeurtenistype 'overlijden-onderzoek-gestart' wordt het A-nummer van de persoon en gegevens over het onderzoek meegeleverd

    Scenario: Er start een onderzoek of de persoon nog in leven is
      Gegeven het overlijden van 'Jan' op '12-08-2026' in 'Gemeente Roosendaal' is verwerkt
      Als op '03-09-2026' een onderzoek is gestart naar 'de hele categorie overlijden' van 'Jan'
      Dan is een 'overlijden-onderzoek-gestart' gebeurtenis gepubliceerd met de volgende data
      * het A-nummer van 'Jan'
      * aanduiding gegevens in onderzoek 'de hele categorie overlijden'
      * datum ingang onderzoek '03-09-2026'
