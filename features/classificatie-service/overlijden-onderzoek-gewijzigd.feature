# language: nl
Functionaliteit: Gebeurtenis wanneer er een onderzoek naar het overlijden is gewijzigd
  Als abonnee wil ik weten dat een onderzoek naar het overlijden is gewijzigd,
  zodat ik een onderzoek kan starten naar de consequenties van dit onderzoek op mijn dienstverlening.

  In de gebeurtenis wordt de identificatie - het A-nummer - van de betreffende persoon en het onderzoek in de data opgenomen.

  Aan de abonnee wordt geen data meegestuurd waaruit af te leiden is wat exact onderzocht wordt, omdat we niet weten voor welke gegevens de abonnee geautoriseerd is.
  
  Achtergrond:
    Gegeven de persoon 'Jan'

  Regel: Als een onderzoek naar het overlijden is gewijzigd, heeft de gebeurtenis 'overlijden.onderzoek-gewijzigd' plaatsgevonden
    Dit is het geval wanneer de aanduiding gegevens in onderzoek wordt gewijzigd.

    Abstract Scenario: Het onderzoek wordt <wijziging van het onderzoek>
      Gegeven het overlijden van 'Jan' op '12-08-2026' in 'Gemeente Roosendaal' is verwerkt
      En een onderzoek loopt naar '<betwijfelde gegevens oorspronkelijk>' op het overlijden van 'Jan'
      Als het onderzoek naar het overlijden van 'Jan' is gewijzigd naar '<betwijfelde gegevens na wijziging>'
      Dan is een 'overlijden.onderzoek-gewijzigd' gebeurtenis gepubliceerd

      Voorbeelden:
        | wijziging van het onderzoek | betwijfelde gegevens oorspronkelijk | betwijfelde gegevens na wijziging |
        | uitgebreid                  | plaats van overlijden               | de hele categorie overlijden      |
        | beperkt                     | de hele categorie overlijden        | datum van overlijden              |

  Regel: Bij gebeurtenistype 'overlijden.onderzoek-gewijzigd' wordt het A-nummer van de persoon en gegevens over het onderzoek meegeleverd
    De gebeurtenis bevat gegevens over het onderzoek zoals ze geldig zijn na de wijziging.

    Scenario: Het onderzoek wordt gewijzigd
      Gegeven het overlijden van 'Jan' op '12-08-2026' in 'Gemeente Roosendaal' is verwerkt
      En op '03-09-2026' een onderzoek is gestart naar 'de hele categorie overlijden' op het overlijden van 'Jan'
      Als op '23-09-2026' het onderzoek naar het overlijden van 'Jan' is gewijzigd naar 'datum van overlijden'
      Dan is een 'overlijden.onderzoek-gewijzigd' gebeurtenis gepubliceerd met de volgende data
      * het A-nummer van 'Jan'
      * aanduiding gegevens in onderzoek 'datum van overlijden'
      * datum ingang onderzoek '03-09-2026'
