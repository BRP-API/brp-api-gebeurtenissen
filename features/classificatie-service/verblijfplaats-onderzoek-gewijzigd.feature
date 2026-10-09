# language: nl
Functionaliteit: Gebeurtenis wanneer een lopend onderzoek wordt gewijzigd
  In de gebeurtenis wordt de identificatie - het A-nummer - van de betreffende persoon in de data opgenomen.
  Daarnaast wordt ook de datum aanvang (van adreshouding of verblijf buitenland) van de verblijfplaats opgenomen. De datum wordt opgenomen, zodat de abonnee de gebeurtenis kan relateren aan een verblijf.

  Er wordt geen data meegestuurd waaruit af te leiden is wat gewijzigd is aan het onderzoek, omdat we niet weten voor welke gegevens de abonnee geautoriseerd is.
  De abonnee kan de actuele informatie over het onderzoek desgewenst ophalen in de BRP-API.

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

  Regel: Als een lopend onderzoek wordt gewijzigd, heeft de gebeurtenis 'verblijfplaats-onderzoek-gewijzigd' plaatsgevonden

    Abstract Scenario: Het onderzoek wordt <omschrijving>
      Gegeven een onderzoek loopt naar '<betwijfelde gegevens oorspronkelijk>' van het verblijf op het adres 'Beursstraat_44_Hengelo' van 'Jan'
      Als het onderzoek naar het verblijf op het adres 'Beursstraat_44_Hengelo' van 'Jan' is gewijzigd naar '<betwijfelde gegevens na wijziging>'
      Dan is een 'verblijfplaats-onderzoek-gewijzigd' gebeurtenis gepubliceerd

      Voorbeelden:
        | omschrijving | betwijfelde gegevens oorspronkelijk | betwijfelde gegevens na wijziging |
        | uitgebreid   | datum aanvang adreshouding          | de hele categorie verblijfplaats  |
        | beperkt      | de groep adreshouding               | datum aanvang adreshouding        |
        | gewijzigd    | datum aanvang adreshouding          | functie adres                     |

  Regel: Bij gebeurtenistype 'verblijfplaats-onderzoek-gewijzigd' wordt het A-nummer van de persoon meegeleverd plus de datum aanvang van het betreffende verblijf
    De datum aanvang waar hier op gedoeld wordt is de datum aanvang adreshouding, dan wel datum aanvang verblijf buitenland.

    Scenario: Onderzoek naar de verblijfplaats is beperkt
      Gegeven een onderzoek loopt naar 'de hele categorie verblijfplaats' van het verblijf op het adres 'Beursstraat_44_Hengelo' van 'Jan'
      Als het onderzoek naar het verblijf op het adres 'Beursstraat_44_Hengelo' van 'Jan' is gewijzigd naar 'datum aanvang adreshouding'
      Dan is een 'verblijfplaats-onderzoek-beeindigd' gebeurtenis gepubliceerd met de volgende data
      * het A-nummer 'Jan'
      * datum aanvang '14-06-2026'

  Regel: Als op een verblijfplaats voor de tweede keer een onderzoek is gestart, heeft geen gebeurtenis 'verblijfplaats-onderzoek-gewijzigd' plaatsgevonden

    Scenario: Een onderzoek was eerst afgerond en wordt nu opnieuw gestart met een ander betwijfeld gegeven
      Gegeven een onderzoek loopt naar 'de groep adres' van het verblijf op het adres 'Beursstraat_44_Hengelo' van 'Jan'
      En het onderzoek naar het verblijf op het adres 'Beursstraat_44_Hengelo' van 'Jan' is beëindigd
      Als een onderzoek is gestart naar 'datum aanvang adreshouding' van het verblijf op het adres 'Beursstraat_44_Hengelo' van 'Jan'
      Dan is geen 'verblijfplaats-onderzoek-gewijzigd' gebeurtenis gepubliceerd

  Regel: Als is vastgesteld dat de persoon niet verblijft op het geregistreerde adres, heeft geen gebeurtenis 'verblijfplaats-onderzoek-gewijzigd' plaatsgevonden

    Scenario: Tijdens het onderzoek is vastgesteld dat de persoon niet verblijft op het adres
      Gegeven een onderzoek loopt naar het verblijf op het adres 'Beursstraat_44_Hengelo' van 'Jan'
      Als het onderzoek naar het verblijf op het adres 'Beursstraat_44_Hengelo' van 'Jan' is gewijzigd naar 'vastgesteld verblijft niet op adres'
      Dan is geen 'verblijfplaats-onderzoek-gewijzigd' gebeurtenis gepubliceerd
