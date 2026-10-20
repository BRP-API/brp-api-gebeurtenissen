# language: nl
Functionaliteit: Gebeurtenis wanneer het burgerservicenummer van een persoon wijzigt door oplossen dubbelinschrijving
  Als abonnee wil ik het weten wanneer het burgerservicenummer van een persoon wijzigt,
  zodat ik het juiste burgerservicenummer kan gebruiken voor mijn dienstverlening.

  Zie https://www.rvig.nl/hup/wijzigen-administratienummer

  Een burgerservicenummer kan wijzigen om verschillende redenen:
  1. het burgerservicenummer wordt wijzigd, bijvoorbeeld omdat het burgerservicenummer dubbel was uitgegeven.
  2. er zijn twee persoonslijsten van één persoon (dubbelinschrijving): op de overbodig geworden persoonslijst wordt een verwijzing opgenomen naar de overblijvende persoonslijst met een ander burgerservicenummer

  De 1e reden leidt tot gebeurtenistype 'burgerservicenummer-gewijzigd'. Zie burgerservicenummer-gewijzigd.feature.
  De 2e reden leidt tot gebeurtenistype 'dubbelinschrijving-opgelost.burgerservicenummer-gewijzigd'.
  
  De gebeurtenis 'dubbelinschrijving-opgelost.burgerservicenummer-gewijzigd' kan worden afgeleid van gebeurtenis 'dubbelinschrijving-opgelost.a-nummer-gewijzigd'.
  Hier is de persoonslijst waarop Volgend A-nummer wordt gevuld overbodig geworden.
  De persoonslijst waarnaar verwezen wordt met Volgend A-nummer is overgebleven.
  Als het burgerservicenummer (01.01.20) op de overgebleven persoonslijst anders is dan het burgerservicenummer op de overbodig geworden persoonslijst, dan is sprake van 'dubbelinschrijving-opgelost.burgerservicenummer-gewijzigd'.

  Achtergrond:
    Gegeven de persoon 'Jan' is geregistreerd in de BRP
    En het overlijden van 'Jan' is verwerkt
    En groep 'client' bij abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft gebeurtenistype 'nl.brp.dubbelinschrijving-opgelost.burgerservicenummer-gewijzigd'
    En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'client'

  Regel: Als het volgend A-nummer verwijst naar een persoonslijst met een ander burgerservicenummer, dan heeft gebeurtenis 'dubbelinschrijving-opgelost.burgerservicenummer-gewijzigd' plaatsgevonden

    Scenario: Dubbelinschrijving wordt opgelost waarbij Volgend A-nummer wordt gevuld en de overblijvende persoonslijst heeft een ander burgerservicenummer
      Gegeven 'Gemeente Amsterdam' heeft de persoonslijst voor 'Jan' met A-nummer 9000000001 en burgerservicenummer 000000012
      En 'RNI' heeft de persoonslijst voor 'Jan' met A-nummer 9000000002 en burgerservicenummer 000000024
      En er is een 'nl.brp.dubbelinschrijving-opgelost.a-nummer-gewijzigd' gebeurtenis gepubliceerd voor persoon 'Jan'
      En de dubbelschrijving van 'Jan' is opgelost 
      * op de overbodig geworden persoonslijst met A-nummer 9000000002 wordt 'volgend A-nummer' 9000000001 ingevuld
      Dan is een 'dubbelinschrijving-opgelost.burgerservicenummer-gewijzigd' gebeurtenis gepubliceerd

  Regel: Bij gebeurtenistype 'dubbelinschrijving-opgelost.burgerservicenummer-gewijzigd' wordt het burgerservicenummer van de persoon meegeleverd en het nieuwe burgerservicenummer

    Scenario: Dubbelinschrijving wordt opgelost waarbij Volgend A-nummer wordt gevuld op de overbodig geworden persoonslijst
      Gegeven 'Gemeente Amsterdam' heeft de persoonslijst voor 'Jan' met A-nummer 9000000001 en burgerservicenummer 000000012
      En 'RNI' heeft de persoonslijst voor 'Jan' met A-nummer 9000000002 en burgerservicenummer 000000024
      Als de dubbelschrijving van 'Jan' wordt opgelost 
      * op de overbodig geworden persoonslijst met A-nummer 9000000002 wordt 'volgend A-nummer' 9000000001 ingevuld
      Dan is een 'burgerservicenummer-gewijzigd' gebeurtenis gepubliceerd met de volgende data
      * burgerservicenummer 000000024
      * nieuw burgerservicenummer '000000012'
