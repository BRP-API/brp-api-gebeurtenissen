# language: nl
Functionaliteit: Gebeurtenissen bevragen
  Als consumer van BRP Gebeurtenissen
  wil ik niet-gelezen gebeurtenissen chronologisch kunnen bevragen
  zodat ik asynchroon de gebeurtenissen waarop ik ben geabonneerd kan verwerken

  Als consumer van BRP Gebeurtenissen
  wil ik gebeurtenissen als niet-gelezen kunnen markeren
  zodat ik de gebeurtenissen opnieuw kan verwerken

  Als gemeente 
  wil ik dat mijn interne afnemers zelf eigen abonnementen kunnen hebben en niet-gelezen eigen gebeurtenissen kunnen opvragen
  zodat ik niet zelf een distributiesysteem hoef te ontwikkelen/inkopen dat binnenkomende gebeurtenissen verdeelt onder mijn interne afnemers

  Achtergrond:
    Gegeven de afnemer 'Hengelo'
    * is geregistreerd als abonnee van BRP API Gebeurtenissen met rol 'SZW'
    * is geregistreerd als abonnee van BRP API Gebeurtenissen met rol 'JZ'
    * is geregistreerd als abonnee van BRP API Gebeurtenissen met rol 'Belastingen'
    Gegeven het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    * in gemeente 'Hengelo'
    * met adresseerbaar object identificatie '0164010000047847'
    En het adres 'Stadserf_1_Roosendaal'
    * in gemeente 'Roosendaal'
    * met adresseerbaar object identificatie '1674010000008508'
    Gegeven de persoon 'Jan'
    * verblijft vanaf '14-4-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    En afnemer 'Hengelo' met de rol 'SZW' is geabonneerd op 'verhuisd.intergemeentelijk' gebeurtenissen van de persoon 'Jan'
    En afnemer 'Hengelo' met de rol 'JZ' is geabonneerd op 'verhuisd.intergemeentelijk' gebeurtenissen van de persoon 'Jan'

  Regel: Een afnemer kan niet-gelezen gebeurtenissen waarop hij is geabonneerd chronologisch bevragen

    Scenario: Afnemer heeft nog geen gebeurtenissen gevraagd
      Gegeven de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2025' op het adres 'Stadserf_1_Roosendaal'
      Als een niet-gelezen gebeurtenis wordt gevraagd door afnemer 'Hengelo' met rol 'SZW'
      Dan is een 'verhuisd.intergemeentelijk' gebeurtenis gepubliceerd met de volgende data
      * het A-nummer van 'Jan'
      * de vanaf datum van de opgave van verhuizing van 'Jan'
      * de adresseerbaar object identificatie van het adres 'Stadserf_1_Roosendaal'

    Scenario: Afnemer heeft alle niet-gelezen gebeurtenissen al gevraagd met deze rol en nog niet met een andere rol
      Gegeven de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2025' op het adres 'Stadserf_1_Roosendaal'
      En alle niet-gelezen gebeurtenissen zijn gevraagd door afnemer 'Hengelo' met rol 'SZW'
      Als een niet-gelezen gebeurtenis wordt gevraagd door afnemer 'Hengelo' met rol 'SZW'
      Dan wordt er geen gebeurtenis geleverd

    Scenario: Afnemer heeft alle niet-gelezen gebeurtenissen al gevraagd met een rol en vraagt ongelezen gebeurtenissen met een andere rol
      Gegeven de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2025' op het adres 'Stadserf_1_Roosendaal'
      En alle niet-gelezen gebeurtenissen zijn gevraagd door afnemer 'Hengelo' met rol 'SZW'
      Als een niet-gelezen gebeurtenis wordt gevraagd door afnemer 'Hengelo' met rol 'JZ'
      Dan is een 'verhuisd.intergemeentelijk' gebeurtenis gepubliceerd met de volgende data
      * het A-nummer van 'Jan'
      * de vanaf datum van de opgave van verhuizing van 'Jan'
      * de adresseerbaar object identificatie van het adres 'Stadserf_1_Roosendaal'

    Scenario: Afnemer is geabonneerd op een gebeurtenis voor een rol en vraagt ongelezen gebeurtenissen met een andere rol
      Gegeven de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2025' op het adres 'Stadserf_1_Roosendaal'
      Als een niet-gelezen gebeurtenis wordt gevraagd door afnemer 'Hengelo' met rol 'Belastingen'
      Dan wordt er geen gebeurtenis geleverd

  Regel: Een afnemer kan alleen niet-gelezen gebeurtenissen bevragen met een rol die als abonnee geregistreerd is

    Scenario: Afnemer is geabonneerd op een gebeurtenis voor een rol en vraagt ongelezen gebeurtenissen met een niet-geregistreerde rol
      Gegeven de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2025' op het adres 'Stadserf_1_Roosendaal'
      Als een niet-gelezen gebeurtenis wordt gevraagd door afnemer 'Hengelo' met rol 'WMO'
      En is de response '403 Forbidden'
      * heeft het detail veld de tekst 'Uw verzoek kan niet worden uitgevoerd omdat u niet als abonnee geregistreerd bent.'

    Scenario: Afnemer is geabonneerd op een gebeurtenis voor een rol en vraagt ongelezen gebeurtenissen zonder een rol op te geven
      Gegeven de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2025' op het adres 'Stadserf_1_Roosendaal'
      Als een niet-gelezen gebeurtenis wordt gevraagd door afnemer 'Hengelo'
      En is de response '403 Forbidden'
      * heeft het detail veld de tekst 'Uw verzoek kan niet worden uitgevoerd omdat u niet als abonnee geregistreerd bent.'

  Regel: Een afnemer kan alle gebeurtenissen als niet-gelezen markeren

    Scenario: Afnemer heeft alle niet-gelezen gebeurtenissen gevraagd en markeert alle gebeurtenissen als niet-gelezen
      Gegeven de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2025' op het adres 'Stadserf_1_Roosendaal'
      En alle niet-gelezen gebeurtenissen zijn gevraagd door afnemer 'Hengelo' met rol 'SZW'
      En afnemer 'Hengelo' met rol 'SZW' markeert al zijn gebeurtenissen als niet-gelezen
      Als een niet-gelezen gebeurtenis wordt gevraagd door afnemer 'Hengelo' met rol 'SZW'
      Dan is een 'verhuisd.intergemeentelijk' gebeurtenis gepubliceerd met de volgende data
      * het A-nummer van 'Jan'
      * de vanaf datum van de opgave van verhuizing van 'Jan'
      * de adresseerbaar object identificatie van het adres 'Stadserf_1_Roosendaal'

    Scenario: Afnemer met een rol heeft alle niet-gelezen gebeurtenissen gevraagd en dezelfde afnemer met een andere rol markeert alle gebeurtenissen als niet-gelezen
      Gegeven de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2025' op het adres 'Stadserf_1_Roosendaal'
      En alle niet-gelezen gebeurtenissen zijn gevraagd door afnemer 'Hengelo' met rol 'SZW'
      En alle niet-gelezen gebeurtenissen zijn gevraagd door afnemer 'Hengelo' met rol 'JZ'
      En afnemer 'Hengelo' met rol 'JZ' markeert al zijn gebeurtenissen als niet-gelezen
      Als een niet-gelezen gebeurtenis wordt gevraagd door afnemer 'Hengelo' met rol 'SZW'
      Dan wordt er geen gebeurtenis geleverd
