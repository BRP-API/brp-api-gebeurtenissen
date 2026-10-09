# language: nl
Functionaliteit: Gebeurtenis wanneer een persoon vertrekt met onbekende verblijfplaats
  Wanneer een persoon ambtshalve wordt uitgeschreven, is de verblijfplaats van de persoon niet bekend.

  In dit geval krijgt bij de nieuwe verblijfplaats het land adres buitenland de standaardwaarde 0000 (Onbekend).

  Achtergrond:
    Gegeven het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    En de persoon 'Jan'
    * verblijft vanaf '14-04-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'

  Regel: Als de verblijfplaats wijzigt van een adres in Nederland naar naar een onbekend land, heeft de gebeurtenis 'verhuisd.vertrokken-onbekend-waarheen' plaatsgevonden

    Scenario: De persoon is vertrokken naar een onbekende verblijfplaats
      Als de aangifte van vertrek naar het buitenland van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2026' in een onbekend land
      Dan is een 'verhuisd.vertrokken-onbekend-waarheen' gebeurtenis gepubliceerd

  Regel: Bij gebeurtenistype 'verhuisd.vertrokken-onbekend-waarheen' wordt het A-nummer van de persoon meegeleverd plus de datum aanvang van het betreffende verblijf
    De datum aanvang waar hier op gedoeld wordt is de datum aanvang verblijf buitenland.

    Scenario: De persoon is vertrokken naar een onbekende verblijfplaats
      Als 'Jan' ambtshalve is uitgeschreven
      * verblijft vanaf '1-9-2026' in een onbekend land
      Dan is een 'verhuisd.vertrokken-onbekend-waarheen' gebeurtenis gepubliceerd met de volgende data
      * het A-nummer 'Jan'
      * datum aanvang verblijf buitenland '1-9-2026'

  Regel: Als het onbekende adres (land) wordt geregistreerd na een Ministerieel Besluit, heeft de gebeurtenis 'verhuisd.vertrokken-onbekend-waarheen' NIET plaatsgevonden
    Een Ministerieel Besluit is een melding van de Minister van Buitenlandse Zaken dat een persoon niet langer als ingezetene ingeschreven mag zijn.
    In dat geval wordt er ook een onbekende verblijfplaats geregistreerd, maar is geen sprake van vertrokken onbekend waarheen.
    
    In dit geval is/wordt de persoonslijst opgeschort met reden Ministerieel besluit.

    Scenario: Het ministerie van Buitenlandse Zaken heeft aangegeven dat de persoon niet langer als ingezetene ingeschreven mag zijn
      Als een Ministerieel Besluit voor 'Jan' is verwerkt
      * verblijft vanaf '1-9-2026' in een onbekend land
      Dan is geen 'verhuisd.vertrokken-onbekend-waarheen' gebeurtenis gepubliceerd
