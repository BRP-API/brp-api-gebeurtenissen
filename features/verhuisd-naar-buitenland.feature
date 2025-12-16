# language: nl
Functionaliteit: 'verhuisd.naar-buitenland' gebeurtenis
  Bij een aangifte van een verhuizing naar het buitenland, of naar het Caribisch deel van het Koninkrijk heeft een gebeurtenis verhuisd.naar-buitenland plaatsgevonden.
  De gebeurtenis 'verhuisd.naar-buitenland' betekent dat de persoon verhuisd is van een Nederlandse gemeente naar het buitenland of het Caribisch deel van het Koninkrijk.
  Wanneer geen aangifte van vertrek is gedaan, maar het vertrek uit Nederland ambthalve is geregistreerd of als gevolg van een Ministerieel Besluit is het niet bekend waar persoon verblijft.  

  Achtergrond:
    Gegeven het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    * in gemeente 'Hengelo'
    * met adresseerbaar object identificatie '0164010000047847'
    En de persoon 'Jan'
    * verblijft vanaf '14-4-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    En afnemer 'Roosendaal' is geabonneerd op 'verhuisd.emigratie' gebeurtenissen van de persoon 'Jan'

  Regel: Wanneer een persoon naar het buitenland is verhuisd, dan heeft een gebeurtenis 'verhuisd.naar-buitenland' plaatsgevonden

    Scenario: Aangifte van vertrek naar het buitenland
      Gegeven het adres buitenland 'Chemin_du_Calvaire_19_Lausanne'
      * met adresregel 1 'Chemin de Calvaire 19'
      * met adresregel 2 'Lausanne'
      * met adresregel 3 'Vaud'
      * in land 'Zwitserland'
      Als de aangifte van vertrek naar het buitenland van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2025' op het adres 'Chemin_du_Calvaire_19_Lausanne'
      Dan is een 'verhuisd.naar-buitenland' gebeurtenis gepubliceerd met de volgende data
      * het A-nummer van 'Jan'
      * de datum dat 'Jan' is geemigreerd
      * het adres 'Chemin_du_Calvaire_19_Lausanne'

  Regel: Wanneer een persoon naar het buitenland is verhuisd maar nog geen definitief woonadres heeft, dan heeft een gebeurtenis 'verhuisd.naar-buitenland' plaatsgevonden.

    Scenario: Aangifte van vertrek naar het buitenland en alleen het land is bekend
      Gegeven het adres buitenland 'Adres_in_Zwitserland'
      * zonder adresregels
      * in land 'Zwitserland'
      Als de aangifte van vertrek naar het buitenland van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2025' op 'Adres_in_Zwitserland'
      Dan is een 'verhuisd.naar-buitenland' gebeurtenis gepubliceerd met de volgende data
      * het A-nummer van 'Jan'
      * de datum dat 'Jan' is geemigreerd
      * het land adres buitenland is 'Zwitserland'

    Scenario: Aangifte van vertrek naar het buitenland en alleen het land en de plaats zijn bekend
      Gegeven het adres buitenland 'Adres_in_Lausanne'
      * met adresregel 2 'Lausanne'
      * in land 'Zwitserland'
      Als de aangifte van vertrek naar het buitenland van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2025' op 'Adres_in_Lausanne'
      Dan is een 'verhuisd.naar-buitenland' gebeurtenis gepubliceerd met de volgende data
      * het A-nummer van 'Jan'
      * de datum dat 'Jan' is geemigreerd
      * het land adres buitenland is 'Zwitserland'
      * adresregel 2 'Lausanne'

  Regel: Wanneer een persoon naar een Caribisch deel van het Koninkrijk is verhuisd, dan heeft een gebeurtenis 'verhuisd.naar-buitenland' plaatsgevonden.

    Scenario: Aangifte van vertrek naar een eiland dat onderdeel is van het Caribisch deel van het Koninkrijk
      Gegeven het adres buitenland 'Onbekend_adres_in_Bonaire'
      * in land 'Bonaire'
      Als de aangifte van vertrek naar het buitenland van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2025' op adres 'Onbekend_adres_in_Bonaire'
      Dan is een 'verhuisd.naar-buitenland' gebeurtenis gepubliceerd met de volgende data
      * het A-nummer van 'Jan'
      * de datum dat 'Jan' is geemigreerd
      * het land adres buitenland is 'Bonaire'

  Regel: Er heeft een gebeurtenis 'verhuisd.naar-buitenland' plaatsgevonden als een persoon ambtshalve is uitgeschreven bij onbekend adres, of is geemigreerd als gevolg van een Ministerieel Besluit.
    Als een persoon ambtshalve wordt uitgeschreven is de verblijfplaats van de persoon niet bekend, nadat uitgebreid onderzoek heeft plaatsgevonden.
    Een Ministerieel Besluit is een melding van de Minister van Buitenlandse Zaken dat een persoon niet langer als ingezetene ingeschreven mag zijn.
    (note voor automation: reden opschorting ambtshalve uitschrijving is E, reden opschorting bij Emigratie Ministerieel Besluit is M)

    Scenario: Ambtshalve uitschrijving bij onbekend adres
      Als de ambtshalve uitschrijving bij onbekend adres van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2025' in een onbekend land
      Dan is een 'verhuisd.naar-buitenland' gebeurtenis gepubliceerd met de volgende data
      * het A-nummer van 'Jan'
      * de datum dat 'Jan' is geemigreerd
      * het land adres buitenland is 'onbekend'

    Scenario: Emigratie Ministerieel Besluit
      Als de emigratie Ministerieel Besluit van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2025' in een onbekend land
      Dan is een 'verhuisd.naar-buitenland' gebeurtenis gepubliceerd met de volgende data
      * het A-nummer van 'Jan'
      * de datum dat 'Jan' is geemigreerd
      * het land adres buitenland is 'onbekend'
