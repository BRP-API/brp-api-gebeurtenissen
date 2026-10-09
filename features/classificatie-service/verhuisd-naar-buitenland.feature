# language: nl
Functionaliteit: 'verhuisd.naar-buitenland' gebeurtenis
  Bij een aangifte van een verhuizing naar het buitenland, of naar het Caribisch deel van het Koninkrijk heeft een gebeurtenis verhuisd.naar-buitenland plaatsgevonden.
  De gebeurtenis 'verhuisd.naar-buitenland' betekent dat de persoon verhuisd is van een Nederlandse gemeente naar het buitenland of het Caribisch deel van het Koninkrijk.
  
  Wanneer geen aangifte van vertrek is gedaan, maar het vertrek uit Nederland ambthalve is geregistreerd of als gevolg van een Ministerieel Besluit 
  is het niet bekend waar persoon verblijft en is geen sprake van verhuizing naar het buitenland.  

  In de gebeurtenis wordt de identificatie - het A-nummer - van de betreffende persoon in de data opgenomen.
  Daarnaast wordt ook de datum aanvang  verblijf buitenland van de verblijfplaats opgenomen.
  De datum wordt opgenomen, zodat de abonnee de gebeurtenis kan relateren aan een verblijf. De abonnee kan de gebeurtenis namelijk pas verwerken nadat het verblijf al historisch is geworden.

  Achtergrond:
    Gegeven het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    * in gemeente 'Hengelo'
    * met adresseerbaar object identificatie '0164010000047847'
    En de persoon 'Jan'
    * verblijft vanaf '14-4-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    En afnemer 'Roosendaal' is geabonneerd op 'verhuisd.naar-buitenland' gebeurtenissen van de persoon 'Jan'

  Regel: Wanneer een persoon naar het buitenland is verhuisd, dan heeft een gebeurtenis 'verhuisd.naar-buitenland' plaatsgevonden

    Scenario: Aangifte van vertrek naar het buitenland
      Gegeven het adres buitenland 'Chemin_du_Calvaire_19_Lausanne'
      * met adresregel 1 'Chemin de Calvaire 19'
      * met adresregel 2 'Lausanne'
      * met adresregel 3 'Vaud'
      * in land 'Zwitserland'
      Als de aangifte van vertrek naar het buitenland van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2026' op het adres 'Chemin_du_Calvaire_19_Lausanne'
      Dan is een 'verhuisd.naar-buitenland' gebeurtenis gepubliceerd

  Regel: Wanneer een persoon naar het buitenland is verhuisd maar nog geen definitief woonadres heeft, dan heeft een gebeurtenis 'verhuisd.naar-buitenland' plaatsgevonden.

    Scenario: Aangifte van vertrek naar het buitenland en alleen het land is bekend
      Gegeven het adres buitenland 'Adres_in_Zwitserland'
      * zonder adresregels
      * in land 'Zwitserland'
      Als de aangifte van vertrek naar het buitenland van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2026' op 'Adres_in_Zwitserland'
      Dan is een 'verhuisd.naar-buitenland' gebeurtenis gepubliceerd

    Scenario: Aangifte van vertrek naar het buitenland en alleen het land en de plaats zijn bekend
      Gegeven het adres buitenland 'Adres_in_Lausanne'
      * met adresregel 2 'Lausanne'
      * in land 'Zwitserland'
      Als de aangifte van vertrek naar het buitenland van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2026' op 'Adres_in_Lausanne'
      Dan is een 'verhuisd.naar-buitenland' gebeurtenis gepubliceerd

  Regel: Wanneer een persoon naar een Caribisch deel van het Koninkrijk is verhuisd, dan heeft een gebeurtenis 'verhuisd.naar-buitenland' plaatsgevonden.

   Scenario: Aangifte van vertrek naar een eiland dat onderdeel is van het Caribisch deel van het Koninkrijk
      Gegeven het adres buitenland 'KayaGrandi_12_Kralendijk'
      * met adresregel 1 'Kaya Grandi 12'
      * met adresregel 2 'Kralendijk'
      * in land 'Bonaire'
      Als de aangifte van vertrek naar het buitenland van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2026' op adres 'KayaGrandi_12_Kralendijk'
      Dan is een 'verhuisd.naar-buitenland' gebeurtenis gepubliceerd

  Regel: Bij gebeurtenistype 'verhuisd.naar-buitenland' wordt het A-nummer van de persoon meegeleverd plus de datum aanvang van het betreffende verblijf
    De datum aanvang waar hier op gedoeld wordt is de datum aanvang verblijf buitenland.

    Scenario: Aangifte van vertrek naar het buitenland
      Gegeven het adres buitenland 'Chemin_du_Calvaire_19_Lausanne'
      * met adresregel 1 'Chemin de Calvaire 19'
      * met adresregel 2 'Lausanne'
      * met adresregel 3 'Vaud'
      * in land 'Zwitserland'
      Als de aangifte van vertrek naar het buitenland van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2026' op het adres 'Chemin_du_Calvaire_19_Lausanne'
      Dan is een 'verhuisd.naar-buitenland' gebeurtenis gepubliceerd met de volgende data
      * het A-nummer van 'Jan'
      * datum aanvang verblijf buitenland '1-9-2026'

  Regel: Als de persoon ambtshalve is uitgeschreven, heeft de gebeurtenis 'verhuisd.naar-buitenland' NIET plaatsgevonden
    Wanneer een persoon ambtshalve wordt uitgeschreven is de verblijfplaats van de persoon niet bekend.
    In dit geval krijgt bij de nieuwe verblijfplaats het land adres buitenland de standaardwaarde 0000 (Onbekend).

    Scenario: Ambtshalve uitschrijving door registratie van een onbekend adres
      Als de aangifte van vertrek naar het buitenland van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2026' in een onbekend land
      * opschorting bijhouding reden is 'Emigratie'
      Dan is geen 'verhuisd.naar-buitenland' gebeurtenis gepubliceerd

 Regel: Als een onbekend land wordt geregistreerd na een Ministerieel Besluit, heeft de gebeurtenis 'verhuisd.naar-buitenland' NIET plaatsgevonden
    Een Ministerieel Besluit is een melding van de Minister van Buitenlandse Zaken dat een persoon niet langer als ingezetene ingeschreven mag zijn.
    
    In dit geval is de persoonslijst opgeschort met reden Ministerieel besluit (M).

    Scenario: Emigratie Ministerieel Besluit
      Als een Ministerieel Besluit voor 'Jan' is verwerkt
      * verblijft vanaf '1-9-2026' in een onbekend land
      * opschorting bijhouding reden is 'Ministerieel besluit'
      Dan is geen 'verhuisd.naar-buitenland' gebeurtenis gepubliceerd
