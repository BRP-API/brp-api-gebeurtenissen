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

  Regel: Wanneer de persoon is ingeschreven in een andere Nederlandse gemeente, heeft gebeurtenis 'verhuisd.intergemeentelijk' plaatsgevonden

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

  Regel: Wanneer de functie van het adres wijzigt van woonadres naar een briefadres in een andere Nederlandse gemeente, heeft gebeurtenis 'verhuisd.intergemeentelijk' plaatsgevonden

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

  Regel: Wanneer het adres wijzigt door een infrastructurele wijziging, is er geen gebeurtenis 'verhuisd.intergemeentelijk'

    Scenario: De persoon woont nog in hetzelfde adresseerbaar object dat in een andere gemeente is komen te liggen
      Gegeven de persoon 'Jan'
      * verblijft vanaf '14-4-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
      En het adres 'Burgemeester_Van_Der_Dussenplein_1_Enschede'
      * in gemeente 'Enschede'
      * met adresseerbaar object identificatie '0164010000047847'
      Als de intergemeentelijke infrastructurele wijziging van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2025' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Enschede'
      Dan is er geen 'verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor 'Jan'

 
  Regel: Wanneer een verhuizing niet naar een correct vastgelegd BAG adresseerbaar object gaat, is er geen gebeurtenis 'verhuisd.intergemeentelijk'

    Scenario: De persoon verhuist naar een adres met locatiebeschrijving
      Gegeven de persoon 'Jan'
      * verblijft vanaf '14-4-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
      En het adres 'Locatie_De_Brug_Apeldoorn'
      * in gemeente 'Apeldoorn'
      * met locatiebeschrijving 'De Brug'
      Als de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2025' op het adres 'Locatie_De_Brug_Apeldoorn'
      Dan is er geen 'verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor 'Jan'

    Scenario: De persoon verhuist naar een adres zonder adresseerbaar object identificatie
      Gegeven de persoon 'Jan'
      * verblijft vanaf '14-4-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
      En het adres 'Laan_van_Westenenk_701_Apeldoorn'
      * in gemeente 'Apeldoorn'
      * met straat 'Laan van Westenenk', huisnummer 701 en postcode '7334DP'
      Als de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2025' op het adres 'Laan_van_Westenenk_701_Apeldoorn'
      Dan is er geen 'verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor 'Jan'

    Scenario: De persoon verhuist naar een adres met een onjuist opgevoerde adresserbaar object identificatie met 15 cijfers
      Gegeven de persoon 'Jan'
      * verblijft vanaf '14-4-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
      En het adres 'Laan_van_Westenenk_701_Apeldoorn'
      * in gemeente 'Apeldoorn'
      * met straat 'Laan van Westenenk', huisnummer 701 en postcode '7334DP'
      * met adresseerbaar object identificatie '200010000130331'
      Als de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2025' op het adres 'Laan_van_Westenenk_701_Apeldoorn'
      Dan is er geen 'verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor 'Jan'

    Scenario: De persoon verhuist naar een adres met adresserbaar object identificatie en aanduiding bij huisnummer
      Gegeven de persoon 'Jan'
      * verblijft vanaf '14-4-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
      En het adres 'Tegenover_Laan_van_Westenenk_701_Apeldoorn'
      * in gemeente 'Apeldoorn'
      * met adresseerbaar object identificatie '0200010000130331'
      * met aanduiding bij huisnummer 'tegenover'
      Als de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2025' op het adres 'Tegenover_Laan_van_Westenenk_701_Apeldoorn'
      Dan is er geen 'verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor 'Jan'
