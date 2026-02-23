# language: nl
Functionaliteit: Gebeurtenissen opnieuw lezen
  Als consumer van BRP Gebeurtenissen
  wil ik gebeurtenissen als niet-gelezen kunnen markeren
  zodat ik de gebeurtenissen opnieuw kan verwerken

  Regel: Een abonnee kan gebeurtenissen vanaf een bepaald tijdstip als niet-gelezen markeren

    Scenario: De abonnee heeft alle niet-gelezen gebeurtenissen gevraagd en markeert de gebeurtenissen als niet-gelezen vanaf een bepaald moment
      Gegeven abonnee 'SZW' is geabonneerd op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      En abonnee 'SZW' is geabonneerd op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Piet'
      En vorige week om 9:29 uur is de aangifte van adreswijziging van 'Jan' verwerkt
      * verblijft vanaf '1-9-2025' op het adres 'Stadserf_1_Roosendaal'
      En vorige week om 9:32 uur is de aangifte van adreswijziging van 'Piet' verwerkt
      * verblijft vanaf '2-9-2025' op het adres 'Stadserf_1_Roosendaal'
      En alle niet-gelezen gebeurtenissen zijn gevraagd door abonnee 'SZW'
      En abonnee 'SZW' markeert de gebeurtenissen vanaf vorige week om 9:30 uur als niet-gelezen
      Als een niet-gelezen gebeurtenis wordt gevraagd door abonnee 'SZW'
      Dan wordt een 'verhuisd.intergemeentelijk' gebeurtenis geleverd met de volgende data
      * het burgerservicenummer van 'Piet'
      * de vanaf datum van de opgave van verhuizing van 'Piet'

  Regel: Een abonnee kan gebeurtenissen na een bepaalde gebeurtenis als niet-gelezen markeren

    Scenario: De abonnee heeft alle niet-gelezen gebeurtenissen gevraagd en markeert de gebeurtenissen als niet-gelezen vanaf een bepaald moment
      Gegeven abonnee 'SZW' is geabonneerd op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      En abonnee 'SZW' is geabonneerd op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Piet'
      En de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2025' op het adres 'Stadserf_1_Roosendaal'
      En de aangifte van adreswijziging van 'Piet' is verwerkt
      * verblijft vanaf '2-9-2025' op het adres 'Stadserf_1_Roosendaal'
      En alle niet-gelezen gebeurtenissen zijn gevraagd door abonnee 'SZW'
      En abonnee 'SZW' markeert de gebeurtenissen na de gebeurtenis 'verhuisd.intergemeentelijk' van 'Jan' als niet-gelezen
      Als een niet-gelezen gebeurtenis wordt gevraagd door abonnee 'SZW'
      Dan wordt een 'verhuisd.intergemeentelijk' gebeurtenis geleverd met de volgende data
      * het burgerservicenummer van 'Piet'
      * de vanaf datum van de opgave van verhuizing van 'Piet'

  Regel: Gebeurtenissen op niet-gelezen zetten geldt alleen voor de abonnee die dit doet

    Scenario: De abonnee heeft alle niet-gelezen gebeurtenissen gevraagd en een andere abonnee van dezelfde afnemer markeert alle gebeurtenissen als niet-gelezen
      Gegeven abonnee 'SZW' is geabonneerd op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      En abonnee 'JZ' is geabonneerd op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      En vorige week om 9:32 uur is de aangifte van adreswijziging van 'Jan' verwerkt
      * verblijft vanaf '1-9-2025' op het adres 'Stadserf_1_Roosendaal'
      En alle niet-gelezen gebeurtenissen zijn gevraagd door abonnee 'SZW'
      En alle niet-gelezen gebeurtenissen zijn gevraagd door abonnee 'JZ'
      En abonnee 'SZW' markeert de gebeurtenissen vanaf vorige week om 9:30 uur als niet-gelezen
      Als een niet-gelezen gebeurtenis wordt gevraagd door abonnee 'JZ'
      Dan wordt er geen gebeurtenis geleverd

  Regel: Alleen gebeurtenissen die hebben plaatsgevonden na het zetten van het abonnement mogen op ongelezen worden gezet
    Deze regel is de consequentie van de regel "Een abonnee ontvangt alleen gebeurtenissen die hebben plaatsgevonden na het plaatsen van het abonnement daarop"

    Scenario: Een abonnee probeert alle gebeurtenissen op ongelezen te zetten vanaf een moment vóór het zetten van het abonnement
      Gegeven abonnee 'SZW' is gisteren om 9:32 uur geabonneerd op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      Als abonnee 'SZW' de gebeurtenissen vanaf vorige week om 7:00 uur als niet-gelezen markeert
      Dan is de response '400 Bad Request'

  Regel: Alleen gebeurtenissen van minder dan 2 maanderen geleden kunnen op ongelezen worden gezet
    Wanneer de vanafdatum ligt voor de oudst beschikbare gebeurtenis, dan worden alle nog wel beschikbare gebeurtenissen op niet-gelezen gezet.
    Wanneer de opgegeven gebeurtenis niet meer beschikbaar is, dan worden alle nog wel beschikbare gebeurtenissen op niet-gelezen gezet.

    Scenario: De abonnee probeert alle gebeurtenissen van meer dan 2 maanden geleden op ongelezen te zetten
      Als abonnee 'SZW' de gebeurtenissen vanaf 4 maanden geleden om 9:30 uur als niet-gelezen markeert
      Dan is de response '400 Bad Request'

  Regel: Als de abonnee gebeurtenissen op ongelezen wil zetten met een gebeurtenis id die niet bekend is of niet meer beschikbaar is, dan wordt een foutmelding gegeven
    Er wordt een foutmelding gegeven wanneer:
    - er geen gebeurtenis wordt gevonden met de opgegeven gebeurtenis id
    - de abonnee geen abonnement heeft op de opgegeven gebeurtenis id (de abonnee kan deze gebeurtenis id dus niet kennen en heeft dan evident een verkeerde id opgegeven)
    - de gebeurtenis niet meer beschikbaar is omdat deze meer dan 2 maanden geleden heeft plaatsgevonden, en daarom is verwijderd

    Scenario: De abonnee probeert alle gebeurtenissen na een gebeurtenis die niet bekend is op ongelezen te zetten
      Als abonnee 'SZW' de gebeurtenissen na de gebeurtenis met id 99999999 als niet-gelezen markeert
      Dan is de response '400 Bad Request'

    Scenario: De abonnee probeert alle gebeurtenissen na een gebeurtenis die meer dan 2 maanden geleden heeft plaatsgevonden op ongelezen te zetten
      Gegeven abonnee 'SZW' is geabonneerd op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      En 3 maanden geleden om 9:32 uur is de aangifte van adreswijziging van 'Jan' verwerkt
      * verblijft vanaf '1-9-2025' op het adres 'Stadserf_1_Roosendaal'
      Als abonnee 'SZW' de gebeurtenissen na de gebeurtenis 'verhuisd.intergemeentelijk' van 'Jan' als niet-gelezen markeert
      Dan is de response '400 Bad Request'
