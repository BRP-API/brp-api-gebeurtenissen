# language: nl
Functionaliteit: Gebeurtenis wanneer een dubbelinschrijving is opgelost voor de persoon
  Als abonnee wil ik het weten wanneer er een dubbelinschrijving was,
  zodat ik een onderzoek kan starten naar de consequenties van de dubbelinschrijving op mijn dienstverlening.

  Bij een dubbelinschrijving waren er 2 persoonslijsten voor 1 persoon.
  Eén van de persoonslijsten wordt dan afgevoerd, de andere persoonslijst blijft over.

  De gebeurtenis 'dubbelinschrijving-opgelost.overblijvende-persoonslijst' wordt geleverd op de overblijvende persoonslijst.
  
  De gebeurtenis 'dubbelinschrijving-opgelost.overblijvende-persoonslijst' is te herkennen aan het vullen van Vorig A-nummer (01.20.10) waarbij het A-nummer op de persoonslijst zelf niet wijzigt.

  Opmerking: Deze gebeurtenis hoeft niet aan abonnees te worden gemeld.
  Verschillen tussen de overbodig geworden PL en de overblijvende PL zijn door actualiseringen en correcties opgelost op de overblijvende PL.
  Hiervan zijn al gebeurtenissen verzonden aan abonnees.

  Regel: Als een verwijzing naar een vorig A-nummer is opgenomen, dan heeft gebeurtenis 'dubbelinschrijving-opgelost.overblijvende-persoonslijst' plaatsgevonden

    Scenario: Dubbelinschrijving met verschillende A-nummers op de persoonslijsten wordt opgelost
      Gegeven 'Gemeente Amsterdam' heeft de persoonslijst voor 'Jan' met A-nummer 9000000001 en burgerservicenummer 000000012
      En 'RNI' heeft de persoonslijst voor 'Jan' met A-nummer 9000000002 en burgerservicenummer 000000024
      Als de dubbelschrijving van 'Jan' wordt opgelost 
      * op de overblijvende persoonslijst met A-nummer 9000000001 wordt 'vorig A-nummer' 9000000002 ingevuld
      Dan is een 'dubbelinschrijving-opgelost.overblijvende-persoonslijst' gebeurtenis gepubliceerd

    Scenario: Dubbelinschrijving met hetzelfde A-nummer op de persoonslijsten wordt opgelost
      Gegeven 'Gemeente Amsterdam' heeft de persoonslijst voor 'Jan' met A-nummer 9000000001 en burgerservicenummer 000000012
      En 'RNI' heeft de persoonslijst voor 'Jan' met A-nummer 9000000001 en burgerservicenummer 000000024 die door BRP-V geweigerd wordt
      Als de dubbelschrijving van 'Jan' wordt opgelost 
      * op de overblijvende persoonslijst met A-nummer 9000000001 wordt 'vorig A-nummer' 9000000001 ingevuld
      Dan is een 'dubbelinschrijving-opgelost.overblijvende-persoonslijst' gebeurtenis gepubliceerd

    Scenario: Twee personen met hetzelfde A-nummer op de persoonslijsten wordt opgelost door wijzigen van het A-nummer
      Gegeven 'Gemeente Amsterdam' heeft de persoonslijst voor 'Jan' met A-nummer 9000000001 en burgerservicenummer 000000012
      En 'RNI' heeft de persoonslijst voor 'Piet' met A-nummer 9000000001 en burgerservicenummer 000000024 die door BRP-V geweigerd wordt
      Als op de persoonslijst van 'Jan' met A-nummer 9000000001 het A-nummer wordt gewijzigd naar 9000000002 en vorig A-nummer 9000000001 wordt ingevuld
      Dan is er geen 'dubbelinschrijving-opgelost.overblijvende-persoonslijst' gebeurtenis gepubliceerd

  Regel: Bij gebeurtenistype 'dubbelinschrijving-opgelost.overblijvende-persoonslijst' wordt het A-nummer van de persoon meegeleverd en het vorig A-nummer

    Scenario: Dubbelinschrijving met verschillende A-nummers op de persoonslijsten wordt opgelost
      Gegeven 'Gemeente Amsterdam' heeft de persoonslijst voor 'Jan' met A-nummer 9000000001 en burgerservicenummer 000000012
      En 'RNI' heeft de persoonslijst voor 'Jan' met A-nummer 9000000002 en burgerservicenummer 000000024
      Als de dubbelschrijving van 'Jan' wordt opgelost 
      * op de overblijvende persoonslijst met A-nummer 9000000001 wordt 'vorig A-nummer' 9000000002 ingevuld
      Dan is een 'dubbelinschrijving-opgelost.overblijvende-persoonslijst' gebeurtenis gepubliceerd met de volgende data
      * A-nummer 9000000001
      * vorig A-nummer 9000000002
