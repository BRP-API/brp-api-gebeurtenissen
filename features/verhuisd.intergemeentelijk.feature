# language: nl
Functionaliteit: gepubliceerde gebeurtenis 'verhuisd.intergemeentelijk' bij een aangifte van adreswijziging naar een andere gemeente
  Als afdeling WGS Vroegsignalering van de gemeente wil ik het weten wanneer mijn client is verhuisd van mijn eigen gemeente naar een andere gemeente,
  zodat ik het dossier kan overdragen aan de nieuwe gemeente en het dossier kan sluiten.

  Achtergrond:
    Gegeven het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    * in gemeente 'Hengelo'
    * met adresseerbaar object identificatie '0164010000047847'
    En het adres 'Stadserf_1_Roosendaal'
    * in gemeente 'Roosendaal'
    * met adresseerbaar object identificatie '1674010000008508'

  Regel: Wanneer aangifte van adreswijziging is gedaan in een andere Nederlandse gemeente dan waar persoon verblijft, heeft de gebeurtenis 'verhuisd.intergemeentelijk' plaatsgevonden

    Scenario: Aangifte van adreswijziging naar een andere gemeente in Nederland
      Gegeven de persoon 'Jan'
      * verblijft vanaf '14-4-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
      Als de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2025' op het adres 'Stadserf_1_Roosendaal'
      Dan is een 'verhuisd.intergemeentelijk' gebeurtenis gepubliceerd
