# language: nl
Functionaliteit: Gebeurtenis wanneer een onderzoek loopt naar de verblijfplaats en is vastgesteld dat de persoon niet meer op dit adres verblijft
  Dit is het geval wanneer de aanduiding van een lopend onderzoek wordt gewijzigd naar '089999'

  Achtergrond:
    Gegeven het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    * in gemeente 'Hengelo'
    En het adres 'Beursstraat_44_Hengelo'
    * in gemeente 'Hengelo'
    En de persoon 'Jan'
    * verblijft vanaf '14-04-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    * verblijft vanaf '14-06-2026' op het adres 'Beursstraat_44_Hengelo'

  Regel: Als is vastgesteld dat de persoon niet verblijft op het geregistreerde adres, heeft de gebeurtenis 'vastgesteld-verblijft-niet-op-adres' plaatsgevonden

    Scenario: Tijdens het onderzoek is vastgesteld dat de persoon niet verblijft op het adres
      Gegeven een onderzoek loopt naar het verblijf op het adres 'Beursstraat_44_Hengelo' van 'Jan'
      Als het onderzoek naar het verblijf op het adres 'Beursstraat_44_Hengelo' van 'Jan' is gewijzigd naar 'vastgesteld verblijft niet op adres'
      Dan is een 'vastgesteld-verblijft-niet-op-adres' gebeurtenis gepubliceerd

    Scenario: Bij de start van het onderzoek is al duidelijk dat de persoon niet verblijft op het adres
      Als is vastgesteld dat 'Jan' niet verblijft op het adres 'Beursstraat_44_Hengelo'
      Dan is een 'verblijfplaats-onderzoek-gestart' gebeurtenis gepubliceerd
      En is een 'vastgesteld-verblijft-niet-op-adres' gebeurtenis gepubliceerd
