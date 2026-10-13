# language: nl
Functionaliteit: Gebeurtenis wanneer een lopend onderzoek wordt gewijzigd
  Als abonnee wil ik weten dat een onderzoek naar de verblijfplaats is gewijzigd,
  zodat ik een onderzoek kan starten naar de consequenties van dit onderzoek op mijn dienstverlening.

  In de gebeurtenis wordt de identificatie - het A-nummer - van de betreffende persoon en het onderzoek in de data opgenomen.
  Daarnaast worden enkele gegevens van de verblijfplaats opgenomen:
  - datum aanvang adreshouding dan wel datum aanvang verblijf buitenland
  - adresseerbaar object identificatie van het adres
  - functie adres

  Aan de abonnee wordt van de verblijfplaats alleen de datum aanvang van adreshouding of verblijf buitenland opgenomen.
  De datum aanvang wordt geleverd, zodat de abonnee de gebeurtenis kan relateren aan een verblijf.
  Aan de abonnee wordt geen data geleverd waaruit af te leiden is waar het onderzoek over gaat, omdat we niet weten voor welke gegevens de abonnee geautoriseerd is.
  De abonnee kan de actuele informatie over het onderzoek desgewenst ophalen in de BRP-API.

  Achtergrond:
    Gegeven het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    * in gemeente 'Hengelo'
    En het adres 'Beursstraat_44_Hengelo'
    * in gemeente 'Hengelo'
    En de persoon 'Jan'
    * verblijft vanaf '14-04-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    * verblijft vanaf '19-06-2026' op het adres 'Beursstraat_44_Hengelo'
    Gegeven het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    * in gemeente 'Hengelo'
    En het adres 'Beursstraat_44_Hengelo'
    * in gemeente 'Hengelo'
    En de persoon 'Jan'
    * verblijft vanaf '14-04-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    * verblijft vanaf '19-06-2026' op het adres 'Beursstraat_44_Hengelo'

  Regel: Als een lopend onderzoek wordt gewijzigd, heeft de gebeurtenis 'verblijfplaats-onderzoek-gewijzigd' plaatsgevonden

    Abstract Scenario: Het onderzoek wordt <omschrijving>
      Gegeven een onderzoek loopt naar '<betwijfelde gegevens oorspronkelijk>' van het verblijf op adres 'Beursstraat_44_Hengelo' van 'Jan'
      Als het onderzoek naar het verblijf op adres 'Beursstraat_44_Hengelo' van 'Jan' is gewijzigd naar '<betwijfelde gegevens na wijziging>'
      Dan is een 'verblijfplaats-onderzoek-gewijzigd' gebeurtenis gepubliceerd

      Voorbeelden:
        | omschrijving | betwijfelde gegevens oorspronkelijk | betwijfelde gegevens na wijziging |
        | uitgebreid   | datum aanvang adreshouding          | de hele categorie verblijfplaats  |
        | beperkt      | de groep adreshouding               | datum aanvang adreshouding        |
        | gewijzigd    | datum aanvang adreshouding          | functie adres                     |

  Regel: Bij gebeurtenistype 'verblijfplaats-onderzoek-gewijzigd' wordt het A-nummer van de persoon meegeleverd en gegevens over het onderzoek en het betreffende verblijf
    Van de verblijfplaats worden alleen de volgende gegevens geleverd:
    - functie adres
    - datum aanvang adreshouding dan wel datum aanvang verblijf buitenland
    - adresseerbaar object identificatie van het adres

    De gebeurtenis bevat gegevens over het onderzoek zoals ze geldig zijn na de wijziging.

    Scenario: Onderzoek naar de verblijfplaats is beperkt
      Gegeven op '03-09-2026' is een onderzoek gestart naar 'de hele categorie verblijfplaats' van het verblijf op adres 'Beursstraat_44_Hengelo' van 'Jan'
      Als op '23-09-2026' het onderzoek naar het verblijf op adres 'Beursstraat_44_Hengelo' van 'Jan' is gewijzigd naar 'datum aanvang adreshouding'
      Dan is een 'verblijfplaats-onderzoek-beeindigd' gebeurtenis gepubliceerd met de volgende data
      * het A-nummer 'Jan'
      * datum aanvang adreshouding '19-06-2026'
      * functie adres 'W'
      * adresseerbaar object identificatie van het actuele adres 'Beursstraat_44_Hengelo'
      * aanduiding gegevens in onderzoek 'datum aanvang adreshouding'
      * datum ingang onderzoek '03-09-2026'

  Regel: Als op een verblijfplaats voor de tweede keer een onderzoek is gestart, heeft geen gebeurtenis 'verblijfplaats-onderzoek-gewijzigd' plaatsgevonden

    Scenario: Een onderzoek was eerst afgerond en wordt nu opnieuw gestart met een ander betwijfeld gegeven
      Gegeven een onderzoek loopt naar 'de groep adres' van het verblijf op adres 'Beursstraat_44_Hengelo' van 'Jan'
      En het onderzoek naar het verblijf op adres 'Beursstraat_44_Hengelo' van 'Jan' is beëindigd
      Als een onderzoek is gestart naar 'datum aanvang adreshouding' van het verblijf op adres 'Beursstraat_44_Hengelo' van 'Jan'
      Dan is geen 'verblijfplaats-onderzoek-gewijzigd' gebeurtenis gepubliceerd

  Regel: Als is vastgesteld dat de persoon niet verblijft op het geregistreerde adres, heeft geen gebeurtenis 'verblijfplaats-onderzoek-gewijzigd' plaatsgevonden

    Scenario: Tijdens het onderzoek is vastgesteld dat de persoon niet verblijft op het adres
      Gegeven een onderzoek loopt naar het verblijf op adres 'Beursstraat_44_Hengelo' van 'Jan'
      Als het onderzoek naar het verblijf op adres 'Beursstraat_44_Hengelo' van 'Jan' is gewijzigd naar 'vastgesteld verblijft niet op adres'
      Dan is geen 'verblijfplaats-onderzoek-gewijzigd' gebeurtenis gepubliceerd
