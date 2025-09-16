# language: nl
Functionaliteit: Gebeurtenissen die een wijziging in de verblijfplaats betreffen
  Een wijziging in de BRP is gebeurtenis "verhuisd" wanneer de persoon feitelijk op een andere plek is komen te wonen als vaste verblijfplaats.
  Dit is het geval wanneer aan alle volgende condities is voldaan:
    - versienummer (80.10) van de persoonslijst heeft een waarde ongelijk aan "0000" (is geen eerste inschrijving).
    - ten minste één gegeven uit de actuele categorie 8 (verblijfplaats) in functie adres (10.10) of in groep 11 (adres), 12 (locatie) of 13 (verblijf buitenland) is de nieuwe actuele situatie gewijzigd ten opzichte van de vorige actuele situatie
    - de datum aanvang adreshouding (10.30) of de datum aanvang adres buitenland (13.20) is in de nieuwe situatie gewijzigd ten opzichte van de vorige actuele situatie
    - er is met deze wijziging geen (historisch) verblijfplaatsvoorkomen gecorrigeerd: Indicatie onjuist (84.10) in de vorige actuele verblijfplaats (heeft nu volgnummer 1) bestaat niet, is leeg of heeft geen waarde
    - omschrijving van de aangifte adreshouding (08.72.10) is ongelijk aan "W" (infrastructurele wijziging) en ongelijk aan "T" (technische wijziging i.v.m. BAG
  # Nader uit te werken in andere feature(s) of aanvullende regel(s):
  #  Een wijziging aan de verblijfplaats is niet gebeurtenis "verhuisd" wanneer 
  #  - het adres door een infrastructurele wijziging veranderd is
  #  - er een correctie op de verblijfplaats heeft plaatsgevonden
  #  - de wijziging een historische verblijfplaats betreft en de actuele verblijfplaats ongewijzigd is

  Achtergrond:
    Gegeven adres 'Prinses_Beatrixlaan_116_Den_Haag' heeft de volgende gegevens
      | gemeente van inschrijving (09.10) | straatnaam (11.10)  | naam openbare ruimte (11.15) | huisnummer (11.20) | postcode (11.60) | woonplaats (11.70) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      |                              0518 | Prinses Beatrixlaan | Prinses Beatrixlaan          |                116 |           2595AL | 's-Gravenhage      |                         0518010000584404 |                           0518200000584403 |
    En adres 'Wilhelmina_van_Pruisenweg_52_Den_Haag' heeft de volgende gegevens
      | gemeente van inschrijving (09.10) | straatnaam (11.10)       | naam openbare ruimte (11.15) | huisnummer (11.20) | postcode (11.60) | woonplaats (11.70) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      |                              0518 | Wilhelmina van Pruisenwg | Wilhelmina van Pruisenweg    |                 52 |           2595AN | 's-Gravenhage      |                         0518010000713450 |                           0518200000713449 |
    En adres 'Stadsplateau_1_Utrecht' heeft de volgende gegevens
      | gemeente van inschrijving (09.10) | straatnaam (11.10) | naam openbare ruimte (11.15) | huisnummer (11.20) | postcode (11.60) | woonplaats (11.70) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      |                              0344 | Stadsplateau       | Stadsplateau                 |                  1 |           3521AZ | Utrecht            |                         0344010000163715 |                           0344200000166576 |

  Regel: Een wijziging in de BRP is gebeurtenis "verhuisd" met subject "binnengemeentelijk" wanneer de persoon is verhuisd naar een ander adres binnen dezelfde gemeente
    Waarbij "verhuisd naar een ander adres binnen dezelfde gemeente" betekent dat:
    - de gemeente van inschrijving (09.10) van de nieuwe verblijfplaats is gelijk aan de gemeente van inschrijving (09.10) van de vorige actuele verblijfplaats
    - land adres buitenland (13.10) bestaat niet of is leeg zowel in de nieuwe verblijfplaats als in de vorige verblijfplaats

    Scenario: Persoon is verhuisd binnen dezelfde gemeente
      Gegeven de 1e inschrijving van persoon 'Jan'
      * verblijft op adres 'Prinses_Beatrixlaan_116_Den_Haag'
      Als de verhuizing van 'Jan' naar adres 'Wilhelmina_van_Pruisenweg_52_Den_Haag' op 1-9-2025 is verwerkt
      Dan is een gebeurtenis gepubliceerd
      * met de volgende gegevens
        | specversion | type            | subject            | id   | time          |
        |         1.0 | nl.brp.verhuisd | binnengemeentelijk | guid | timestamp-utc |
      * heeft de volgende 'data' gegevens
        | pl_id | adres_id                         |
        | Jan   | Prinses_Beatrixlaan_116_Den_Haag |
      * heeft 'data' de volgende 'c08' gegevens
        | e1030    |
        | 20250901 |

  Regel: Een wijziging in de BRP is gebeurtenis "verhuisd" met subject "buitengemeentelijk" wanneer de persoon is verhuisd naar een ander adres binnen dezelfde gemeente
    Waarbij "verhuisd naar een ander adres binnen dezelfde gemeente" betekent dat:
    - de gemeente van inschrijving (09.10) van de nieuwe verblijfplaats is ongelijk aan de gemeente van inschrijving (09.10) van de vorige actuele verblijfplaats
    - land adres buitenland (13.10) bestaat niet of is leeg zowel in de nieuwe verblijfplaats als in de vorige verblijfplaats

    Scenario: Persoon is verhuisd binnen dezelfde gemeente
      Gegeven de 1e inschrijving van persoon 'Jan'
      * verblijft op adres 'Prinses_Beatrixlaan_116_Den_Haag'
      Als de verhuizing van 'Jan' naar adres 'Stadsplateau_1_Utrecht' op 1-9-2025 is verwerkt
      Dan is een gebeurtenis gepubliceerd
      * met de volgende gegevens
        | specversion | type            | subject            | id   | time          |
        |         1.0 | nl.brp.verhuisd | buitengemeentelijk | guid | timestamp-utc |
      * heeft de volgende 'data' gegevens
        | pl_id | adres_id               |
        | Jan   | Stadsplateau_1_Utrecht |
      * heeft 'data' de volgende 'c08' gegevens
        | e1030    |
        | 20250901 |

  Regel: Een wijziging in de BRP is gebeurtenis "verhuisd" met subject "emigratie" wanneer de persoon is verhuisd van een adres in Nederland naar een adres in het buitenland
    Waarbij "verhuisd van een adres in Nederland naar een adres in het buitenland" betekent dat:
    - land adres buitenland (13.10) bestaat niet of is leeg in de vorige verblijfplaats
    - land adres buitenland (13.10) bestaat en heeft een waarde in de nieuwe verblijfplaats

    Scenario: Persoon is geëmigreerd
      Gegeven de 1e inschrijving van persoon 'Jan'
      * verblijft op adres 'Prinses_Beatrixlaan_116_Den_Haag'
      Als de verhuizing van 'Jan' op 1-9-2025 naar 'Grote Markt 1', 'kamer 3-24', '2000 Antwerpen' in 'België' is verwerkt
      Dan is een gebeurtenis gepubliceerd
      * met de volgende gegevens
        | specversion | type            | subject   | id   | time          |
        |         1.0 | nl.brp.verhuisd | emigratie | guid | timestamp-utc |
      * heeft de volgende 'data' gegevens
        | pl_id |
        | Jan   |
      * heeft 'data' de volgende 'c08' gegevens
        | e1310 | e1320    | e1330         | e1340      | e1350          |
        |  5010 | 20250901 | Grote Markt 1 | kamer 3-24 | 2000 Antwerpen |

  Regel: Een wijziging in de BRP is gebeurtenis "verhuisd" met subject "immigratie" wanneer de persoon is verhuisd van een adres in het buitenland naar een adres in Nederland
    Waarbij "verhuisd van een adres in het buitenland naar een adres in Nederland" betekent dat:
    - land adres buitenland (13.10) bestaat en heeft een waarde in de vorige verblijfplaats
    - land adres buitenland (13.10) bestaat niet of is leeg in de nieuwe verblijfplaats

    Dit betreft het (her)inschrijven van een persoon in de BRP vanuit het RNI. 
    Naast de verblijfplaats kunnen dan ook andere gegevens gewijzigd zijn. Bijvoorbeeld door het vastleggen van gegevens die in het RNI niet worden bijgehouden en in de BRP wel.
    Deze andere gegevens die tegelijkertijd kunnen zijn gewijzigd kunnen tot andere gebeurtenissen (te definieren in andere features) leiden.
    De herinschrijving leidt dan tot het publiceren van meedere gebeurtenissen, waaronder "verhuisd".

    Scenario: Persoon is geimmigreerd
      Gegeven de 1e inschrijving van persoon 'Jan'
      * verblijft op adres 'Prinses_Beatrixlaan_116_Den_Haag'
      En de emigratie van 'Jan' op 15-3-2021 naar België
      Als de verhuizing van 'Jan' naar adres 'Stadsplateau_1_Utrecht' op 1-9-2025 is verwerkt
      Dan is een gebeurtenis gepubliceerd
      * met de volgende gegevens
        | specversion | type            | subject    | id   | time          |
        |         1.0 | nl.brp.verhuisd | immigratie | guid | timestamp-utc |
      * heeft de volgende 'data' gegevens
        | pl_id | adres_id               |
        | Jan   | Stadsplateau_1_Utrecht |
      * heeft 'data' de volgende 'c08' gegevens
        | e1030    |
        | 20250901 |

  Regel: Een wijziging in de BRP is gebeurtenis "verhuisd" met subject "buitenlands" wanneer de persoon is verhuisd van een adres in het buitenland naar een ander adres in het buitenland
    Waarbij "verhuisd van een adres in het buitenland naar een ander adres in het buitenland" betekent dat:
    - land adres buitenland (13.10) bestaat en heeft een waarde in de nieuwe verblijfplaats en in de vorige verblijfplaats

    Scenario: Persoon is verhuisd in het buitenland
      Gegeven de 1e inschrijving van persoon 'Jan'
      * verblijft op adres 'Prinses_Beatrixlaan_116_Den_Haag'
      En de emigratie van 'Jan' op 15-3-2021 naar 'Hallenstraat 4', '1000 Brussel' in 'België'
      Als de verhuizing van 'Jan' op 1-9-2025 naar 'Grote Markt 1', 'kamer 3-24', '2000 Antwerpen' in 'België' is verwerkt
      Dan is een gebeurtenis gepubliceerd
      * met de volgende gegevens
        | specversion | type            | subject     | id   | time          |
        |         1.0 | nl.brp.verhuisd | buitenlands | guid | timestamp-utc |
      * heeft de volgende 'data' gegevens
        | pl_id |
        | Jan   |
      * heeft 'data' de volgende 'c08' gegevens
        | e1310 | e1320    | e1330         | e1340      | e1350          |
        |  5010 | 20250901 | Grote Markt 1 | kamer 3-24 | 2000 Antwerpen |
