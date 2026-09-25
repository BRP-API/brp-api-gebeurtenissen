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
    En het adres 'Beursstraat_44A_Hengelo'
    * in gemeente 'Hengelo'
    En het adres 'Kadeplein_2_Roosendaal'
    * in gemeente 'Roosendaal'
    En de persoon 'Jan'
    * verblijft vanaf '14-04-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    * verblijft vanaf '14-06-2026' op het adres 'Beursstraat_44_Hengelo'

  Regel: Als een onderzoek naar de actuele verblijfplaats is beëindigd, heeft de gebeurtenis 'verblijfplaats-onderzoek-beeindigd' plaatsgevonden

    Abstract Scenario: Onderzoek naar <betwijfeld gegeven> is beëindigd zonder wijziging of correctie van de verblijfplaats
      Gegeven een onderzoek loopt naar '<betwijfeld gegeven>' van het verblijf op het adres 'Beursstraat_44_Hengelo' van 'Jan'
      Als het onderzoek naar het verblijf op het adres 'Beursstraat_44_Hengelo' van 'Jan' is beëindigd
      Dan is een 'verblijfplaats-onderzoek-beeindigd' gebeurtenis gepubliceerd

      Voorbeelden:
        | betwijfeld gegeven               |
        | de hele categorie verblijfplaats |
        | de groep adres                   |
        | datum aanvang adreshouding       |

    Scenario: Onderzoek naar de verblijfplaats is beëindigd met een correctie van het adres
      Gegeven een onderzoek loopt naar 'de hele categorie verblijfplaats' van het verblijf op het adres 'Beursstraat_44_Hengelo' van 'Jan'
      Als het onderzoek naar het verblijf op het adres 'Beursstraat_44_Hengelo' van 'Jan' is beëindigd
      En de verblijfplaats vanaf '14-06-2026' op het adres 'Beursstraat_44_Hengelo' onjuist is
      En de juiste verblijfplaats is het adres 'Beursstraat_44A_Hengelo' vanaf '14-06-2026'
      Dan is een 'verblijfplaats-onderzoek-beeindigd' gebeurtenis gepubliceerd

    Scenario: Onderzoek naar de verblijfplaats is beëindigd met een wijziging van het adres
      Gegeven een onderzoek loopt naar 'de hele categorie verblijfplaats' van het verblijf op het adres 'Beursstraat_44_Hengelo' van 'Jan'
      Als het onderzoek naar het verblijf op het adres 'Beursstraat_44_Hengelo' van 'Jan' is beëindigd
      En 'Jan' verblijft vanaf '24-9-2026' op het adres 'Kadeplein_2_Roosendaal'
      Dan is een 'verblijfplaats-onderzoek-beeindigd' gebeurtenis gepubliceerd

    Scenario: De persoon heeft een nieuw adres en het onderzoek naar de vorige verblijfplaats is niet beëindigd
      Gegeven een onderzoek loopt naar 'de hele categorie verblijfplaats' van het verblijf op het adres 'Beursstraat_44_Hengelo' van 'Jan'
      Als de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2026' op het adres 'Kadeplein_2_Roosendaal'
      Dan is er geen 'verblijfplaats-onderzoek-beeindigd' gebeurtenis gepubliceerd