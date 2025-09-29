# language: nl
Functionaliteit: Gebeurtenissen bevragen
  Als consumer van BRP Gebeurtenissen
  wil ik gebeurtenissen kunnen bevragen op basis van hun identifier
  zodat ik de details van een specifieke gebeurtenis kan inzien

  Als consumer van BRP Gebeurtenissen
  wil ik niet-gelezen gebeurtenissen chronologisch kunnen bevragen
  zodat ik asynchroon de gebeurtenissen waarop ik ben geabonneerd kan verwerken

  Als consumer van BRP Gebeurtenissen
  wil ik gebeurtenissen als niet-gelezen kunnen markeren
  zodat ik de gebeurtenissen opnieuw kan verwerken

  Achtergrond:
    Gegeven afnemer 'B1' is geabonneerd op 'ingeschreven.immigratie' gebeurtenissen in gemeente 'Utrecht'
    En de persoon 'Jan'
    En de gepubliceerde 'ingeschreven.immigratie' gebeurtenis
    * bevat de id 'A1234'
    * bevat de time 'vandaag 2 dagen geleden'
    * bevat de 'data' de pl_id van 'Jan'
    En de persoon 'Piet'
    En de gepubliceerde 'ingeschreven.immigratie' gebeurtenis
    * bevat de id 'A2345'
    * bevat de time 'vandaag 1 dag geleden'
    * bevat de 'data' de pl_id van 'Piet'

  Regel: Een gebeurtenis kan worden bevraagd met zijn identifier als de bevrager zich op de gebeurtenis heeft geabonneerd

    Scenario: Afnemer is geabonneerd op 'ingeschreven.immigratie' gebeurtenissen in gemeente 'Utrecht'
      Als een gebeurtenis wordt gevraagd door afnemer 'B1' met identifier 'A1234'
      Dan wordt een 'ingeschreven.immigratie' gebeurtenis geleverd
      * bevat de id 'A1234'
      * bevat de 'data' de burgerservicenummer van 'Jan'

    Scenario: Afnemer is niet geabonneerd op 'ingeschreven.immigratie' gebeurtenissen
      Als een gebeurtenis wordt gevraagd door afnemer 'C1' met identifier 'A1234'
      Dan wordt een niet-geautoriseerd foutbericht geleverd

  Regel: Een afnemer kan niet-gelezen gebeurtenissen waarop hij is geabonneerd chronologisch bevragen

    Scenario: Afnemer heeft nog geen gebeurtenissen gevraagd
      Als een niet-gelezen gebeurtenis wordt gevraagd door afnemer 'B1'
      Dan wordt een 'ingeschreven.immigratie' gebeurtenis geleverd
      * bevat de id 'A1234'
      * bevat de 'data' de burgerservicenummer van 'Jan'

    Scenario: Afnemer heeft al een gebeurtenis gevraagd
      Gegeven een niet-gelezen gebeurtenis is gevraagd door afnemer 'B1'
      Als nog een niet-gelezen gebeurtenis wordt gevraagd door afnemer 'B1'
      Dan wordt een 'ingeschreven.immigratie' gebeurtenis geleverd
      * bevat de id 'A2345'
      * bevat de 'data' de burgerservicenummer van 'Piet'

    Scenario: Afnemer heeft alle niet-gelezen gebeurtenissen al gevraagd
      Gegeven alle niet-gelezen gebeurtenissen zijn gevraagd door afnemer 'B1'
      Als nog een niet-gelezen gebeurtenis wordt gevraagd door afnemer 'B1'
      Dan wordt er geen gebeurtenis geleverd

  Regel: Een afnemer kan alle gebeurtenissen als niet-gelezen markeren

    Scenario: Afnemer heeft alle niet-gelezen gebeurtenissen gevraagd en markeert alle gebeurtenissen als niet-gelezen
      Gegeven alle niet-gelezen gebeurtenissen zijn gevraagd door afnemer 'B1'
      En afnemer 'B1' markeert al zijn gebeurtenissen als niet-gelezen
      Als een niet-gelezen gebeurtenis wordt gevraagd door afnemer 'B1'
      Dan wordt een 'ingeschreven.immigratie' gebeurtenis geleverd
      * bevat de id 'A1234'
      * bevat de 'data' de burgerservicenummer van 'Jan'

  Regel: Een afnemer kan gebeurtenissen vanaf een datum als niet-gelezen markeren

    Scenario: Afnemer heeft alle niet-gelezen gebeurtenissen gevraagd en markeert gebeurtenissen vanaf een datum als niet-gelezen
      Gegeven alle niet-gelezen gebeurtenissen zijn gevraagd door afnemer 'B1'
      En afnemer 'B1' markeert de gebeurtenissen vanaf 'vandaag 1 dag geleden' als niet-gelezen
      Als een niet-gelezen gebeurtenis wordt gevraagd door afnemer 'B1'
      Dan wordt een 'ingeschreven.immigratie' gebeurtenis geleverd
      * bevat de id 'A2345'
      * bevat de 'data' de burgerservicenummer van 'Piet'
