# language: nl
Functionaliteit: Gebeurtenissen bevragen
  Als consumer van BRP Gebeurtenissen
  wil ik ongelezen gebeurtenissen chronologisch kunnen bevragen
  zodat ik asynchroon de gebeurtenissen waarop ik ben geabonneerd kan verwerken

  Als gemeente 
  wil ik dat mijn interne afnemers zelf eigen abonnementen kunnen hebben en ongelezen eigen gebeurtenissen kunnen opvragen
  zodat ik niet zelf een distributiesysteem hoef te ontwikkelen/inkopen dat binnenkomende gebeurtenissen verdeelt onder mijn interne afnemers

  Achtergrond:
    Gegeven de afnemer 'Hengelo' heeft abonnees 'SZW en JZ' geregistreerd
    En het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    * in gemeente 'Hengelo'
    En het adres 'Stadserf_1_Roosendaal'
    * in gemeente 'Roosendaal'
    Gegeven 'Jan en Piet' verblijven vanaf '14-4-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'

  Regel: Een abonnee ontvangt steeds de oudste ongelezen gebeurtenis

    Scenario: De abonnee heeft nog geen gebeurtenissen gevraagd
      Gegeven abonnee 'SZW' is geabonneerd op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      En de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf gisteren op het adres 'Stadserf_1_Roosendaal'
      Als een ongelezen gebeurtenis wordt gevraagd door abonnee 'SZW'
      Dan wordt de 'verhuisd.intergemeentelijk' gebeurtenis van 'Jan' geleverd

    Scenario: Er zijn meerdere gebeurtenissen dus de abonnee ontvangt de oudste gebeurtenis
      Gegeven abonnee 'SZW' is geabonneerd op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan en Piet'
      En de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf 3 dagen geleden op het adres 'Stadserf_1_Roosendaal'
      En de aangifte van adreswijziging van 'Piet' is verwerkt
      * verblijft vanaf gisteren op het adres 'Stadserf_1_Roosendaal'
      Als een ongelezen gebeurtenis wordt gevraagd door abonnee 'SZW'
      Dan wordt de 'verhuisd.intergemeentelijk' gebeurtenis van 'Jan' geleverd

    Scenario: De eerste van meerdere gebeurtenissen is al gelezen dus de abonnee ontvangt de tweede gebeurtenis
      Gegeven abonnee 'SZW' is geabonneerd op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan en Piet'
      En de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf 3 dagen geleden op het adres 'Stadserf_1_Roosendaal'
      En de aangifte van adreswijziging van 'Piet' is verwerkt
      * verblijft vanaf gisteren op het adres 'Stadserf_1_Roosendaal'
      En een ongelezen gebeurtenis is gevraagd door abonnee 'SZW'
      Als een ongelezen gebeurtenis wordt gevraagd door abonnee 'SZW'
      Dan wordt de 'verhuisd.intergemeentelijk' gebeurtenis van 'Piet' geleverd

  Regel: Een gebeurtenis 'verhuisd.intergemeentelijk' wordt geleverd met het burgerservicenummer van de betreffende persoon en de datum vanaf wanneer deze hier verblijft

    Scenario: De gebeurtenis wordt geleverd met burgerservicenummer en datum vanaf
      Gegeven abonnee 'SZW' is geabonneerd op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      En de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf gisteren op het adres 'Stadserf_1_Roosendaal'
      Als een ongelezen gebeurtenis wordt gevraagd door abonnee 'SZW'
      Dan wordt een 'verhuisd.intergemeentelijk' gebeurtenis geleverd met de volgende data
      * het burgerservicenummer van 'Jan'
      * de vanaf datum van de opgave van verhuizing van 'Jan'

  Regel: Als er voor de abonnee geen ongelezen gebeurtenissen zijn, krijgt hij een leeg antwoord

    Scenario: De abonnee heeft alle ongelezen gebeurtenissen al gevraagd
      Gegeven abonnee 'SZW' is geabonneerd op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      En de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf gisteren op het adres 'Stadserf_1_Roosendaal'
      En alle ongelezen gebeurtenissen zijn gevraagd door abonnee 'SZW'
      Als een ongelezen gebeurtenis wordt gevraagd door abonnee 'SZW'
      Dan wordt er geen gebeurtenis geleverd

  Regel: Een abonnee krijgt alleen een gebeurtenis wanneer hij een abonnement heeft op het type gebeurtenis voor de persoon waarop de gebeurtenis heeft plaatsgevonden

    Scenario: De abonnee vraagt ongelezen gebeurtenissen en is niet geabonneerd op de gebeurtenis
      Gegeven de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf gisteren op het adres 'Stadserf_1_Roosendaal'
      Als een ongelezen gebeurtenis wordt gevraagd door abonnee 'SZW'
      Dan wordt er geen gebeurtenis geleverd

    Scenario: De abonnee vraagt ongelezen gebeurtenissen en een is geabonneerd op het gebeurtenistype voor een andere persoon
      Gegeven abonnee 'SZW' is geabonneerd op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Piet'
      En de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf gisteren op het adres 'Stadserf_1_Roosendaal'
      Als een ongelezen gebeurtenis wordt gevraagd door abonnee 'SZW'
      Dan wordt er geen gebeurtenis geleverd

    Scenario: De abonnee vraagt ongelezen gebeurtenissen en een is geabonneerd op een ander gebeurtenistype voor de persoon
      Gegeven abonnee 'SZW' is geabonneerd op de 'verhuisd.naar-buitenland' gebeurtenissen van 'Jan'
      En de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf gisteren op het adres 'Stadserf_1_Roosendaal'
      Als een ongelezen gebeurtenis wordt gevraagd door abonnee 'SZW'
      Dan wordt er geen gebeurtenis geleverd

  Regel: Meerdere abonnees kunnen dezelfde gebeurtenis ontvangen

    Scenario: De abonnee vraagt ongelezen gebeurtenissen en een andere abonnee heeft de gebeurtenis al gevraagd
      Gegeven abonnee 'SZW' is geabonneerd op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      En abonnee 'JZ' is geabonneerd op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      En de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf gisteren op het adres 'Stadserf_1_Roosendaal'
      En alle ongelezen gebeurtenissen zijn gevraagd door abonnee 'SZW'
      Als een ongelezen gebeurtenis wordt gevraagd door abonnee 'JZ'
      Dan wordt de 'verhuisd.intergemeentelijk' gebeurtenis van 'Jan' geleverd

  Regel: Een abonnee ontvangt alleen gebeurtenissen die hebben plaatsgevonden na het plaatsen van het abonnement daarop
    Een abonnee zet een abonnement op het moment dat doelbinding op het ontvangen van de gebeurtenis voor de persoon ontstaat
    en heeft dus geen doelbinding voor het ontvangen van deze gebeurtenissen voor deze persoon die daarvóór hebben plaatsgevonden.

    Scenario: De gebeurtenis heeft plaatsgevonden vóór het abonement is gezet
      Gegeven de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf gisteren op het adres 'Stadserf_1_Roosendaal'
      En abonnee 'SZW' is geabonneerd op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      Als een ongelezen gebeurtenis wordt gevraagd door abonnee 'SZW'
      Dan wordt er geen gebeurtenis geleverd

  Regel: Bij het vragen van ongelezen gebeurtenissen is het opgeven van de abonnee verplicht

    Scenario: Afnemer vraagt ongelezen gebeurtenissen zonder de abonnee op te geven
      Als een ongelezen gebeurtenis wordt gevraagd door afnemer 'Hengelo'
      Dan is de response '400 Bad Request'

  Regel: Alleen een abonnee mag gebeurtenissen bevragen

    Scenario: Afnemer vraagt ongelezen gebeurtenissen en vult bij abonnee iets anders in dan een abonnee
      Als een ongelezen gebeurtenis wordt gevraagd door abonnee 'WMO'
      Dan is de response '403 Forbidden'

  Regel: Gebeurtenissen ouder dan 2 maanden zijn ze niet meer op te vragen

    Scenario: De gebeurtenis heeft meer dan 2 maanden geleden plaatsgevonden en de abonnee wil deze nu nog lezen
      Gegeven abonnee 'SZW' is geabonneerd op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      En 3 maanden geleden om 9:32 uur is de aangifte van adreswijziging van 'Jan' verwerkt
      * verblijft vanaf gisteren op het adres 'Stadserf_1_Roosendaal'
      Als een ongelezen gebeurtenis wordt gevraagd door abonnee 'SZW'
      Dan wordt er geen gebeurtenis geleverd
