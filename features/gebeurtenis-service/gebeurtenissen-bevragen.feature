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
    * is geregistreerd als abonnee 'SZW' van BRP API Gebeurtenissen
    * is geregistreerd als abonnee 'JZ' van BRP API Gebeurtenissen
    * is geregistreerd als abonnee 'Belastingen' van BRP API Gebeurtenissen
    Gegeven het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    * in gemeente 'Hengelo'
    * met adresseerbaar object identificatie '0164010000047847'
    En het adres 'Stadserf_1_Roosendaal'
    * in gemeente 'Roosendaal'
    * met adresseerbaar object identificatie '1674010000008508'
    Gegeven de persoon 'Jan'
    * verblijft vanaf '14-4-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    En de persoon 'Piet'
    * verblijft vanaf '14-4-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    En abonnee 'SZW' is geabonneerd op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
    En abonnee 'SZW' is geabonneerd op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Piet'
    En abonnee 'JZ' is geabonneerd op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'

  Regel: Een abonnee kan niet-gelezen gebeurtenissen waarop hij is geabonneerd chronologisch bevragen

    Scenario: De abonnee heeft nog geen gebeurtenissen gevraagd
      Gegeven de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2025' op het adres 'Stadserf_1_Roosendaal'
      Als een niet-gelezen gebeurtenis wordt gevraagd door abonnee 'SZW'
      Dan is een 'verhuisd.intergemeentelijk' gebeurtenis gepubliceerd met de volgende data
      * het burgerservicenummer van 'Jan'
      * de vanaf datum van de opgave van verhuizing van 'Jan'

    Scenario: De abonnee vraagt ongelezen gebeurtenissen en er zijn meerdere gebeurtenissen
      Gegeven de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2025' op het adres 'Stadserf_1_Roosendaal'
      En de aangifte van adreswijziging van 'Piet' is verwerkt
      * verblijft vanaf '2-9-2025' op het adres 'Stadserf_1_Roosendaal'
      Als een niet-gelezen gebeurtenis wordt gevraagd door abonnee 'SZW'
      Dan is een 'verhuisd.intergemeentelijk' gebeurtenis gepubliceerd met de volgende data
      * het burgerservicenummer van 'Jan'
      * de vanaf datum van de opgave van verhuizing van 'Jan'

    Scenario: De abonnee vraagt ongelezen gebeurtenissen, er zijn meerdere gebeurtenissen en de eerste gebeurtenis is al gelezen
      Gegeven de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2025' op het adres 'Stadserf_1_Roosendaal'
      En de aangifte van adreswijziging van 'Piet' is verwerkt
      * verblijft vanaf '2-9-2025' op het adres 'Stadserf_1_Roosendaal'
      En een niet-gelezen gebeurtenis is gevraagd door abonnee 'SZW'
      Als een niet-gelezen gebeurtenis wordt gevraagd door abonnee 'SZW'
      Dan is een 'verhuisd.intergemeentelijk' gebeurtenis gepubliceerd met de volgende data
      * het burgerservicenummer van 'Piet'
      * de vanaf datum van de opgave van verhuizing van 'Piet'

    Scenario: De abonnee heeft alle niet-gelezen gebeurtenissen al gevraagd en nog niet met een andere abonnee van dezelfde afnemer
      Gegeven de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2025' op het adres 'Stadserf_1_Roosendaal'
      En alle niet-gelezen gebeurtenissen zijn gevraagd door abonnee 'SZW'
      Als een niet-gelezen gebeurtenis wordt gevraagd door abonnee 'SZW'
      Dan wordt er geen gebeurtenis geleverd

    Scenario: De abonnee vraagt ongelezen gebeurtenissen en heeft alle niet-gelezen gebeurtenissen al gevraagd met een andere abonnee van dezelfde afnemer
      Gegeven de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2025' op het adres 'Stadserf_1_Roosendaal'
      En alle niet-gelezen gebeurtenissen zijn gevraagd door abonnee 'SZW'
      Als een niet-gelezen gebeurtenis wordt gevraagd door abonnee 'JZ'
      Dan is een 'verhuisd.intergemeentelijk' gebeurtenis gepubliceerd met de volgende data
      * het burgerservicenummer van 'Jan'
      * de vanaf datum van de opgave van verhuizing van 'Jan'

    Scenario: De abonnee vraagt ongelezen gebeurtenissen en een andere abonnee van dezelfde afnemer is geabonneerd op de gebeurtenis
      Gegeven de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2025' op het adres 'Stadserf_1_Roosendaal'
      Als een niet-gelezen gebeurtenis wordt gevraagd door abonnee 'Belastingen'
      Dan wordt er geen gebeurtenis geleverd

  Regel: Een afnemer kan alleen niet-gelezen gebeurtenissen bevragen met een abonnee die al geregistreerd is

    Scenario: Afnemer is geabonneerd op een gebeurtenis voor een abonnee en vraagt ongelezen gebeurtenissen met een niet-geregistreerde abonnee
      Gegeven de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2025' op het adres 'Stadserf_1_Roosendaal'
      Als een niet-gelezen gebeurtenis wordt gevraagd door abonnee 'WMO'
      Dan is de response '403 Forbidden' met de volgende velden
      * heeft het detail veld de tekst 'Uw verzoek kan niet worden uitgevoerd omdat u niet als abonnee geregistreerd bent.'

    Scenario: Afnemer is geabonneerd op een gebeurtenis voor een abonnee en vraagt ongelezen gebeurtenissen zonder de abonnee op te geven
      Gegeven de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2025' op het adres 'Stadserf_1_Roosendaal'
      Als een niet-gelezen gebeurtenis wordt gevraagd door afnemer 'Hengelo'
      Dan is de response '400 Bad Request' met de volgende velden
      * 'detail' met tekst 'De foutieve parameter(s) zijn: abonnee.'
      * een 'invalidParams' met de volgende gegevens
        | code     | name    | reason                  |
        | required | abonnee | Parameter is verplicht. |

  Regel: Een abonnee kan alle gebeurtenissen als niet-gelezen markeren

    Scenario: De abonnee heeft alle niet-gelezen gebeurtenissen gevraagd en markeert alle gebeurtenissen als niet-gelezen
      Gegeven de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2025' op het adres 'Stadserf_1_Roosendaal'
      En alle niet-gelezen gebeurtenissen zijn gevraagd door abonnee 'SZW'
      En abonnee 'SZW' markeert al zijn gebeurtenissen als niet-gelezen
      Als een niet-gelezen gebeurtenis wordt gevraagd door abonnee 'SZW'
      Dan is een 'verhuisd.intergemeentelijk' gebeurtenis gepubliceerd met de volgende data
      * het burgerservicenummer van 'Jan'
      * de vanaf datum van de opgave van verhuizing van 'Jan'

    Scenario: De abonnee heeft alle niet-gelezen gebeurtenissen gevraagd en een andere abonnee van dezelfde afnemer markeert alle gebeurtenissen als niet-gelezen
      Gegeven de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2025' op het adres 'Stadserf_1_Roosendaal'
      En alle niet-gelezen gebeurtenissen zijn gevraagd door abonnee 'SZW'
      En alle niet-gelezen gebeurtenissen zijn gevraagd door abonnee 'JZ'
      En abonnee 'JZ' markeert al zijn gebeurtenissen als niet-gelezen
      Als een niet-gelezen gebeurtenis wordt gevraagd door abonnee 'SZW'
      Dan wordt er geen gebeurtenis geleverd
