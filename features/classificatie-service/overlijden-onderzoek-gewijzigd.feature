# language: nl
Functionaliteit: Gebeurtenis wanneer er een onderzoek naar het overlijden is gewijzigd
  In de gebeurtenis wordt alleen de identificatie - het A-nummer - van de betreffende persoon in de data opgenomen.
  Er wordt geen data meegestuurd waaruit af te leiden is wat gewijzigd is aan het onderzoek, omdat we niet weten voor welke gegevens de abonnee geautoriseerd is.
  De abonnee kan de actuele informatie over het onderzoek desgewenst ophalen in de BRP-API.

  Achtergrond:
    Gegeven de persoon 'Jan'

  Regel: Als een onderzoek naar het overlijden is gewijzigd, heeft de gebeurtenis 'overlijden-onderzoek-gewijzigd' plaatsgevonden
    Dit is het geval wanneer de aanduiding gegevens in onderzoek wordt gewijzigd.

    Abstract Scenario: Het onderzoek wordt <wijziging van het onderzoek>
      Gegeven het overlijden van 'Jan' op '12-08-2026' in 'Gemeente Roosendaal' is verwerkt
      En een onderzoek loopt naar '<betwijfelde gegevens oorspronkelijk>' op het overlijden op '12-08-2026' van 'Jan'
      Als het onderzoek naar het overlijden van 'Jan' op '12-08-2026' is gewijzigd naar '<betwijfelde gegevens na wijziging>'
      Dan is een 'overlijden-onderzoek-gewijzigd' gebeurtenis gepubliceerd

      Voorbeelden:
        | wijziging van het onderzoek | betwijfelde gegevens oorspronkelijk | betwijfelde gegevens na wijziging |
        | uitgebreid                  | plaats van overlijden               | de hele categorie overlijden      |
        | beperkt                     | de hele categorie overlijden        | datum van overlijden              |

  Regel: Bij gebeurtenistype 'overlijden-onderzoek-gewijzigd' wordt het A-nummer van de persoon meegeleverd

    Scenario: Het onderzoek wordt uitgebreid
      Gegeven het overlijden van 'Jan' op '12-08-2026' in 'Gemeente Roosendaal' is verwerkt
      En een onderzoek loopt naar 'plaats van overlijden' op het overlijden op '12-08-2026' van 'Jan'
      Als het onderzoek naar het overlijden van 'Jan' op '12-08-2026' is gewijzigd naar 'de hele categorie overlijden'
      Dan is een 'overlijden-onderzoek-gewijzigd' gebeurtenis gepubliceerd met de volgende data
      * het A-nummer van 'Jan'
