# language: nl
Functionaliteit: Gebeurtenis wanneer er een onderzoek gestart is naar het overlijden
  Als abonnee wil ik weten dat een onderzoek naar het overlijden is gestart,
  zodat ik een onderzoek kan starten naar de consequenties van dit onderzoek op mijn dienstverlening.

  In de gebeurtenis wordt de identificatie - het A-nummer - van de betreffende persoon en het onderzoek in de data opgenomen.
  
  In onderstaande scenarios wordt de aanduiding gegevens in onderzoek omschreven. Deze omschrijvingen vertalen naar codes elementnummers die in de BRP zijn opgeslagen:
  | omschrijving gegevens in onderzoek | aanduiding in onderzoek in BRP |
  | de hele categorie overlijden       |                         060000 |
  | datum van overlijden               |                         060810 |
  | plaats van overijden               |                         060820 |
  | land van overlijden                |                         060830 |

  Achtergrond:
    Gegeven de persoon 'Jan'

  Regel: Als een onderzoek gestart is naar het overlijden, heeft de gebeurtenis 'overlijden.onderzoek-gestart' plaatsgevonden

    Scenario: Er start een onderzoek of de persoon nog in leven is
      Gegeven het overlijden van 'Jan' op '12-08-2026' in 'Gemeente Roosendaal' is verwerkt
      Als een onderzoek is gestart naar 'de hele categorie overlijden' van 'Jan'
      Dan is een 'overlijden.onderzoek-gestart' gebeurtenis gepubliceerd

    Abstract Scenario: Er start een onderzoek of <betwijfelde gegeven> van overlijden juist is
      Gegeven het overlijden van 'Jan' op '12-08-2026' in 'Gemeente Roosendaal' is verwerkt
      Als een onderzoek is gestart naar '<betwijfelde gegeven>' van 'Jan'
      Dan is een 'overlijden.onderzoek-gestart' gebeurtenis gepubliceerd

      Voorbeelden:
        | betwijfelde gegeven  |
        | datum van overlijden |
        | plaats van overijden |
        | land van overlijden  |

  Regel: Bij gebeurtenistype 'overlijden.onderzoek-gestart' wordt het A-nummer van de persoon en gegevens over het onderzoek meegeleverd

    Scenario: Er is een onderzoek gestart naar het overlijden van de persoon
      Gegeven het overlijden van 'Jan' op '12-08-2026' in 'Gemeente Roosendaal' is verwerkt
      Als op '03-09-2026' een onderzoek is gestart naar 'de hele categorie overlijden' van 'Jan'
      Dan is een 'overlijden.onderzoek-gestart' gebeurtenis gepubliceerd met de volgende data
      * het A-nummer van 'Jan'
      * aanduiding gegevens in onderzoek 'de hele categorie overlijden'
      * datum ingang onderzoek '03-09-2026'
