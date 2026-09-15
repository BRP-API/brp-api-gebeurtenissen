# language: nl
Functionaliteit: Gebeurtenis wanneer er een onderzoek naar de verblijfplaats is beëindigd
  Zie https://www.rvig.nl/hup/het-beeindigen-van-een-onderzoek

  Als er naar aanleiding van het onderzoek gegevens moeten worden gecorrigeerd of gewijzigd, wordt eerst het onderzoek beëindigd vóór de wijzigingen worden aangebracht.
  Er zijn dus geen regels nodig voor onderscheid tussen beëindigen onderzoek met of juist zonder correctie/wijziging.
  De abonnee ontvangt bij een correctie na onderzoek dus twee gebeurtenissen: een voor beëindigen van het onderzoek en een voor de correctie.

  Achtergrond:
    Gegeven het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    * in gemeente 'Hengelo'
    En het adres 'Beursstraat_44_Hengelo'
    * in gemeente 'Hengelo'
    En de persoon 'Jan'
    * verblijft vanaf '14-04-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    * verblijft vanaf '14-06-2026' op het adres 'Beursstraat_44_Hengelo'
    Gegeven het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    * in gemeente 'Hengelo'
    En het adres 'Beursstraat_44_Hengelo'
    * in gemeente 'Hengelo'
    En de persoon 'Jan'
    * verblijft vanaf '14-04-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    * verblijft vanaf '14-06-2026' op het adres 'Beursstraat_44_Hengelo'

  Regel: Als een onderzoek naar de actuele verblijfplaats is beëindigd, heeft de gebeurtenis 'verblijfplaats-onderzoek-beeindigd' plaatsgevonden

    Abstract Scenario: Onderzoek naar <omschrijving betwijfeld gegeven> is beëindigd zonder wijziging of correctie van de verblijfplaats
      Gegeven een onderzoek loopt naar '<betwijfelde rubriek>' van het verblijf op het adres 'Beursstraat_44_Hengelo' van 'Jan'
      Als het onderzoek naar het verblijf op het adres 'Beursstraat_44_Hengelo' van 'Jan' is beëindigd
      Dan is een 'verblijfplaats-onderzoek-beeindigd' gebeurtenis gepubliceerd

      Voorbeelden:
        | omschrijving betwijfeld gegeven | betwijfelde rubriek | soort aanduiding                 |
        | de verblijfplaats               |              080000 | de hele categorie verblijfplaats |
        | het adres                       |              081100 | de groep adres                   |
        | de datum aanvang                |              081030 | een enkel element                |
