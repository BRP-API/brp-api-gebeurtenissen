# language: nl
Functionaliteit: Gebeurtenis wanneer een persoon vertrekt met onbekende verblijfplaats
  Dit is het geval wanneer bij de nieuwe verblijfplaats het land adres buitenland de standaardwaarde 0000 (Onbekend) krijgt.

  Achtergrond:
    Gegeven het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    En de persoon 'Jan'
    * verblijft vanaf '14-04-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'

  Regel: Als de verblijfplaats wijzigt van een adres in Nederland naar naar een onbekend land, heeft de gebeurtenis 'verhuisd.vertrokken-onbekend-waarheen' plaatsgevonden

    Scenario: De persoon is vertrokken naar een onbekende verblijfplaats
      Als de aangifte van vertrek naar het buitenland van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2026' in een onbekend land
      Dan is een 'verhuisd.vertrokken-onbekend-waarheen' gebeurtenis gepubliceerd

  Regel: Als het onbekende adres (land) wordt geregistreerd na een Ministerieel Besluit, heeft de gebeurtenis 'verhuisd.vertrokken-onbekend-waarheen' NIET plaatsgevonden
    Een Ministerieel Besluit is een melding van de Minister van Buitenlandse Zaken dat een persoon niet langer als ingezetene ingeschreven mag zijn.
    
    In dit geval is/wordt de persoonslijst opgeschort met reden Ministerieel besluit.

    Scenario: Het ministerie van Buitenlandse Zaken heeft aangegeven dat de persoon niet langer als ingezetene ingeschreven mag zijn
      Als een Ministerieel Besluit voor 'Jan' is verwerkt
      * verblijft vanaf '1-9-2026' in een onbekend land
      Dan is geen 'verhuisd.vertrokken-onbekend-waarheen' gebeurtenis gepubliceerd
