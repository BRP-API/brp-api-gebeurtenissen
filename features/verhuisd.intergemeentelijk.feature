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
    En afnemer 'Roosendaal' is geabonneerd op 'verhuisd.intergemeentelijk' gebeurtenissen van de persoon 'Jan'

  @classificatie-service @mutatie-service
  Scenario: Aangifte van adreswijziging naar een andere gemeente in Nederland
    Gegeven de persoon 'Jan'
    * verblijft vanaf '14-4-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    Als de opgave van verhuizing van 'Jan' is verwerkt
    * verblijft vanaf '1-9-2025' op het adres 'Stadserf_1_Roosendaal'
    Dan is een 'verhuisd.intergemeentelijk' gebeurtenis gepubliceerd met de volgende data
    * het A-nummer van 'Jan'
    * de vanaf datum van de opgave van verhuizing van 'Jan'
    * de adresseerbaar object identificatie van het adres 'Stadserf_1_Roosendaal'

  @mutatie-service
  Scenario: Aangifte van adreswijziging naar een andere gemeente in Nederland
    Gegeven de persoon 'Jan'
    * verblijft vanaf '14-4-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    Als de opgave van verhuizing van 'Jan' is verwerkt
    * verblijft vanaf '1-9-2025' op het adres 'Stadserf_1_Roosendaal'
    Dan heeft tabel 'lo3_pl_verblijfplaats' de volgende rijen
      | pl_id | adres_id                                                  | volg_nr | gemeente van inschrijving (09.10) | datum inschrijving in de gemeente (09.20) | functie adres (10.10) | datum aanvang adreshouding (10.30) | aangifte adreshouding (72.10) | ingangsdatum geldigheid (85.10) |
      | Jan   | adres_id van 'Stadserf_1_Roosendaal'                      |       0 |                              1674 |                                  20250901 | W                     |                           20250901 | I                             |                        20250901 |
      | Jan   | adres_id van 'Burgemeester_Van_Der_Dussenplein_1_Hengelo' |       1 |                              0164 |                                  20200414 | W                     |                           20200414 | _                             |                        20200414 |

  @gebeurtenis-service
  Scenario: Aangifte van adreswijziging naar een andere gemeente in Nederland
    Gegeven de persoon 'Jan'
    * verblijft vanaf '14-4-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    En de opgave van verhuizing van 'Jan' is verwerkt
    * verblijft vanaf '1-9-2025' op het adres 'Stadserf_1_Roosendaal'
    Als een niet-gelezen gebeurtenis wordt gevraagd door afnemer 'Roosendaal'
    Dan wordt een 'verhuisd.intergemeentelijk' gebeurtenis geleverd met de volgende data
    * het burgerservicenummer van 'Jan'
    * de vanaf datum van de opgave van verhuizing van 'Jan'
    * de adresseerbaar object identificatie van het adres 'Stadserf_1_Roosendaal'
