# language: nl
Functionaliteit: Gebeurtenis wanneer een lopend onderzoek wordt gewijzigd

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

    Abstract Scenario: <omschrijving>
      Gegeven een onderzoek loopt naar '<betwijfelde gegevens oorspronkelijk>' van het verblijf op het adres 'Beursstraat_44_Hengelo' van 'Jan'
      Als het onderzoek naar het verblijf op het adres 'Beursstraat_44_Hengelo' van 'Jan' is gewijzigd naar '<betwijfelde gegevens na wijziging>'
      Dan is een 'verblijfplaats-onderzoek-gewijzigd' gebeurtenis gepubliceerd

      Voorbeelden:
        | omschrijving                   | betwijfelde gegevens oorspronkelijk | betwijfelde gegevens na wijziging |
        | Het onderzoek wordt uitgebreid | datum aanvang adreshouding          | de hele categorie verblijfplaats  |
        | Het onderzoek wordt beperkt    | de groep adres                      | datum aanvang adreshouding        |

  Regel: Als op een verblijfplaats voor de tweede keer een onderzoek is gestart, heeft geen gebeurtenis 'verblijfplaats-onderzoek-gewijzigd' plaatsgevonden

    Scenario: Een onderzoek was eerst afgerond en wordt nu opnieuw gestart met een ander betwijfeld gegeven
      Gegeven een onderzoek loopt naar 'de groep adres' van het verblijf op het adres 'Beursstraat_44_Hengelo' van 'Jan'
      En het onderzoek naar het verblijf op het adres 'Beursstraat_44_Hengelo' van 'Jan' is beëindigd
      Als een onderzoek is gestart naar 'datum aanvang adreshouding' van het verblijf op het adres 'Beursstraat_44_Hengelo' van 'Jan'
      Dan is geen 'verblijfplaats-onderzoek-gewijzigd' gebeurtenis gepubliceerd
