# language: nl
Functionaliteit: gebeurtenissen opvragen bij een aangifte van adreswijziging naar een andere gemeente
  Als afdeling Begraven van de gemeente wil ik het weten wanneer een gevolgde persoon verhuisd is,
  zodat ik batchgewijs automatische betalingen kan verwerken zonder het hele bestand in één keer te verversen.

  Als afdeling Parkeerbelasting van de gemeente wil ik het weten wanneer een gevolgde persoon verhuisd is,
  zodat ik de invordering naar het juiste adres kan sturen en het weet wanneer een persoon vertrokken is.
 
  Als afdeling WGS Vroegsignalering van de gemeente wil ik het weten wanneer een gevolgde persoon verhuisd is naar een andere gemeente,
  zodat ik het dossier kan overdragen naar de nieuwe gemeente en het dossier kan sluiten.

  Regel: bij opvragen van ongelezen gebeurtenissen door een afnemer ontvangt deze alleen gebeurtenissen waar deze afnemer op geabonneerd is

    Scenario: een afnemer is geabonneerd op gebeurtenis 'verhuisd.intergemeentelijk' van een persoon en deze persoon overlijdt
      Gegeven de persoon 'Jan'
      En afnemer 'Roosendaal' is geabonneerd op 'verhuisd.intergemeentelijk' gebeurtenissen van de persoon 'Jan'
      En de gepubliceerde 'verhuisd.intergemeentelijk' gebeurtenis
      * bevat de id 'A1234'
      * bevat de 'data' in categorie 'persoon' in groep 'identificatienummers' het element 'A-nummer (01.10)' van 'Jan'
      * bevat de 'data' in categorie 'verblijfplaats' in groep 'adreshouding' element 'datum aanvang adreshouding (10.30)' met waarde '20250901'
      * bevat de 'data' in categorie 'verblijfplaats' in groep 'adres' element 'identificatiecode verblijfplaats (11.80)' met waarde '1674010000008508'
      Als een niet-gelezen gebeurtenis wordt gevraagd door afnemer 'Roosendaal'
      Dan wordt een 'verhuisd.intergemeentelijk' gebeurtenis geleverd
      * bevat de id 'A1234'
      * bevat de 'data' de volgende gegevens
        | naam                                            | waarde                            |
        | burgerservicenummer                             | het burgerservicenummer van 'Jan' |
        | verblijfplaats.datumVan.type                    | Datum                             |
        | verblijfplaats.datumVan.datum                   |                        2025-09-01 |
        | verblijfplaats.datumVan.langFormaat             |                  1 september 2025 |
        | verblijfplaats.adresseerbaarObjectIdentificatie |                  1674010000008508 |

    Scenario: een afnemer is geabonneerd op gebeurtenis 'verhuisd.intergemeentelijk' van een persoon en een andere persoon verhuist naar een andere gemeente
      Gegeven de persoon 'Jan'
      En afnemer 'Roosendaal' is geabonneerd op 'verhuisd.intergemeentelijk' gebeurtenissen van de persoon 'Jan'
      En de persoon 'Piet'
      En de gepubliceerde 'verhuisd.intergemeentelijk' gebeurtenis
      * bevat de id 'A1234'
      * bevat de 'data' in categorie 'persoon' in groep 'identificatienummers' het element 'A-nummer (01.10)' van 'Piet'
      * bevat de 'data' in categorie 'verblijfplaats' in groep 'adreshouding' element 'datum aanvang adreshouding (10.30)' met waarde '20250901'
      * bevat de 'data' in categorie 'verblijfplaats' in groep 'adres' element 'identificatiecode verblijfplaats (11.80)' met waarde '1674010000008508'
      Als een niet-gelezen gebeurtenis wordt gevraagd door afnemer 'Roosendaal'
      Dan wordt er geen gebeurtenis geleverd

    Scenario: een afnemer is geabonneerd op gebeurtenis 'verhuisd.intergemeentelijk' van een persoon en een andere afnemer volgt een andere persoon die verhuist naar een andere gemeente
      Gegeven de persoon 'Jan'
      En afnemer 'Roosendaal' is geabonneerd op 'verhuisd.intergemeentelijk' gebeurtenissen van de persoon 'Jan'
      En de persoon 'Piet'
      En afnemer 'Hengelo' is geabonneerd op 'verhuisd.intergemeentelijk' gebeurtenissen van de persoon 'Piet'
      En de gepubliceerde 'verhuisd.intergemeentelijk' gebeurtenis
      * bevat de id 'A1234'
      * bevat de 'data' in categorie 'persoon' in groep 'identificatienummers' het element 'A-nummer (01.10)' van 'Piet'
      * bevat de 'data' in categorie 'verblijfplaats' in groep 'adreshouding' element 'datum aanvang adreshouding (10.30)' met waarde '20250901'
      * bevat de 'data' in categorie 'verblijfplaats' in groep 'adres' element 'identificatiecode verblijfplaats (11.80)' met waarde '1674010000008508'
      Als een niet-gelezen gebeurtenis wordt gevraagd door afnemer 'Roosendaal'
      Dan wordt er geen gebeurtenis geleverd

    Scenario: een afnemer heeft het abonnement op de gebeurtenis voor deze persoon beëindigd
      Gegeven de persoon 'Jan'
      En de persoon 'Piet'
      En afnemer 'Roosendaal' is geabonneerd op 'verhuisd.intergemeentelijk' gebeurtenissen van de persoon 'Jan'
      En afnemer 'Roosendaal' is geabonneerd op 'verhuisd.intergemeentelijk' gebeurtenissen van de persoon 'Piet'
      En afnemer 'Roosendaal' heeft het abonnement op 'verhuisd.intergemeentelijk' gebeurtenissen van de persoon 'Jan' beëindigd
      En de gepubliceerde 'verhuisd.intergemeentelijk' gebeurtenis
      * bevat de id 'A1234'
      * bevat de 'data' in categorie 'persoon' in groep 'identificatienummers' het element 'A-nummer (01.10)' van 'Jan'
      * bevat de 'data' in categorie 'verblijfplaats' in groep 'adreshouding' element 'datum aanvang adreshouding (10.30)' met waarde '20250901'
      * bevat de 'data' in categorie 'verblijfplaats' in groep 'adres' element 'identificatiecode verblijfplaats (11.80)' met waarde '1674010000008508'
      Als een niet-gelezen gebeurtenis wordt gevraagd door afnemer 'Roosendaal'
      Dan wordt er geen gebeurtenis geleverd

    Scenario: een afnemer heeft het abonnement op de gebeurtenis voor een andere persoon beëindigd
      Gegeven de persoon 'Jan'
      En de persoon 'Piet'
      En afnemer 'Roosendaal' is geabonneerd op 'verhuisd.intergemeentelijk' gebeurtenissen van de persoon 'Jan'
      En afnemer 'Roosendaal' is geabonneerd op 'verhuisd.intergemeentelijk' gebeurtenissen van de persoon 'Piet'
      En afnemer 'Roosendaal' heeft het abonnement op 'verhuisd.intergemeentelijk' gebeurtenissen van de persoon 'Jan' beëindigd
      En de gepubliceerde 'verhuisd.intergemeentelijk' gebeurtenis
      * bevat de id 'A1234'
      * bevat de 'data' in categorie 'persoon' in groep 'identificatienummers' het element 'A-nummer (01.10)' van 'Piet'
      * bevat de 'data' in categorie 'verblijfplaats' in groep 'adreshouding' element 'datum aanvang adreshouding (10.30)' met waarde '20250901'
      * bevat de 'data' in categorie 'verblijfplaats' in groep 'adres' element 'identificatiecode verblijfplaats (11.80)' met waarde '1674010000008508'
      Als een niet-gelezen gebeurtenis wordt gevraagd door afnemer 'Roosendaal'
      Dan wordt een 'verhuisd.intergemeentelijk' gebeurtenis geleverd
      * bevat de id 'A1234'
      * bevat de 'data' de volgende gegevens
        | naam                                            | waarde                             |
        | burgerservicenummer                             | het burgerservicenummer van 'Piet' |
        | verblijfplaats.datumVan.type                    | Datum                              |
        | verblijfplaats.datumVan.datum                   |                         2025-09-01 |
        | verblijfplaats.datumVan.langFormaat             |                   1 september 2025 |
        | verblijfplaats.adresseerbaarObjectIdentificatie |                   1674010000008508 |

  Regel: een afnemer ontvangt alleen gebeurtenissen die door deze afnemer nog niet gelezen zijn

    Scenario: Afnemer heeft alle gebeurtenissen waarop deze geabonneerd is al ontvangen
      Gegeven de persoon 'Jan'
      En afnemer 'Roosendaal' is geabonneerd op 'verhuisd.intergemeentelijk' gebeurtenissen van de persoon 'Jan'
      En de gepubliceerde 'verhuisd.intergemeentelijk' gebeurtenis
      * bevat de id 'A1234'
      * bevat de 'data' in categorie 'persoon' in groep 'identificatienummers' het element 'A-nummer (01.10)' van 'Jan'
      * bevat de 'data' in categorie 'verblijfplaats' in groep 'adreshouding' element 'datum aanvang adreshouding (10.30)' met waarde '20250901'
      * bevat de 'data' in categorie 'verblijfplaats' in groep 'adres' element 'identificatiecode verblijfplaats (11.80)' met waarde '1674010000008508'
      En afnemer 'Roosendaal' heeft alle niet-gelezen gebeurtenissen gevraagd
      Als een niet-gelezen gebeurtenis wordt gevraagd door afnemer 'Roosendaal'
      Dan wordt er geen gebeurtenis geleverd

  Regel: een afnemer kan eerder gelezen gebeurtenissen opnieuw lezen door alle gebeurtenissen na een op te geven gebeurtenis id op ongelezen te zetten

    Scenario: Afnemer heeft alle gebeurtenissen waarop deze geabonneerd is al ontvangen en wil een aantal ongelezen berichten opnieuw lezen
      Gegeven de persoon 'Jan'
      En de persoon 'Piet'
      En de persoon 'Gerda'
      En afnemer 'Roosendaal' is geabonneerd op 'verhuisd.intergemeentelijk' gebeurtenissen van de personen 'Jan', 'Piet' en 'Gerda'
      En de gepubliceerde 'verhuisd.intergemeentelijk' gebeurtenis met id '1'
      En de gepubliceerde 'verhuisd.intergemeentelijk' gebeurtenis met id '2'
      En de gepubliceerde 'verhuisd.intergemeentelijk' gebeurtenis met id '3'
      En afnemer 'Roosendaal' heeft alle niet-gelezen gebeurtenissen gevraagd
      En afnemer 'Roosendaal' heeft gevraagd om gebeurtenissen na '1' opnieuw te lezen
      Als een niet-gelezen gebeurtenis wordt gevraagd door afnemer 'Roosendaal'
      Dan wordt een 'verhuisd.intergemeentelijk' gebeurtenis geleverd
      * bevat de id '2'
