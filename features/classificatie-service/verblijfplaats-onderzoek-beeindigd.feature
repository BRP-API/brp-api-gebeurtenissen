# language: nl
Functionaliteit: Gebeurtenis wanneer er een onderzoek naar de verblijfplaats is beëindigd
  Als abonnee wil ik weten dat een onderzoek naar de verblijfplaats is eëindigd,
  zodat ik een onderzoek kan starten naar de consequenties van de uitkomst van dit onderzoek op mijn dienstverlening.

  Als abonnee wil ik weten als een onderzoek naar het adres van een debiteur os beëindigd, 
  want dan moeten we de invordering weer opstarten. 

  Zie https://www.rvig.nl/hup/het-beeindigen-van-een-onderzoek

  In de gebeurtenis wordt de identificatie - het A-nummer - van de betreffende persoon en het onderzoek in de data opgenomen.
  Daarnaast worden enkele gegevens van de verblijfplaats opgenomen:
  - datum aanvang adreshouding dan wel datum aanvang verblijf buitenland
  - adresseerbaar object identificatie van het adres
  - functie adres

  Aan de abonnee wordt van de verblijfplaats alleen de datum aanvang van adreshouding of verblijf buitenland opgenomen.
  De datum aanvang wordt geleverd, zodat de abonnee de gebeurtenis kan relateren aan een verblijf.
  
  Aan de abonnee wordt geen data meegestuurd waaruit af te leiden is waar het onderzoek over ging, omdat we niet weten voor welke gegevens de abonnee geautoriseerd is.

  Als er naar aanleiding van het onderzoek gegevens worden gecorrigeerd of gewijzigd, wordt eerst het onderzoek beëindigd vóór de wijzigingen worden aangebracht.
  Er zijn dus geen regels nodig voor onderscheid tussen beëindigen onderzoek met of juist zonder correctie/wijziging.
  Bij een correctie na onderzoek worden er dus twee gebeurtenissen gepubliceerd: een voor beëindigen van het onderzoek en een voor de correctie.

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
    * verblijft vanaf '19-06-2026' op het adres 'Beursstraat_44_Hengelo'

  Regel: Als een onderzoek naar de actuele verblijfplaats is beëindigd, heeft de gebeurtenis 'verblijfplaats-onderzoek-beeindigd' plaatsgevonden

    Abstract Scenario: Onderzoek naar <betwijfeld gegeven> is beëindigd zonder wijziging of correctie van de verblijfplaats
      Gegeven een onderzoek loopt naar '<betwijfeld gegeven>' van het verblijf op adres 'Beursstraat_44_Hengelo' van 'Jan'
      Als het onderzoek naar het verblijf op adres 'Beursstraat_44_Hengelo' van 'Jan' is beëindigd
      Dan is een 'verblijfplaats-onderzoek-beeindigd' gebeurtenis gepubliceerd

      Voorbeelden:
        | betwijfeld gegeven               |
        | de hele categorie verblijfplaats |
        | de groep adres                   |
        | datum aanvang adreshouding       |

    Scenario: Onderzoek naar de verblijfplaats is beëindigd met een correctie van het adres
      Gegeven een onderzoek loopt naar 'de hele categorie verblijfplaats' van het verblijf op adres 'Beursstraat_44_Hengelo' van 'Jan'
      Als het onderzoek naar het verblijf op adres 'Beursstraat_44_Hengelo' van 'Jan' is beëindigd
      En de verblijfplaats vanaf '19-06-2026' op het adres 'Beursstraat_44_Hengelo' onjuist is
      En de juiste verblijfplaats is het adres 'Beursstraat_44A_Hengelo' vanaf '19-06-2026'
      Dan is een 'verblijfplaats-onderzoek-beeindigd' gebeurtenis gepubliceerd

    Scenario: Onderzoek naar de verblijfplaats is beëindigd met een wijziging van het adres
      Gegeven een onderzoek loopt naar 'de hele categorie verblijfplaats' van het verblijf op adres 'Beursstraat_44_Hengelo' van 'Jan'
      Als het onderzoek naar het verblijf op adres 'Beursstraat_44_Hengelo' van 'Jan' is beëindigd
      En 'Jan' verblijft vanaf '24-9-2026' op het adres 'Kadeplein_2_Roosendaal'
      Dan is een 'verblijfplaats-onderzoek-beeindigd' gebeurtenis gepubliceerd

    Scenario: De persoon heeft een nieuw adres en het onderzoek naar de vorige verblijfplaats is niet beëindigd
      Gegeven een onderzoek loopt naar 'de hele categorie verblijfplaats' van het verblijf op adres 'Beursstraat_44_Hengelo' van 'Jan'
      Als de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2026' op het adres 'Kadeplein_2_Roosendaal'
      Dan is er geen 'verblijfplaats-onderzoek-beeindigd' gebeurtenis gepubliceerd

  Regel: Bij gebeurtenistype verblijfplaats-onderzoek-beeindigd' wordt het A-nummer van de persoon meegeleverd en gegevens over het onderzoek en het betreffende verblijf
    Van de verblijfplaats worden alleen de volgende gegevens geleverd:
    - functie adres
    - datum aanvang adreshouding dan wel datum aanvang verblijf buitenland
    - adresseerbaar object identificatie van het adres

    Scenario: Onderzoek naar de verblijfplaats is beëindigd
      Gegeven op '03-09-2026' een onderzoek is gestart naar 'de hele categorie verblijfplaats' van het verblijf op adres 'Beursstraat_44_Hengelo' van 'Jan'
      Als het onderzoek naar het verblijf op adres 'Beursstraat_44_Hengelo' van 'Jan' is beëindigd op '08-10-2026'
      Dan is een 'verblijfplaats-onderzoek-beeindigd' gebeurtenis gepubliceerd met de volgende data
      * het A-nummer 'Jan'
      * datum aanvang adreshouding '19-06-2026'
      * functie adres 'W'
      * adresseerbaar object identificatie van het actuele adres 'Beursstraat_44_Hengelo'
      * aanduiding gegevens in onderzoek 'datum aanvang adreshouding'
      * datum ingang onderzoek '03-09-2026'
      * datum einde onderzoek '08-10-2026'
