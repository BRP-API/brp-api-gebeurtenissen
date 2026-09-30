# language: nl
Functionaliteit: Gebeurtenis wanneer een melding van de Minister van Buitenlandse Zaken dat een persoon niet langer als ingezetene ingeschreven mag zijn is verwerkt

  Regel: Als wordt geregistreerd als gevolg van een Ministerieel Besluit, heeft de gebeurtenis 'verhuisd.ministerieel-besluit' plaatsgevonden
    Een Ministerieel Besluit is een melding van de Minister van Buitenlandse Zaken dat een persoon niet langer als ingezetene ingeschreven mag zijn.
    
    In dit geval is/wordt de persoonslijst opgeschort met reden Ministerieel besluit.

    Scenario: Het ministerie van Buitenlandse Zaken heeft aangegeven dat de persoon niet langer als ingezetene ingeschreven mag zijn
      Als een Ministerieel Besluit voor 'Jan' is verwerkt
      * verblijft vanaf '1-9-2026' in een onbekend land
      Dan is geen 'verhuisd.ministerieel-besluit' gebeurtenis gepubliceerd
