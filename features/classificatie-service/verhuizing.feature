# language: nl
Functionaliteit: gepubliceerde gebeurtenis bij een verhuizing

  Scenario: Verhuizing binnen dezelfde gemeente aangegeven
    Gegeven de verwerkte aangifte van geboorte van 'Jan'
    * verblijft vanaf '14-4-2020' op een locatie in 'Amsterdam'
    Als de opgave van verhuizing van 'Jan' is verwerkt
    * verblijft vanaf '1-9-2025' op een ander adres in 'Amsterdam'
    Dan is een 'verhuisd.binnengemeentelijk' gebeurtenis het laatst gepubliceerd

  Scenario: Verhuizing naar een andere gemeente in Nederland aangegeven
    Gegeven de verwerkte aangifte van geboorte van 'Jan'
    * verblijft vanaf '14-4-2020' op een locatie in 'Amsterdam'
    Als de opgave van verhuizing van 'Jan' is verwerkt
    * verblijft vanaf '1-9-2025' op een adres in 'Utrecht'
    Dan is een 'verhuisd.buitengemeentelijk' gebeurtenis het laatst gepubliceerd

  Scenario: Verhuizing van Nederland naar het buitenland aangegeven
    Gegeven de verwerkte aangifte van geboorte van 'Jan'
    * verblijft vanaf '14-4-2020' op een locatie in 'Amsterdam'
    Als de opgave van verhuizing van 'Jan' is verwerkt
    * verblijft vanaf '1-9-2025' op een adres in het buitenland
    Dan is een 'verhuisd.emigratie' gebeurtenis het laatst gepubliceerd

  Scenario: Verhuizing van het buitenland naar Nederland aangegeven
    Gegeven de verwerkte aangifte van geboorte van 'Jan'
    * verblijft vanaf '1-9-2025' op een locatie in het buitenland
    Als de opgave van verhuizing van 'Jan' is verwerkt
    * verblijft vanaf '14-4-2020' op een adres in 'Amsterdam'
    Dan is een 'verhuisd.immigratie' gebeurtenis het laatst gepubliceerd

  Scenario: Verhuizing van het buitenland naar een ander adres in het buitenland aangegeven
  Gegeven de verwerkte aangifte van geboorte van 'Jan'
    * verblijft vanaf '1-9-2025' op een locatie in het buitenland
    Als de opgave van verhuizing van 'Jan' is verwerkt
    * verblijft vanaf '14-4-2020' op een ander adres in het buitenland
    Dan is een 'verhuisd.in-buitenland' gebeurtenis het laatst gepubliceerd
