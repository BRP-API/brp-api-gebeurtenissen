# language: nl
Functionaliteit: Gebeurtenissen bevragen waar de abonnee op geabonneerd is
  Als consumer van BRP Gebeurtenissen
  wil ik bij het bevragen van gebeurtenissen kunnen opgeven welke gebeurtenissen ik wil ontvangen
  zodat ik asynchroon de gebeurtenissen waarop ik ben geabonneerd kan verwerken

  Achtergrond:
    Gegeven de persoon 'Jan'
    En de persoon 'Piet'
    En de persoon 'Karin'

  Regel: Als er voor de abonnee geen gebeurtenissen zijn, krijgt hij geen gebeurtenissen

    Scenario: Er is nog geen gebeurtenis voor de abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'client'
      Als gebeurtenissen worden gevraagd door abonnee 'jz'
      Dan wordt er geen gebeurtenis geleverd

  Regel: Een abonnee ontvangt alleen gebeurtenissen waar deze op geabonneerd is
    Dit is het geval wanneer er een gebeurtenis plaatsvindt en er is een abonnement
    - van de abonnee die gebeurtenissen vraagt
    - op de persoon waar de gebeurtenis op heeft plaatsgevonden
    - voor een groep met het type van de gebeurtenis

    Scenario: De abonnee is geabonneerd op de gebeurtenis
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'client'
      En er is een 'nl.brp.verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor persoon 'Jan'
      Als gebeurtenissen worden gevraagd door abonnee 'jz'
      Dan wordt de 'nl.brp.verhuisd.intergemeentelijk' gebeurtenis van 'Jan' geleverd

    Scenario: De abonnee is geabonneerd op een ander gebeurtenistype
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'client'
      En er is een 'nl.brp.verhuisd.naar-buitenland' gebeurtenis gepubliceerd voor persoon 'Jan'
      Als gebeurtenissen worden gevraagd door abonnee 'jz'
      Dan wordt er geen gebeurtenis geleverd

    Scenario: De abonnee is geabonneerd op een andere persoon
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'client'
      En er is een 'nl.brp.verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor persoon 'Piet'
      Als gebeurtenissen worden gevraagd door abonnee 'jz'
      Dan wordt er geen gebeurtenis geleverd

    Scenario: Een andere abonnee is geabonneerd op de gebeurtenis
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      En de afnemer 'Gemeente Amsterdam' heeft de abonnee 'szw' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.naar-buitenland'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'client'
      En er is een 'nl.brp.verhuisd.naar-buitenland' gebeurtenis gepubliceerd voor persoon 'Jan'
      Als gebeurtenissen worden gevraagd door abonnee 'jz'
      Dan wordt er geen gebeurtenis geleverd

    Scenario: Een andere abonnementgroep van de abonnee bevat het gebeurtenistype
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      * met groep 'relatie' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.naar-buitenland'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'client'
      En er is een 'nl.brp.verhuisd.naar-buitenland' gebeurtenis gepubliceerd voor persoon 'Jan'
      Als gebeurtenissen worden gevraagd door abonnee 'jz'
      Dan wordt er geen gebeurtenis geleverd

  Regel: Meerdere abonnees kunnen dezelfde gebeurtenis ontvangen

    Scenario: De abonnee vraagt ongelezen gebeurtenissen en een andere abonnee heeft ook een abonnement op dezelfde gebeurtenis
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      En de afnemer 'Gemeente Amsterdam' heeft de abonnee 'szw' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      En er is een 'nl.brp.verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor persoon 'Jan'
      Als gebeurtenissen worden gevraagd door abonnee 'jz'
      Dan wordt de 'nl.brp.verhuisd.intergemeentelijk' gebeurtenis van 'Jan' geleverd

    Scenario: De abonnee vraagt ongelezen gebeurtenissen en een andere abonnee heeft dezelfde gebeurtenis al ontvangen
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      En de afnemer 'Gemeente Amsterdam' heeft de abonnee 'szw' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      En er is een 'nl.brp.verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor persoon 'Jan'
      En gebeurtenissen zijn gevraagd door abonnee 'jz'
      Als gebeurtenissen worden gevraagd door abonnee 'szw'
      Dan wordt de 'nl.brp.verhuisd.intergemeentelijk' gebeurtenis van 'Jan' geleverd

  Regel: Een abonnee ontvangt alleen gebeurtenissen die hebben plaatsgevonden na het plaatsen van het abonnement daarop

    Scenario: De gebeurtenis heeft plaatsgevonden vóór het abonnement werd gezet
      Gegeven er is een 'nl.brp.verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor persoon 'Jan'
      En de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'client'
      Als gebeurtenissen worden gevraagd door abonnee 'jz'
      Dan wordt er geen gebeurtenis geleverd

  Regel: Een abonnee ontvangt ook gebeurtenissen die hebben plaatsgevonden na het toevoegen van het gebeurtenistype aan de groep waarvoor de persoon geabonneerd is

    Scenario: Een afnemer voegt een gebeurtenistype toe aan een groep waar al een abonnement op bestaat en daarna vindt de gebeurtenis plaats
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'client'
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' gebeurtenistype 'nl.brp.verhuisd.naar-buitenland' toegevoegd aan de groep 'client'
      En er is een 'nl.brp.verhuisd.naar-buitenland' gebeurtenis gepubliceerd voor persoon 'Jan'
      Als gebeurtenissen worden gevraagd door abonnee 'jz'
      Dan wordt de 'nl.brp.verhuisd.naar-buitenland' gebeurtenis van 'Jan' geleverd

    Scenario: Een afnemer voegt een gebeurtenistype toe aan een groep waar al een abonnement op bestaat en daarvoor vond de gebeurtenis plaats
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'client'
      En er is een 'nl.brp.verhuisd.naar-buitenland' gebeurtenis gepubliceerd voor persoon 'Jan'
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' gebeurtenistype 'nl.brp.verhuisd.naar-buitenland' toegevoegd aan de groep 'client'
      Als gebeurtenissen worden gevraagd door abonnee 'jz'
      Dan wordt er geen gebeurtenis geleverd

  Regel: Een abonnee ontvangt geen gebeurtenissen die hebben plaatsgevonden nadat het abonnement is opgezegd

    Scenario: Het abonnement van de persoon is beëindigd voor de gebeurtenis
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'client'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft de abonnementen van de persoon 'Jan' opgezegd
      En er is een 'nl.brp.verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor persoon 'Jan'
      Als gebeurtenissen worden gevraagd door abonnee 'jz'
      Dan wordt er geen gebeurtenis geleverd

    Scenario: Het abonnement van de persoon op een groep is beëindigd voor de gebeurtenis
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      * met groep 'relatie' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.naar-buitenland'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'client'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'relatie'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft het abonnement van de persoon 'Jan' opgezegd voor de groep 'client'
      En er is een 'nl.brp.verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor persoon 'Jan'
      Als gebeurtenissen worden gevraagd door abonnee 'jz'
      Dan wordt er geen gebeurtenis geleverd

  Regel: Als een abonnee het abonnement opzegt van een persoon op een groep, dan heeft dit geen effect op de abonnementen op de persoon voor een andere groep

    Scenario: Het abonnement van de persoon op een groep is beëindigd voor de gebeurtenis en voor de persoon is nog een ander abonnement voor een groep met hetzelfde gebeurtenistype
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      * met groep 'relatie' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'client'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'relatie'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft het abonnement van de persoon 'Jan' opgezegd voor de groep 'client'
      En er is een 'nl.brp.verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor persoon 'Jan'
      Als gebeurtenissen worden gevraagd door abonnee 'jz'
      Dan wordt de 'nl.brp.verhuisd.intergemeentelijk' gebeurtenis van 'Jan' geleverd

  Regel: Een abonnee ontvangt geen gebeurtenissen die hebben plaatsgevonden nadat de groep is verwijderd waarvoor de persoon geabonneerd is

    Scenario: Bij de abonnee is de groep verwijderd voor de gebeurtenis
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      * met groep 'relatie' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'relatie'
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'relatie' verwijderd
      En er is een 'nl.brp.verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor persoon 'Jan'
      Als gebeurtenissen worden gevraagd door abonnee 'jz'
      Dan wordt er geen gebeurtenis geleverd

  Regel: Een abonnee ontvangt geen gebeurtenissen die hebben plaatsgevonden nadat het gebeurtenistype is verwijderd van de groep waarvoor de persoon geabonneerd is

    Scenario: Het gebeurtenistype is uit de groep verwijderd voor de gebeurtenis
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk' en 'nl.brp.verhuisd.naar-buitenland'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'client'
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk' verwijderd uit de groep 'client'
      En er is een 'nl.brp.verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor persoon 'Jan'
      Als gebeurtenissen worden gevraagd door abonnee 'jz'
      Dan wordt er geen gebeurtenis geleverd

  Regel: Als een afnemer een gebeurtenistype verwijdert uit een groep van een abonnee, dan heeft dit geen effect op abonnementen op de andere groepen

    Scenario: Het gebeurtenistype is uit de groep verwijderd voor de gebeurtenis
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk' en 'nl.brp.verhuisd.naar-buitenland'
      * met groep 'relatie' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk' en 'nl.brp.overleden'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'client'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'relatie'
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk' verwijderd uit de groep 'client'
      En er is een 'nl.brp.verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor persoon 'Jan'
      Als gebeurtenissen worden gevraagd door abonnee 'jz'
      Dan wordt de 'nl.brp.verhuisd.intergemeentelijk' gebeurtenis van 'Jan' geleverd

  Regel: Een abonnee ontvangt gebeurtenissen die hebben plaatsgevonden voor het abonnement daarop is beëindigd

    Scenario: Het abonnement van de persoon is beëindigd na de gebeurtenis
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'client'
      En er is een 'nl.brp.verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor persoon 'Jan'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft de abonnementen van de persoon 'Jan' opgezegd
      Als gebeurtenissen worden gevraagd door abonnee 'jz'
      Dan wordt de 'nl.brp.verhuisd.intergemeentelijk' gebeurtenis van 'Jan' geleverd

    Scenario: Bij de abonnee is de groep verwijderd na de gebeurtenis
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      * met groep 'relatie' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'relatie'
      En er is een 'nl.brp.verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor persoon 'Jan'
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'relatie' verwijderd
      Als gebeurtenissen worden gevraagd door abonnee 'jz'
      Dan wordt de 'nl.brp.verhuisd.intergemeentelijk' gebeurtenis van 'Jan' geleverd

    Scenario: Het gebeurtenistype is uit de groep verwijderd na de gebeurtenis
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk' en 'nl.brp.verhuisd.naar-buitenland'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'client'
      En er is een 'nl.brp.verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor persoon 'Jan'
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk' verwijderd uit de groep 'client'
      Als gebeurtenissen worden gevraagd door abonnee 'jz'
      Dan wordt de 'nl.brp.verhuisd.intergemeentelijk' gebeurtenis van 'Jan' geleverd

  Regel: Een abonnee ontvangt gebeurtenissen op volgorde dat ze gepubliceerd zijn

    Scenario: Er zijn meerdere gebeurtenissen
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'client'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Piet' voor de groep 'client'
      En er is een 'nl.brp.verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor persoon 'Jan'
      En er is een 'nl.brp.verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor persoon 'Piet'
      Als gebeurtenissen worden gevraagd door abonnee 'jz'
      Dan worden gebeurtenissen geleverd in de volgende volgorde:
      * de 'nl.brp.verhuisd.intergemeentelijk' gebeurtenis van 'Jan'
      * de 'nl.brp.verhuisd.intergemeentelijk' gebeurtenis van 'Piet'
