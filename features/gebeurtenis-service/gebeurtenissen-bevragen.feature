# language: nl
Functionaliteit: Gebeurtenissen bevragen
  Als consumer van BRP Gebeurtenissen
  wil ik niet-gelezen gebeurtenissen chronologisch kunnen bevragen
  zodat ik asynchroon de gebeurtenissen waarop ik ben geabonneerd kan verwerken

  Als gemeente 
  wil ik dat mijn interne afnemers zelf eigen abonnementen kunnen hebben en niet-gelezen eigen gebeurtenissen kunnen opvragen
  zodat ik niet zelf een distributiesysteem hoef te ontwikkelen/inkopen dat binnenkomende gebeurtenissen verdeelt onder mijn interne afnemers

  Achtergrond:
    Gegeven de afnemer 'Hengelo' heeft abonnee 'SZW' geregistreerd
    En de afnemer 'Hengelo' heeft abonnee 'JZ' geregistreerd
    En het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    * in gemeente 'Hengelo'
    * met adresseerbaar object identificatie '0164010000047847'
    En het adres 'Stadserf_1_Roosendaal'
    * in gemeente 'Roosendaal'
    * met adresseerbaar object identificatie '1674010000008508'
    Gegeven de persoon 'Jan'
    * verblijft vanaf '14-4-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    En de persoon 'Piet'
    * verblijft vanaf '14-4-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'

  Regel: Een abonnee ontvangt steeds de oudste niet-gelezen gebeurtenis

    Scenario: De abonnee heeft nog geen gebeurtenissen gevraagd
      Gegeven abonnee 'SZW' is geabonneerd op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      En de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2025' op het adres 'Stadserf_1_Roosendaal'
      Als een niet-gelezen gebeurtenis wordt gevraagd door abonnee 'SZW'
      Dan wordt een 'verhuisd.intergemeentelijk' gebeurtenis geleverd met de volgende data
      * het burgerservicenummer van 'Jan'
      * de vanaf datum van de opgave van verhuizing van 'Jan'

    Scenario: De abonnee vraagt ongelezen gebeurtenissen en er zijn meerdere gebeurtenissen
      Gegeven abonnee 'SZW' is geabonneerd op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      En abonnee 'SZW' is geabonneerd op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Piet'
      En de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2025' op het adres 'Stadserf_1_Roosendaal'
      En de aangifte van adreswijziging van 'Piet' is verwerkt
      * verblijft vanaf '2-9-2025' op het adres 'Stadserf_1_Roosendaal'
      Als een niet-gelezen gebeurtenis wordt gevraagd door abonnee 'SZW'
      Dan wordt een 'verhuisd.intergemeentelijk' gebeurtenis geleverd met de volgende data
      * het burgerservicenummer van 'Jan'
      * de vanaf datum van de opgave van verhuizing van 'Jan'

    Scenario: De abonnee vraagt ongelezen gebeurtenissen, er zijn meerdere gebeurtenissen en de eerste gebeurtenis is al gelezen
      Gegeven abonnee 'SZW' is geabonneerd op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      En abonnee 'SZW' is geabonneerd op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Piet'
      En de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2025' op het adres 'Stadserf_1_Roosendaal'
      En de aangifte van adreswijziging van 'Piet' is verwerkt
      * verblijft vanaf '2-9-2025' op het adres 'Stadserf_1_Roosendaal'
      En een niet-gelezen gebeurtenis is gevraagd door abonnee 'SZW'
      Als een niet-gelezen gebeurtenis wordt gevraagd door abonnee 'SZW'
      Dan wordt een 'verhuisd.intergemeentelijk' gebeurtenis geleverd met de volgende data
      * het burgerservicenummer van 'Piet'
      * de vanaf datum van de opgave van verhuizing van 'Piet'

  Regel: Als er voor de abonnee geen niet-gelezen gebeurtenissen zijn, krijgt hij een leeg antwoord

    Scenario: De abonnee heeft alle niet-gelezen gebeurtenissen al gevraagd
      Gegeven abonnee 'SZW' is geabonneerd op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      En de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2025' op het adres 'Stadserf_1_Roosendaal'
      En alle niet-gelezen gebeurtenissen zijn gevraagd door abonnee 'SZW'
      Als een niet-gelezen gebeurtenis wordt gevraagd door abonnee 'SZW'
      Dan wordt er geen gebeurtenis geleverd

  Regel: Een abonnee krijgt alleen gebeurtenissen waarop hij geabonneerd is
    De abonnee krijgt alleen een gebeurtenis wanneer hij een abonnement heeft op het type gebeurtenis voor de persoon waarop de gebeurtenis heeft plaatsgevonden

    Scenario: De abonnee vraagt ongelezen gebeurtenissen en is niet geabonneerd op de gebeurtenis
      Gegeven de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2025' op het adres 'Stadserf_1_Roosendaal'
      Als een niet-gelezen gebeurtenis wordt gevraagd door abonnee 'SZW'
      Dan wordt er geen gebeurtenis geleverd

    Scenario: De abonnee vraagt ongelezen gebeurtenissen en een is geabonneerd op het gebeurtenistype voor een andere persoon
      Gegeven abonnee 'SZW' is geabonneerd op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Piet'
      En de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2025' op het adres 'Stadserf_1_Roosendaal'
      Als een niet-gelezen gebeurtenis wordt gevraagd door abonnee 'SZW'
      Dan wordt er geen gebeurtenis geleverd

    Scenario: De abonnee vraagt ongelezen gebeurtenissen en een is geabonneerd op een ander gebeurtenistype voor de persoon
      Gegeven abonnee 'SZW' is geabonneerd op de 'verhuisd.naar-buitenland' gebeurtenissen van 'Jan'
      En de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2025' op het adres 'Stadserf_1_Roosendaal'
      Als een niet-gelezen gebeurtenis wordt gevraagd door abonnee 'SZW'
      Dan wordt er geen gebeurtenis geleverd

  Regel: Meerdere abonnees kunnen dezelfde gebeurtenis ontvangen

    Scenario: De abonnee vraagt ongelezen gebeurtenissen en een andere abonnee heeft de gebeurtenis al gevraagd
      Gegeven abonnee 'SZW' is geabonneerd op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      En abonnee 'JZ' is geabonneerd op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      En de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2025' op het adres 'Stadserf_1_Roosendaal'
      En alle niet-gelezen gebeurtenissen zijn gevraagd door abonnee 'SZW'
      Als een niet-gelezen gebeurtenis wordt gevraagd door abonnee 'JZ'
      Dan wordt een 'verhuisd.intergemeentelijk' gebeurtenis geleverd met de volgende data
      * het burgerservicenummer van 'Jan'
      * de vanaf datum van de opgave van verhuizing van 'Jan'

  Regel: Een abonnee ontvangt alleen gebeurtenissen die hebben plaatsgevonden na het plaatsen van het abonnement daarop

    Scenario: De gebeurtenis heeft plaatsgevonden vóór het abonement is gezet
      Gegeven de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2025' op het adres 'Stadserf_1_Roosendaal'
      En abonnee 'SZW' is geabonneerd op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      Als een niet-gelezen gebeurtenis wordt gevraagd door abonnee 'SZW'
      Dan wordt er geen gebeurtenis geleverd

  Regel: Bij het vragen van niet-gelezen gebeurtenissen is het opgeven van de abonnee verplicht

    Scenario: Afnemer is geabonneerd op een gebeurtenis voor een abonnee en vraagt ongelezen gebeurtenissen zonder de abonnee op te geven
      Als een niet-gelezen gebeurtenis wordt gevraagd door afnemer 'Hengelo'
      Dan is de response '400 Bad Request'

  Regel: Alleen een geregistreerde abonnee mag gebeurtenissen bevragen

    Scenario: Afnemer is geabonneerd op een gebeurtenis voor een abonnee en vraagt ongelezen gebeurtenissen met een niet-geregistreerde abonnee
      Als een niet-gelezen gebeurtenis wordt gevraagd door abonnee 'WMO'
      Dan is de response '403 Forbidden'

  Regel: Gebeurtenissen ouder dan 2 maanden zijn ze niet meer op te vragen

    Scenario: De gebeurtenis heeft meer dan 2 maanden geleden plaatsgevonden en de abonnee wil deze nu nog lezen
      Gegeven abonnee 'SZW' is geabonneerd op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      En 3 maanden geleden om 9:32 uur is de aangifte van adreswijziging van 'Jan' verwerkt
      * verblijft vanaf '1-9-2025' op het adres 'Stadserf_1_Roosendaal'
      Als een niet-gelezen gebeurtenis wordt gevraagd door abonnee 'SZW'
      Dan wordt er geen gebeurtenis geleverd
