# language: nl
Functionaliteit: Gebeurtenis wanneer het burgerservicenummer van een persoon wijzigt door oplossen dubbelinschrijving
  Als abonnee wil ik het weten wanneer het burgerservicenummer van een persoon wijzigt,
  zodat ik het juiste burgerservicenummer kan gebruiken voor mijn dienstverlening.

  Zie https://www.rvig.nl/hup/wijzigen-bsn

  De gebeurtenis 'burgerservicenummer-gewijzigd' is te herkennen aan het wijzigen van burgerservicenummerr (01.01.20).

  Regel: Als het burgerservicenummer van de persoon is gewijzigd, dan heeft gebeurtenis 'burgerservicenummer-gewijzigd' plaatsgevonden

    Scenario: Het burgerservicenummer wordt gewijzigd
      Gegeven de persoon 'Jan'
      * met burgerservicenummer 000000012
      Als het burgerservicenummer wordt gewijzigd naar 000000024
      Dan is een 'burgerservicenummer-gewijzigd' gebeurtenis gepubliceerd

  Regel: Bij gebeurtenistype 'burgerservicenummer-gewijzigd' wordt het A-nummer van de persoon meegeleverd en het oude en nieuwe burgerservicenummer

    Scenario: Het burgerservicenummer wordt gewijzigd
      Gegeven de persoon 'Jan'
      * met burgerservicenummer 000000012
      Als het burgerservicenummer wordt gewijzigd naar 000000024
      Dan is een 'burgerservicenummer-gewijzigd' gebeurtenis gepubliceerd met de volgende data
      * A-nummer 9000000002
      * het historisch geworden burgerservicenummer 000000012
      * het actuele burgerservicenummer 000000024
