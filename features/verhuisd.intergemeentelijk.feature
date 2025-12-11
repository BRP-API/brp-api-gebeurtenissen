# language: nl
Functionaliteit: gepubliceerde gebeurtenis 'verhuisd.intergemeentelijk' bij een aangifte van adreswijziging naar een andere gemeente
  Als afdeling Begraven van de gemeente wil ik het weten wanneer een gevolgde persoon verhuisd is,
  zodat ik batchgewijs automatische betalingen kan verwerken zonder het hele bestand in één keer te verversen.

  Als afdeling Parkeerbelasting van de gemeente wil ik het weten wanneer een gevolgde persoon verhuisd is,
  zodat ik de invordering naar het juiste adres kan sturen en het weet wanneer een persoon vertrokken is.
 
  Als afdeling WGS Vroegsignalering van de gemeente wil ik het weten wanneer een gevolgde persoon verhuisd is naar een andere gemeente,
  zodat ik het dossier kan overdragen naar de nieuwe gemeente en het dossier kan sluiten.

  Achtergrond:
    Gegeven het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    * in gemeente 'Hengelo'
    * met adresseerbaar object identificatie '0164010000047847'
    En het adres 'Stadserf_1_Roosendaal'
    * in gemeente 'Roosendaal'
    * met adresseerbaar object identificatie '1674010000008508'
    Gegeven de persoon 'Jan'
    * verblijft vanaf '14-4-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    En afnemer 'Roosendaal' is geabonneerd op 'verhuisd.intergemeentelijk' gebeurtenissen van de persoon 'Jan'

  @classificatie-service @mutatie-service
  Scenario: Aangifte van adreswijziging naar een andere gemeente in Nederland
    Als de aangifte van adreswijziging van 'Jan' is verwerkt
    * verblijft vanaf '1-9-2025' op het adres 'Stadserf_1_Roosendaal'
    Dan is een 'verhuisd.intergemeentelijk' gebeurtenis gepubliceerd met de volgende data
    * het A-nummer van 'Jan'
    * de vanaf datum van de opgave van verhuizing van 'Jan'
    * de adresseerbaar object identificatie van het adres 'Stadserf_1_Roosendaal'

  Scenario: Aangifte van adreswijziging naar een briefadres in andere gemeente in Nederland
    Als de aangifte van adreswijziging van 'Jan' is verwerkt
    * heeft vanaf '1-9-2025' het briefadres 'Stadserf_1_Roosendaal'
    Dan is een 'verhuisd.intergemeentelijk' gebeurtenis gepubliceerd met de volgende data
    * het A-nummer van 'Jan'
    * de vanaf datum van de opgave van verhuizing van 'Jan'
    * de adresseerbaar object identificatie van het adres 'Stadserf_1_Roosendaal'

  @gebeurtenis-service
  Scenario: Aangifte van adreswijziging naar een andere gemeente in Nederland
    Gegeven de aangifte van adreswijziging van 'Jan' is verwerkt
    * verblijft vanaf '1-9-2025' op het adres 'Stadserf_1_Roosendaal'
    Als een ongelezen gebeurtenis wordt gevraagd door afnemer 'Roosendaal'
    Dan wordt een 'verhuisd.intergemeentelijk' gebeurtenis geleverd met de volgende data
    * het burgerservicenummer van 'Jan'
    * de vanaf datum van de opgave van verhuizing van 'Jan'
    * de adresseerbaar object identificatie van het adres 'Stadserf_1_Roosendaal'
