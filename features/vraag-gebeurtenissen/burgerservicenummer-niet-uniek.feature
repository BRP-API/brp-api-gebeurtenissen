# language: nl
Functionaliteit: Gebeurtenissen wanneer burgerservicenummer niet meer uniek is in de BRP
  Soms kan - als het goed is tijdelijk - het burgerservicenummer niet meer uniek zijn in de BRP.
  Het burgerservicenummer komt dan voor op meerdere persoonslijsten.
  Dit kan betekenen dat er sprake is van dubbelinschrijving, waarbij voor één persoon er meerdere persoonslijsten bestaan.
  Dit kan ook betekenen dat het burgerservicenummerten onrechte meerdere keren is gebruikt voor verschillende personen.

  Als dit het geval is, staan we abonneren hierop niet toe. Zie /beheer-abonnementen/burgerservicenummer-niet-uniek.feature.
      
  Het is ook mogelijk dat deze situatie ontstaat nadat het abonnement gezet is.
  Het is dan niet goed mogelijk met zekerheid te bepalen bij welke persoonslijst, dus welk abonnement, een gebeurtenis hoort.
  We weten niet met zekerheid of de twee persoonslijsten één persoon betreffen of twee verschillende personen.
  Bovendien kan de abonnee de gegevens die daarbij horen dan niet ophalen in de personen bevragen API.
  Consequentie daarvan is dat de abonnee gebeurtenissen op een persoon gaat missen.
  We moeten dit daarom aan de abonnee laten weten in de vorm van een gebeurtenis.
  # Kunnen we met voldoende zekerheid aannames hierover maken zodat we wel "normaal" gebeurtenissen kunnen leveren?
  # Bijvoorbeeld als A-nummer zelfde én burgerservicenummer zelfde, dan betreft het één persoon.
  # In dat geval moeten we ook iets aan de personen bevragen API doen om alsnog gegevens te leveren.

  Achtergrond:
    Gegeven de persoon 'Jan' is geregistreerd in de BRP
    * met 'burgerservicenummer' is '000000012'
    * met 'A-nummer' is '9000000001'
    En de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
    En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
    En groep 'client' bij abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk en nl.brp.verhuisd.naar-buitenland'
    En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'client'

  Regel: Als er een tweede persoonslijst met hetzelfde burgerservicenummer ontstaat voor een persoon waar een abonnement op bestaat, dan ...
    # Hoe communiceren we dit aan de abonnee? burgerservicenummer.niet-uniek, gebeurtenissen.geblokkeerd, ...

    Scenario: Er ontstaat dubbelinschrijving voor dezelfde persoon met hetzelfde burgerservicenummer en hetzelfde A-nummer
      Gegeven de persoon 'tweede persoonslijst van Jan' is geregistreerd in de BRP
      * met 'burgerservicenummer' is '000000012'
      * met 'A-nummer' is '9000000001'
      Als gebeurtenissen worden gevraagd door abonnee 'jz' van afnemer 'Gemeente Amsterdam'
      Dan ...

    Scenario: Het burgerservicenummer wordt gebruikt voor een andere persoon
      Gegeven de persoon 'Piet' is geregistreerd in de BRP
      * met 'burgerservicenummer' is '000000012'
      * met 'A-nummer' is '9000000002'
      Als gebeurtenissen worden gevraagd door abonnee 'jz' van afnemer 'Gemeente Amsterdam'
      Dan ...

  Regel: Als er een tweede persoonslijst met hetzelfde A-nummer ontstaat voor een persoon waar een abonnement op bestaat, dan ...

    Scenario: Er ontstaat dubbelinschrijving voor dezelfde persoon met hetzelfde A-nummer en een ander burgerservicenummer
      Gegeven de persoon 'tweede persoonslijst van Jan' is geregistreerd in de BRP
      * met 'burgerservicenummer' is '000000024'
      * met 'A-nummer' is '9000000001'
      Als gebeurtenissen worden gevraagd door abonnee 'jz' van afnemer 'Gemeente Amsterdam'
      Dan ...

  Regel: Als er een gebeurtenis plaatsvindt met een combinatie van A-nummer en burgerservicenummer die op meerdere persoonslijsten voorkomt, dan wordt de gebeurtenis geleverd
    Als er twee persoonslijsten zijn met hetzelfde burgerservicenummer en hetzelfde A-nummer,
    dan kunnen we aannemen dat beide persoonslijsten betrekking hebben op dezelfde persoon,
    en daarom wordt de gebeurtenis geleverd als er een abonnement genomen is op een van deze persoonslijsten (voor een groep met dit gebeurtenistype).

    Scenario: Er zijn twee persoonslijsten met hetzelfde burgerservicenummer en hetzelfde A-nummer en op een daarvan is een gebeurtenis waar een abonnement op is
      Gegeven de persoon 'tweede persoonslijst van Jan' is geregistreerd in de BRP
      * met 'burgerservicenummer' is '000000012'
      * met 'A-nummer' is '9000000001'
      En er is een 'nl.brp.verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor persoon 'tweede persoonslijst van Jan'
      Als gebeurtenissen worden gevraagd door abonnee 'jz' van afnemer 'Gemeente Amsterdam'
      Dan wordt de 'nl.brp.verhuisd.intergemeentelijk' gebeurtenis van 'Jan' geleverd

  Regel: Als er een gebeurtenis plaatsvindt op een persoonslijst met niet-uniek(e) identificatienummer(s), dan wordt de gebeurtenis alleen geleverd wanneer er een abonnement is met de combinatie van A-nummer en burgerservicenummer in de gebeurtenis
    Met de combinatie van A-nummer en burgerservicenummer kan bepaald worden of de gebeurtenis betrekking heeft op een abonnement.

    Als er twee persoonslijsten zijn met verschillend A-nummer en hetzelfde burgerservicenummer, 
    dan is met zekerheid te bepalen op welke persoonslijst de gebeurtenis betrekking heeft,
    en daarom wordt de gebeurtenis alleen geleverd als het abonnement betrekking heeft op die combinatie van A-nummer en burgerservicenummer.

    Als er twee persoonslijsten zijn met verschillend burgerservicenummer en hetzelfde A-nummer, 
    dan is met zekerheid te bepalen op welke persoonslijst de gebeurtenis betrekking heeft,
    en daarom wordt de gebeurtenis alleen geleverd als het abonnement betrekking heeft op die combinatie van A-nummer en burgerservicenummer.

    Scenario: Er zijn twee persoonslijsten met hetzelfde burgerservicenummer en verschillend A-nummer en er is een gebeurtenis waar een abonnement op is
      Gegeven de persoon 'Piet' is geregistreerd in de BRP
      * met 'burgerservicenummer' is '000000012'
      * met 'A-nummer' is '9000000002'
      En er is een 'nl.brp.verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor persoon 'Jan'
      Als gebeurtenissen worden gevraagd door abonnee 'jz' van afnemer 'Gemeente Amsterdam'
      Dan wordt de 'nl.brp.verhuisd.intergemeentelijk' gebeurtenis van 'Jan' geleverd

    Scenario: Er zijn twee persoonslijsten met hetzelfde burgerservicenummer en verschillend A-nummer en er is een gebeurtenis waar geen abonnement op is
      Gegeven de persoon 'Piet' is geregistreerd in de BRP
      * met 'burgerservicenummer' is '000000012'
      * met 'A-nummer' is '9000000002'
      En er is een 'nl.brp.verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor persoon 'Piet'
      Als gebeurtenissen worden gevraagd door abonnee 'jz' van afnemer 'Gemeente Amsterdam'
      Dan wordt er geen gebeurtenis geleverd

    Scenario: Er zijn twee persoonslijsten met hetzelfde A-nummer en een verschillend burgerservicenummer en er is een gebeurtenis waar een abonnement op is
      Gegeven de persoon 'Piet' is geregistreerd in de BRP
      * met 'burgerservicenummer' is '000000024'
      * met 'A-nummer' is '9000000001'
      En er is een 'nl.brp.verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor persoon 'Jan'
      Als gebeurtenissen worden gevraagd door abonnee 'jz' van afnemer 'Gemeente Amsterdam'
      Dan wordt de 'nl.brp.verhuisd.intergemeentelijk' gebeurtenis van 'Jan' geleverd

    Scenario: Er zijn twee persoonslijsten met hetzelfde A-nummer en een verschillend burgerservicenummer en er is een gebeurtenis waar geen abonnement op is
      Gegeven de persoon 'Piet' is geregistreerd in de BRP
      * met 'burgerservicenummer' is '000000024'
      * met 'A-nummer' is '9000000001'
      En er is een 'nl.brp.verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor persoon 'Piet'
      Als gebeurtenissen worden gevraagd door abonnee 'jz' van afnemer 'Gemeente Amsterdam'
      Dan wordt er geen gebeurtenis geleverd
