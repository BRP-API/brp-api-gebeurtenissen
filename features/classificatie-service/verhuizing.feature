# language: nl
Functionaliteit: gepubliceerde gebeurtenis bij een verhuizing

  Scenario: Verhuizing binnen dezelfde gemeente aangegeven
    Gegeven de verwerkte aangifte van geboorte van 'Jan'
    * verblijft vanaf '14-4-2020' op een adres in 'Amsterdam'
    Als de opgave van verhuizing van 'Jan' is verwerkt
    * verblijft vanaf '1-9-2025' op een ander adres in 'Amsterdam'
    Dan is een 'verhuisd.binnengemeentelijk' gebeurtenis het laatst gepubliceerd
    * bevat de 'data' de pl_id van 'Jan'
    * bevat de 'data' de adres_id van het nieuwe adres
    * bevat de 'data' in categorie 'verblijfplaats' element 'datum aanvang adreshouding (10.30)' met waarde '1-9-2025'

  Scenario: Verhuizing naar een andere gemeente in Nederland aangegeven
    Gegeven de verwerkte aangifte van geboorte van 'Jan'
    * verblijft vanaf '14-4-2020' op een adres in 'Amsterdam'
    Als de opgave van verhuizing van 'Jan' is verwerkt
    * verblijft vanaf '1-9-2025' op een adres in 'Utrecht'
    Dan is een 'verhuisd.buitengemeentelijk' gebeurtenis het laatst gepubliceerd
    * bevat de 'data' de pl_id van 'Jan'
    * bevat de 'data' de adres_id van het nieuwe adres
    * bevat de 'data' in categorie 'verblijfplaats' element 'datum aanvang adreshouding (10.30)' met waarde '1-9-2025'

  Scenario: Verhuizing van Nederland naar het buitenland aangegeven
    Gegeven de verwerkte aangifte van geboorte van 'Jan'
    * verblijft vanaf '14-4-2020' op een adres in 'Amsterdam'
    Als de opgave van verhuizing van 'Jan' is verwerkt
    * verblijft vanaf '1-9-2025' op een adres in het buitenland
    Dan is een 'verhuisd.emigratie' gebeurtenis het laatst gepubliceerd
    * bevat de 'data' de pl_id van 'Jan'
    * bevat de 'data' in categorie 'verblijfplaats' element 'datum aanvang adres buitenland (13.20)' met waarde '1-9-2025'
    * bevat de 'data' in categorie 'verblijfplaats' het nieuwe adres in het buitenland

  Scenario: Verhuizing van het buitenland naar Nederland aangegeven door persoon die eerder ingezetene is geweest
    Gegeven de verwerkte aangifte van geboorte van 'Jan'
    * verblijft vanaf '14-4-2020' op een adres in 'Amsterdam'
    En de verwerkte opgave van verhuizing van 'Jan'
    * verblijft vanaf '1-11-2023' op een adres in het buitenland
    Als de opgave van verhuizing van 'Jan' is verwerkt
    * is op '1-9-2025' geïmmigreerd uit Duitsland
    * verblijft vanaf '1-9-2025' op een adres in 'Amsterdam'
    Dan is een 'verhuisd.immigratie' gebeurtenis het laatst gepubliceerd
    * bevat de 'data' de pl_id van 'Jan'
    * bevat de 'data' de adres_id van het nieuwe adres
    * bevat de 'data' in categorie 'verblijfplaats' element 'datum aanvang adreshouding (10.30)' met waarde '1-9-2025'

  Scenario: Verhuizing van het buitenland naar Nederland aangegeven door persoon die nooit ingezetene is geweest
    Gegeven de verwerkte eerste inschrijving in het RNI van 'Jan'
    * verblijft vanaf '14-4-2020' op een adres in het buitenland
    Als de opgave van verhuizing van 'Jan' is verwerkt
    * is op '1-9-2025' geïmmigreerd uit Duitsland
    * verblijft vanaf '1-9-2025' op een adres in 'Amsterdam'
    Dan is een 'verhuisd.immigratie' gebeurtenis het laatst gepubliceerd
    * bevat de 'data' de pl_id van 'Jan'
    * bevat de 'data' de adres_id van het nieuwe adres
    * bevat de 'data' in categorie 'verblijfplaats' element 'datum aanvang adreshouding (10.30)' met waarde '1-9-2025'

  Scenario: Verhuizing van het buitenland naar een ander adres in het buitenland aangegeven
    Gegeven de verwerkte eerste inschrijving in het RNI van 'Jan'
    * verblijft vanaf '14-4-2020' op een adres in het buitenland
    Als de opgave van verhuizing van 'Jan' is verwerkt
    * verblijft vanaf '1-9-2025' op een ander adres in het buitenland
    Dan is een 'verhuisd.in-buitenland' gebeurtenis het laatst gepubliceerd
    * bevat de 'data' de pl_id van 'Jan'
    * bevat de 'data' in categorie 'verblijfplaats' element 'datum aanvang adres buitenland (13.20)' met waarde '1-9-2025'
    * bevat de 'data' in categorie 'verblijfplaats' het nieuwe adres in het buitenland
