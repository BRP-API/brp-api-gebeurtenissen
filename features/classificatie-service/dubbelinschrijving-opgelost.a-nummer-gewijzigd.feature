# language: nl
Functionaliteit: Gebeurtenis wanneer het A-nummer van een persoon wijzigt door oplossen dubbelinschrijving
  Als abonnee wil ik het weten wanneer het A-nummer van een persoon wijzigt,
  zodat ik het juiste A-nummer kan gebruiken voor mijn dienstverlening.

  Zie https://www.rvig.nl/hup/wijzigen-administratienummer

  Een A-nummer kan wijzigen om verschillende redenen:
  1. er zijn persoonslijsten van twee personen met hetzelfde A-nummer: op beide persoonslijsten (voor beide personen) wordt het A-nummer gewijzigd.
  2. er zijn twee persoonslijsten van één persoon (dubbelinschrijving): op de overbodig geworden persoonslijst wordt een verwijzing opgenomen naar de overblijvende persoonslijst.

  De 1e reden leidt tot gebeurtenistype 'a-nummer-gewijzigd'. Zie a-nummer-gewijzigd.feature.
  De 2e reden leidt tot gebeurtenistype 'dubbelinschrijving-opgelost.a-nummer-gewijzigd'.
  
  De gebeurtenis 'dubbelinschrijving-opgelost.a-nummer-gewijzigd' is te herkennen aan het vullen van Volgend A-nummer (01.20.20) waarbij het A-nummer op de persoonslijst zelf niet wijzigt en Volgend A-nummer is ongelijk aan A-nummer.

  Regel: Als een verwijzing naar een volgend A-nummer wordt opgenomen met een waarde ongelijk aan het A-nummer, dan heeft gebeurtenis 'dubbelinschrijving-opgelost.a-nummer-gewijzigd' plaatsgevonden

    Scenario: Dubbelinschrijving wordt opgelost waarbij Volgend A-nummer wordt gevuld op de overbodig geworden persoonslijst
      Gegeven 'Gemeente Amsterdam' heeft de persoonslijst voor 'Jan' met A-nummer 9000000001 en burgerservicenummer 000000012
      En 'RNI' heeft de persoonslijst voor 'Jan' met A-nummer 9000000002 en burgerservicenummer 000000024
      Als de dubbelschrijving van 'Jan' wordt opgelost 
      * op de overbodig geworden persoonslijst met A-nummer 9000000002 wordt 'volgend A-nummer' 9000000001 ingevuld
      Dan is een 'dubbelinschrijving-opgelost.a-nummer-gewijzigd' gebeurtenis gepubliceerd

  Regel: Bij gebeurtenistype 'dubbelinschrijving-opgelost.a-nummer-gewijzigd' wordt het A-nummer van de persoon meegeleverd en het volgend A-nummer

    Scenario: Dubbelinschrijving wordt opgelost waarbij Volgend A-nummer wordt gevuld op de overbodig geworden persoonslijst
      Gegeven 'Gemeente Amsterdam' heeft de persoonslijst voor 'Jan' met A-nummer 9000000001 en burgerservicenummer 000000012
      En 'RNI' heeft de persoonslijst voor 'Jan' met A-nummer 9000000002 en burgerservicenummer 000000024
      Als de dubbelschrijving van 'Jan' wordt opgelost 
      * op de overbodig geworden persoonslijst met A-nummer 9000000002 wordt 'volgend A-nummer' 9000000001 ingevuld
      Dan is een 'a-nummer-gewijzigd' gebeurtenis gepubliceerd met de volgende data
      * A-nummer 9000000002
      * volgend A-nummer 9000000001
