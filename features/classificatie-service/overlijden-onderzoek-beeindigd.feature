# language: nl
Functionaliteit: Gebeurtenis wanneer er een onderzoek naar het overlijden is beëindigd
  Zie https://www.rvig.nl/hup/het-beeindigen-van-een-onderzoek

  Als er naar aanleiding van het onderzoek gegevens moeten worden gecorrigeerd of gewijzigd, wordt eerst het onderzoek beëindigd vóór de wijzigingen worden aangebracht.
  Er zijn dus geen regels nodig voor onderscheid tussen beëindigen onderzoek met of juist zonder correctie/wijziging.
  De abonnee ontvangt bij een correctie na onderzoek dus twee gebeurtenissen: een voor beëindigen van het onderzoek en een voor de correctie.

  Achtergrond:
    Gegeven de persoon 'Jan'

  Regel: Als een onderzoek naar het overlijden is beëindigd, heeft de gebeurtenis 'overlijden-onderzoek-beeindigd' plaatsgevonden

    Abstract Scenario: Onderzoek naar <betwijfeld gegeven> is beëindigd
      Gegeven het overlijden van 'Jan' op '12-08-2026' in 'Gemeente Roosendaal' is verwerkt
      En een onderzoek loopt naar '<betwijfeld gegeven>' op het overlijden op '12-08-2026' van 'Jan'
      Als het onderzoek naar het overlijden van 'Jan' op '12-08-2026' is beëindigd
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
      En een onderzoek loopt naar 'de hele categorie overlijden' op het overlijden op '12-08-2026' van 'Jan'
      Als het onderzoek naar het overlijden van 'Jan' op '12-08-2026' is beëindigd
      En het overlijden op '12-08-2026' onjuist is
      * de persoon is niet overleden
      Dan is een 'overlijden-onderzoek-beeindigd' gebeurtenis gepubliceerd
