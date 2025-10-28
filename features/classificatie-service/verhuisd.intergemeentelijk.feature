# language: nl
@classificatie-service
Functionaliteit: gepubliceerde gebeurtenis 'verhuisd.intergemeentelijk' bij een aangifte van adreswijziging naar een andere gemeente
  De gebeurtenis 'verhuisd.intergemeentelijk' betekent dat de persoon fysiek verhuisd is van een Nederlandse gemeente 
  naar een andere Nederlandse gemeente.

  Achtergrond:
    Gegeven het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    * in gemeente 'Hengelo'
    * met adresseerbaar object identificatie '0164010000047847'
    En het adres 'Stadserf_1_Roosendaal'
    * in gemeente 'Roosendaal'
    * met adresseerbaar object identificatie '1674010000008508'
    En het adres 'Beursstraat_44_Hengelo'
    * in gemeente 'Hengelo'
    * met adresseerbaar object identificatie '0164010000002401'
    Gegeven de persoon 'Jan'
    En afnemer 'Roosendaal' is geabonneerd op 'verhuisd.intergemeentelijk' gebeurtenissen van de persoon 'Jan'

  Regel: Wanneer de persoon is ingeschreven in een andere Nederlandse gemeente heeft gebeurtenis 'verhuisd.intergemeentelijk' plaatsgevonden

    Scenario: Aangifte van adreswijziging naar een andere gemeente in Nederland
      Gegeven de persoon 'Jan'
      * verblijft vanaf '14-4-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
      Als de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2025' op het adres 'Stadserf_1_Roosendaal'
      Dan is een 'verhuisd.intergemeentelijk' gebeurtenis gepubliceerd met de volgende data
      * het A-nummer van 'Jan'
      * de vanaf datum van de aangifte van adreswijziging van 'Jan'
      * de adresseerbaar object identificatie van het adres 'Stadserf_1_Roosendaal'

    Scenario: Aangifte van adreswijziging naar een ander adres in dezelfde gemeente
      Gegeven de persoon 'Jan'
      * verblijft vanaf '14-4-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
      Als de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2025' op het adres 'Beursstraat_44_Hengelo'
      Dan is er geen 'verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor 'Jan'

    Scenario: Aangifte van verblijf en adres in Nederland (immigratie)
      Gegeven de persoon 'Jan'
      * verblijft vanaf '14-4-2020' op een adres in het buitenland
      * staat ingeschreven in het RNI
      Als de aangifte van verblijf en adres in Nederland van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2025' op het adres 'Beursstraat_44_Hengelo'
      Dan is er geen 'verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor 'Jan'

    Scenario: Aangifte van vertrek uit Nederland (emigratie)
      Gegeven de persoon 'Jan'
      * verblijft vanaf '14-4-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
      Als de aangifte van vertrek uit Nederland van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2025' op een adres in het buitenland
      Dan is er geen 'verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor 'Jan'

  Regel: Wanneer de functie van het adres wijzigt van woonadres naar een briefadres in een andere Nederlandse gemeente heeft gebeurtenis 'verhuisd.intergemeentelijk' plaatsgevonden

    Scenario: De persoon verhuist van een woonadres naar een briefadres in een andere gemeente
      Gegeven de persoon 'Jan'
      * verblijft vanaf '14-4-2020' op het woonadres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
      Als de aangifte van adreswijziging van 'Jan' is verwerkt
      * schrijft zich vanaf '1-9-2025' in op het briefadres 'Stadserf_1_Roosendaal'
      Dan is een 'verhuisd.intergemeentelijk' gebeurtenis gepubliceerd met de volgende data
      * het A-nummer van 'Jan'
      * de vanaf datum van de aangifte van adreswijziging van 'Jan'
      * de adresseerbaar object identificatie van het adres 'Stadserf_1_Roosendaal'

    Scenario: De persoon verhuist van een briefadres naar een woonadres in een andere gemeente
      Gegeven de persoon 'Jan'
      * staat vanaf '14-4-2020' op het briefadres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo' ingeschreven
      Als de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2025' op het woonadres 'Stadserf_1_Roosendaal'
      Dan is een 'verhuisd.intergemeentelijk' gebeurtenis gepubliceerd met de volgende data
      * het A-nummer van 'Jan'
      * de vanaf datum van de aangifte van adreswijziging van 'Jan'
      * de adresseerbaar object identificatie van het adres 'Stadserf_1_Roosendaal'

  Regel: Wanneer het adres wijzigt door een infrastructurele wijziging is er geen gebeurtenis 'verhuisd.intergemeentelijk'

    Scenario: De persoon woont nog in hetzelfde adresseerbaar object dat in een andere gemeente is komen te liggen
      Gegeven de persoon 'Jan'
      * verblijft vanaf '14-4-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
      En het adres 'Burgemeester_Van_Der_Dussenplein_1_Enschede'
      * in gemeente 'Enschede'
      * met adresseerbaar object identificatie '0164010000047847'
      Als de intergemeentelijke infrastructurele wijziging van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2025' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Enschede'
      Dan is er geen 'verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor 'Jan'

  Regel: Wanneer het adres wijzigt door een correctie op een eerder geregistreerde verblijfplaats is er geen gebeurtenis 'verhuisd.intergemeentelijk'

    Scenario: Het adres van de persoon wordt gecorrigeerd naar een adres in een andere gemeente
      Gegeven de persoon 'Jan'
      * verblijft vanaf '14-4-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
      Als de correctie op het adres van 'Jan' is verwerkt
      * het actuele adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo' is incorrect
      * verblijft vanaf '14-4-2020' op het adres 'Stadserf_1_Roosendaal'
      Dan is er geen 'verhuisd.intergemeentelijk' gebeurtenis gepubliceerd

    Scenario: Het adres van de persoon wordt gecorrigeerd want de persoon heeft nooit op het actuele adres gewoond
      Gegeven de persoon 'Jan'
      * verblijft vanaf '14-4-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
      En de opgave van verhuizing van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2025' op het adres 'Stadserf_1_Roosendaal'
      Als de correctie op het adres van 'Jan' is verwerkt
      * het actuele adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo' is incorrect
      * verblijft vanaf '14-4-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
      Dan is er geen 'verhuisd.intergemeentelijk' gebeurtenis gepubliceerd

    Scenario: Een eerder adres van de persoon wordt gecorrigeerd naar een adres in een andere gemeente
      Gegeven de persoon 'Jan'
      * verblijft vanaf '14-4-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
      En de opgave van verhuizing van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2025' op het adres 'Stadserf_1_Roosendaal'
      En het adres 'Hengelosestraat_51_Enschede'
      * in gemeente 'Enschede'
      * met adresseerbaar object identificatie '0153010000421499'
      Als de correctie op het adres van 'Jan' is verwerkt
      * het historische adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo' is incorrect
      * verblijft vanaf '14-4-2020' op het adres 'Hengelosestraat_51_Enschede'
      * verblijft vanaf '1-9-2025' op het adres 'Stadserf_1_Roosendaal'
      Dan is er geen 'verhuisd.intergemeentelijk' gebeurtenis gepubliceerd

    Scenario: Een eerder adres én het huidige adres van de persoon worden gecorrigeerd naar een adres in een andere gemeente dan het actuele adres
      Gegeven de persoon 'Jan'
      * verblijft vanaf '14-4-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
      En de opgave van verhuizing van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2025' op het adres 'Stadserf_1_Roosendaal'
      Als de correctie op het adres van 'Jan' is verwerkt
      * het historische adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo' is incorrect
      * het actuele adres 'Stadserf_1_Roosendaal' is incorrect
      * verblijft vanaf '14-4-2020' op het adres 'Beursstraat_44_Hengelo'
      Dan is er geen 'verhuisd.intergemeentelijk' gebeurtenis gepubliceerd

  Regel: Wanneer een onderzoek naar de verblijfplaats is gestart, gewijzigd of beëindigd is er geen gebeurtenis 'verhuisd.intergemeentelijk'

    Scenario: Een adresonderzoek is gestart
      Gegeven de persoon 'Jan'
      * verblijft vanaf '14-4-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
      Als een onderzoek op het verblijfadres van 'Jan' is op '1-9-2025' gestart
      Dan is er geen 'verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor 'Jan'

    Scenario: Een adresonderzoek is afgerond zonder wijziging van het adres
      Gegeven de persoon 'Jan'
      * verblijft vanaf '14-4-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
      En een onderzoek op het verblijfadres van 'Jan' is op '1-9-2025' gestart
      Als het onderzoek op het verblijfadres is beëindigd
      Dan is er geen 'verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor 'Jan'

    Scenario: Bij een adresonderzoek is vastgesteld dat de persoon niet meer op het adres verblijft
      Gegeven de persoon 'Jan'
      * verblijft vanaf '14-4-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
      En een onderzoek op het verblijfadres van 'Jan' is op '1-9-2025' gestart
      Als in het onderzoek op het verblijfadres is vastgesteld verblijft niet op adres
      Dan is er geen 'verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor 'Jan'
