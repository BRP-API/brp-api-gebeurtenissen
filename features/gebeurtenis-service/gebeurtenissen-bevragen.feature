# language: nl
Functionaliteit: Gebeurtenissen bevragen
  Als consumer van BRP Gebeurtenissen
  wil ik ongelezen gebeurtenissen chronologisch kunnen bevragen
  zodat ik asynchroon de gebeurtenissen waarop ik ben geabonneerd kan verwerken

  Als gemeente 
  wil ik dat mijn interne afnemers zelf eigen abonnementen kunnen hebben en ongelezen eigen gebeurtenissen kunnen opvragen
  zodat ik niet zelf een distributiesysteem hoef te ontwikkelen/inkopen dat binnenkomende gebeurtenissen verdeelt onder mijn interne afnemers

  Achtergrond:
    Gegeven de afnemer 'Hengelo' heeft abonnees 'szw en jz' geregistreerd
    En het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    * in gemeente 'Hengelo'
    En het adres 'Stadserf_1_Roosendaal'
    * in gemeente 'Roosendaal'
    Gegeven 'Jan en Piet' verblijven vanaf 2 jaar geleden op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'

  Regel: Een abonnee ontvangt ongelezen gebeurtenissen

    Scenario: De abonnee heeft nog geen gebeurtenissen gevraagd
      Gegeven abonnee 'szw' is geabonneerd op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      En de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf gisteren op het adres 'Stadserf_1_Roosendaal'
      Als een ongelezen gebeurtenis wordt gevraagd door abonnee 'szw'
      Dan wordt de 'verhuisd.intergemeentelijk' gebeurtenis van 'Jan' geleverd

    Scenario: De eerste gebeurtenis is al gelezen dus de abonnee ontvangt alleen de ongelezen gebeurtenis
      Gegeven abonnee 'szw' is geabonneerd op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan en Piet'
      En de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf 3 dagen geleden op het adres 'Stadserf_1_Roosendaal'
      En een ongelezen gebeurtenis is gevraagd door abonnee 'szw'
      En de aangifte van adreswijziging van 'Piet' is verwerkt
      * verblijft vanaf gisteren op het adres 'Stadserf_1_Roosendaal'
      Als een ongelezen gebeurtenis wordt gevraagd door abonnee 'szw'
      Dan wordt de 'verhuisd.intergemeentelijk' gebeurtenis van 'Piet' geleverd

  Regel: Een gebeurtenis 'verhuisd.intergemeentelijk' wordt geleverd met het burgerservicenummer van de betreffende persoon en de datum vanaf wanneer deze hier verblijft

    Scenario: De gebeurtenis wordt geleverd met burgerservicenummer en datum vanaf
      Gegeven abonnee 'szw' is geabonneerd op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      En de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf gisteren op het adres 'Stadserf_1_Roosendaal'
      Als een ongelezen gebeurtenis wordt gevraagd door abonnee 'szw'
      Dan wordt een 'verhuisd.intergemeentelijk' gebeurtenis geleverd met de volgende data
      * het burgerservicenummer van 'Jan'
      * de vanaf datum van de opgave van verhuizing van 'Jan'

  Regel: Een abonnee ontvangt steeds de oudste ongelezen gebeurtenissen met een maximum van 10

    Scenario: Er zijn meer dan 10 gebeurtenissen en de abonnee ontvangt de oudste 10 gebeurtenissen
      Gegeven 'Willem, Annet, Gijs, Belle, Sterre en Noa' verblijven vanaf 2 jaar geleden op het adres 'Stadserf_1_Roosendaal'
      En 'Elsa, Luca en Sam' verblijven vanaf 2 jaar geleden op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
      Gegeven abonnee 'szw' is geabonneerd op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan, Piet, Willem, Annet, Gijs, Belle, Noa, Elsa, Luca en Sam'
      En de aangiftes van adreswijziging van 'Jan, Piet, Elsa, Luca en Sam' zijn verwerkt
      * verblijven vanaf gisteren op het adres 'Stadserf_1_Roosendaal'
      En de aangiftes van adreswijziging van 'Willem, Annet, Gijs, Belle, Sterre en Noa' zijn verwerkt
      * verblijven vanaf gisteren op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
      Als een ongelezen gebeurtenis wordt gevraagd door abonnee 'szw'
      Dan worden de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan, Piet, Elsa, Luca, Sam, Willem, Annet, Gijs, Belle en Sterre' geleverd

  Regel: Als er voor de abonnee geen ongelezen gebeurtenissen zijn, krijgt hij een leeg antwoord

    Scenario: De abonnee heeft alle ongelezen gebeurtenissen al gevraagd
      Gegeven abonnee 'szw' is geabonneerd op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      En de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf gisteren op het adres 'Stadserf_1_Roosendaal'
      En alle ongelezen gebeurtenissen zijn gevraagd door abonnee 'szw'
      Als een ongelezen gebeurtenis wordt gevraagd door abonnee 'szw'
      Dan wordt er geen gebeurtenis geleverd

  Regel: Een abonnee krijgt alleen een gebeurtenis wanneer hij een abonnement heeft op het type gebeurtenis voor de persoon waarop de gebeurtenis heeft plaatsgevonden

    Scenario: De abonnee vraagt ongelezen gebeurtenissen en is niet geabonneerd op de gebeurtenis
      Gegeven de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf gisteren op het adres 'Stadserf_1_Roosendaal'
      Als een ongelezen gebeurtenis wordt gevraagd door abonnee 'szw'
      Dan wordt er geen gebeurtenis geleverd

    Scenario: De abonnee vraagt ongelezen gebeurtenissen en een is geabonneerd op het gebeurtenistype voor een andere persoon
      Gegeven abonnee 'szw' is geabonneerd op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Piet'
      En de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf gisteren op het adres 'Stadserf_1_Roosendaal'
      Als een ongelezen gebeurtenis wordt gevraagd door abonnee 'szw'
      Dan wordt er geen gebeurtenis geleverd

    Scenario: De abonnee vraagt ongelezen gebeurtenissen en een is geabonneerd op een ander gebeurtenistype voor de persoon
      Gegeven abonnee 'szw' is geabonneerd op de 'verhuisd.naar-buitenland' gebeurtenissen van 'Jan'
      En de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf gisteren op het adres 'Stadserf_1_Roosendaal'
      Als een ongelezen gebeurtenis wordt gevraagd door abonnee 'szw'
      Dan wordt er geen gebeurtenis geleverd

  Regel: Meerdere abonnees kunnen dezelfde gebeurtenis ontvangen

    Scenario: De abonnee vraagt ongelezen gebeurtenissen en een andere abonnee heeft de gebeurtenis al gevraagd
      Gegeven abonnee 'szw' is geabonneerd op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      En abonnee 'jz' is geabonneerd op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      En de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf gisteren op het adres 'Stadserf_1_Roosendaal'
      En alle ongelezen gebeurtenissen zijn gevraagd door abonnee 'szw'
      Als een ongelezen gebeurtenis wordt gevraagd door abonnee 'jz'
      Dan wordt de 'verhuisd.intergemeentelijk' gebeurtenis van 'Jan' geleverd

  Regel: Een abonnee ontvangt alleen gebeurtenissen die hebben plaatsgevonden na het plaatsen van het abonnement daarop
    Een abonnee zet een abonnement op het moment dat doelbinding op het ontvangen van de gebeurtenis voor de persoon ontstaat
    en heeft dus geen doelbinding voor het ontvangen van deze gebeurtenissen voor deze persoon die daarvóór hebben plaatsgevonden.

    Scenario: De gebeurtenis heeft plaatsgevonden vóór het abonement is gezet
      Gegeven de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf gisteren op het adres 'Stadserf_1_Roosendaal'
      En abonnee 'szw' is geabonneerd op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      Als een ongelezen gebeurtenis wordt gevraagd door abonnee 'szw'
      Dan wordt er geen gebeurtenis geleverd

  Regel: Alleen een abonnee mag gebeurtenissen bevragen

    Scenario: Afnemer vraagt ongelezen gebeurtenissen en vult bij abonnee iets anders in dan een abonnee
      Als een ongelezen gebeurtenis wordt gevraagd door abonnee 'wmo'
      Dan is de response '404 Not found

  Regel: Gebeurtenissen ouder dan 2 maanden zijn ze niet meer op te vragen

    Scenario: De gebeurtenis heeft meer dan 2 maanden geleden plaatsgevonden en de abonnee wil deze nu nog lezen
      Gegeven abonnee 'szw' is geabonneerd op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      En 3 maanden geleden is de aangifte van adreswijziging van 'Jan' verwerkt
      * verblijft vanaf gisteren op het adres 'Stadserf_1_Roosendaal'
      Als een ongelezen gebeurtenis wordt gevraagd door abonnee 'szw'
      Dan wordt er geen gebeurtenis geleverd
