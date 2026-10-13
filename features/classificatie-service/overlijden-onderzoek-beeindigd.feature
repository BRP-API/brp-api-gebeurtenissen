# language: nl
Functionaliteit: Gebeurtenis wanneer er een onderzoek naar het overlijden is beëindigd
  Als abonnee wil ik weten dat een onderzoek naar het overlijden is beëindigd,
  zodat ik een onderzoek kan starten naar de consequenties van de uitkomst van dit onderzoek op mijn dienstverlening.

  Zie https://www.rvig.nl/hup/het-beeindigen-van-een-onderzoek

  Als er naar aanleiding van het onderzoek gegevens moeten worden gecorrigeerd of gewijzigd, wordt eerst het onderzoek beëindigd vóór de wijzigingen worden aangebracht.
  Er zijn dus geen regels nodig voor onderscheid tussen beëindigen onderzoek met of juist zonder correctie/wijziging.
  De abonnee ontvangt bij een correctie na onderzoek dus twee gebeurtenissen: een voor beëindigen van het onderzoek en een voor de correctie.

  In de gebeurtenis wordt de identificatie - het A-nummer - van de betreffende persoon en het onderzoek in de data opgenomen.

  Aan de abonnee wordt geen data meegestuurd waaruit af te leiden is wat exact onderzocht wordt, omdat we niet weten voor welke gegevens de abonnee geautoriseerd is.

  Achtergrond:
    Gegeven de persoon 'Jan'

  Regel: Als een onderzoek naar het overlijden is beëindigd, heeft de gebeurtenis 'overlijden-onderzoek-beeindigd' plaatsgevonden

    Abstract Scenario: Onderzoek naar <betwijfeld gegeven> is beëindigd
      Gegeven het overlijden van 'Jan' op '12-08-2026' in 'Gemeente Roosendaal' is verwerkt
      En een onderzoek loopt naar '<betwijfeld gegeven>' op het overlijden van 'Jan'
      Als het onderzoek naar het overlijden van 'Jan' is beëindigd
      Dan is een 'overlijden-onderzoek-beeindigd' gebeurtenis gepubliceerd

      Voorbeelden:
        | betwijfeld gegeven           |
        | de hele categorie overlijden |
        | de groep overlijden          |
        | datum van overlijden         |
        | plaats van overijden         |
        | land van overlijden          |

    Scenario: Onderzoek is beëindigd en het overlijden wordt gecorrigeerd
      Gegeven het overlijden van 'Jan' op '12-08-2026' in 'Gemeente Roosendaal' is verwerkt
      En een onderzoek loopt naar 'de hele categorie overlijden' op het overlijden van 'Jan'
      Als het onderzoek naar het overlijden van 'Jan' is beëindigd
      En het overlijden van 'Jan' onjuist is en 'Jan' is niet overleden
      Dan is een 'overlijden-onderzoek-beeindigd' gebeurtenis gepubliceerd

  Regel: Bij gebeurtenistype 'overlijden-onderzoek-beeindigd' wordt het A-nummer van de persoon en gegevens over het onderzoek meegeleverd
    De gebeurtenis bevat gegevens over het onderzoek zoals ze geldig zijn na de wijziging.
      
    Scenario: Onderzoek naar datum van overlijden is beëindigd
      Gegeven het overlijden van 'Jan' op '12-08-2026' in 'Gemeente Roosendaal' is verwerkt
      En op '03-09-2026' een onderzoek is gestart naar 'datum van overlijden' op het overlijden van 'Jan'
      Als het onderzoek naar het overlijden van 'Jan' is beëindigd op '08-10-2026'
      Dan is een 'overlijden-onderzoek-beeindigd' gebeurtenis gepubliceerd met de volgende data
      * het A-nummer van 'Jan'
      * aanduiding gegevens in onderzoek 'datum van overlijden'
      * datum ingang onderzoek '03-09-2026'
      * datum einde onderzoek '08-10-2026'
