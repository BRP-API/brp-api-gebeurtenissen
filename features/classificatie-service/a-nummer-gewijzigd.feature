# language: nl
Functionaliteit: Gebeurtenis wanneer het A-nummer van een persoon wijzigt
  Als abonnee wil ik het weten wanneer het A-nummer van een persoon wijzigt,
  zodat ik het juiste A-nummer kan gebruiken voor mijn dienstverlening.

  Zie https://www.rvig.nl/hup/wijzigen-administratienummer

  Een A-nummer kan wijzigen om verschillende redenen:
  1. er zijn persoonslijsten van twee personen met hetzelfde A-nummer: op beide persoonslijsten (voor beide personen) wordt het A-nummer gewijzigd.
  2. er zijn twee persoonslijsten van één persoon (dubbelinschrijving): op de overbodig geworden persoonslijst wordt een verwijzing opgenomen naar de overblijvende persoonslijst.

  De 1e reden leidt tot gebeurtenistype 'a-nummer-gewijzigd'.
  De 2e reden leidt tot gebeurtenistype 'dubbelinschrijving-opgelost.a-nummer-gewijzigd'. Zie dubbelinschrijving-opgelost.a-nummer-gewijzigd.feature.
  
  De gebeurtenis 'a-nummer-gewijzigd' is te herkennen aan het wijzigen van A-nummer (01.01.10) en vullen van Vorig A-nummer (01.20.10). Vorig A-nummer (01.20.10) is gelijk aan het historisch geworden A-nummer (51.01.10).

  Regel: Als het A-nummer van de persoon is gewijzigd, dan heeft gebeurtenis 'a-nummer-gewijzigd' plaatsgevonden

    Scenario: Twee personen met hetzelfde A-nummer op de persoonslijsten wordt opgelost door wijzigen van het A-nummer
      Gegeven 'Gemeente Amsterdam' heeft de persoonslijst voor 'Jan' met A-nummer 9000000001 en burgerservicenummer 000000012
      En 'RNI' heeft de persoonslijst voor 'Piet' met A-nummer 9000000001 en burgerservicenummer 000000024 die door BRP-V geweigerd wordt
      Als op de persoonslijst van 'Jan' met A-nummer 9000000001 het A-nummer wordt gewijzigd naar 9000000002 en vorig A-nummer 9000000001 wordt ingevuld
      Dan is een 'a-nummer-gewijzigd' gebeurtenis gepubliceerd
  
    Scenario: Dubbelinschrijving wordt opgelost waarbij Vorig A-nummer wordt gevuld, maar het A-nummer niet wijzigt
      Gegeven 'Gemeente Amsterdam' heeft de persoonslijst voor 'Jan' met A-nummer 9000000001 en burgerservicenummer 000000012
      En 'RNI' heeft de persoonslijst voor 'Jan' met A-nummer 9000000002 en burgerservicenummer 000000024
      Als de dubbelschrijving van 'Jan' wordt opgelost 
      * op de overblijvende persoonslijst met A-nummer 9000000001 wordt 'vorig A-nummer' 9000000002 ingevuld
      Dan is er geen 'a-nummer-gewijzigd' gebeurtenis gepubliceerd

  Regel: Bij gebeurtenistype 'a-nummer-gewijzigd' wordt het nieuwe A-nummer van de persoon meegeleverd en het vorig A-nummer

    Scenario: Het A-nummer op de persoonslijst is gewijzigd
      Gegeven 'Gemeente Amsterdam' heeft de persoonslijst voor 'Jan' met A-nummer 9000000001 en burgerservicenummer 000000012
      Als op de persoonslijst van 'Jan' met A-nummer 9000000001 het A-nummer wordt gewijzigd naar 9000000002 en vorig A-nummer 9000000001 wordt ingevuld
      Dan is een 'a-nummer-gewijzigd' gebeurtenis gepubliceerd met de volgende data
      * A-nummer 9000000002
      * vorig A-nummer 9000000001
