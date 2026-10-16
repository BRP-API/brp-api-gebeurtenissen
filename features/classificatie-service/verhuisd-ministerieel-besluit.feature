# language: nl
Functionaliteit: Gebeurtenis wanneer een melding van de Minister van Buitenlandse Zaken dat een persoon niet langer als ingezetene ingeschreven mag zijn is verwerkt
  Als abonnee wil ik weten dat vanuit een ministerieel besluit de persoon niet langer als ingezetene ingeschreven is,
  zodat ik een onderzoek kan starten naar de consequenties van dit onderzoek op mijn dienstverlening.
  
  Een Ministerieel Besluit is een melding van de Minister van Buitenlandse Zaken dat een persoon niet langer als ingezetene ingeschreven mag zijn.
    
  Zie https://www.rvig.nl/hup/emigratie#toc-emigratie--a8dvKHqm

  In dit geval is de persoonslijst opgeschort met reden Ministerieel besluit (M).

  In de gebeurtenis wordt de identificatie - het A-nummer - van de betreffende persoon
  en de datum aanvang verblijf buitenland (08.13.20) opgenomen.

  Regel: Als wordt geregistreerd als gevolg van een Ministerieel Besluit, heeft de gebeurtenis 'verhuisd.ministerieel-besluit' plaatsgevonden

    Scenario: Het ministerie van Buitenlandse Zaken heeft aangegeven dat de persoon niet langer als ingezetene ingeschreven mag zijn
      Als een Ministerieel Besluit voor 'Jan' is verwerkt
      * verblijft vanaf '1-9-2026' in een onbekend land
      * opschorting bijhouding reden is 'Ministerieel besluit'
      Dan is een 'verhuisd.ministerieel-besluit' gebeurtenis gepubliceerd

  Regel: Bij gebeurtenistype 'ministerieel-besluit' wordt het A-nummer van de persoon meegeleverd plus de datum aanvang van het betreffende verblijf
    De datum aanvang waar hier op gedoeld wordt is de datum aanvang verblijf buitenland.

    Scenario: Het ministerie van Buitenlandse Zaken heeft aangegeven dat de persoon niet langer als ingezetene ingeschreven mag zijn
      Als een Ministerieel Besluit voor 'Jan' is verwerkt
      * verblijft vanaf '1-9-2026' in een onbekend land
      * opschorting bijhouding reden is 'Ministerieel besluit'
      Dan is een 'verhuisd.ministerieel-besluit' gebeurtenis gepubliceerd met de volgende data
      * het A-nummer 'Jan'
      * datum aanvang verblijf buitenland '1-9-2026'