# language: nl
Functionaliteit: Gebeurtenissen die een eerste inschrijving betreffen

  Regel: Een wijziging in de BRP is gebeurtenis "ingeschreven" met subject "geboorte" wanneer een  persoon voor het eerst is ingeschreven in Nederland en er is geen immigratie
    - "persoon voor het eerst is ingeschreven": Een wijziging is gebeurtenis "ingeschreven" wanneer de verschillen analyse geen was-situatie bevat, ofwel PL-versienummer=1
    - "ingeschreven in Nederland": gemeente van inschrijving (08.09.10) is ongelijk aan 1999 (RNI)
    - "er is geen immigratie": groep 14 (immigratie) ontbreekt of is leeg

    Scenario: Kind is geboren in Nederland
      Gegeven de 1e inschrijving BRP van 'Jan'
      * is gisteren geboren
      * is ingeschreven in de BRP
      Als de 1e inschrijving BRP van 'Jan' is verwerkt met PL id 1
      Dan is een gebeurtenis gepubliceerd
      * met de volgende gegevens
        | specversion | type                | subject  | id   | time          |
        |         1.0 | nl.brp.ingeschreven | geboorte | guid | timestamp-utc |
      * heeft de volgende 'data' gegevens
        | pl_id |
        |     1 |

  Regel: Een wijziging in de BRP is gebeurtenis "ingeschreven" met subject "niet-ingezeten" wanneer een  persoon voor het eerst is ingeschreven en de persoon staat ingeschreven in het RNI (Registratie van Niet-Ingezetenen)
    - "persoon voor het eerst is ingeschreven": Een wijziging is gebeurtenis "ingeschreven" wanneer de verschillen analyse geen was-situatie bevat, ofwel PL-versienummer=1
    - "staat ingeschreven in het RNI": gemeente van inschrijving (08.09.10) is gelijk aan 1999 (RNI)

    Scenario: Persoon wordt ingeschreven als niet-ingezetene in het RNI
      Gegeven de 1e inschrijving BRP van 'Jan'
      * is ingeschreven als niet-ingezetene met een verblijfplaats in België
      Als de 1e inschrijving BRP van 'Jan' is verwerkt met PL id 1
      Dan is een gebeurtenis gepubliceerd
      * met de volgende gegevens
        | specversion | type                | subject        | id   | time          |
        |         1.0 | nl.brp.ingeschreven | niet-ingezeten | guid | timestamp-utc |
      * heeft de volgende 'data' gegevens
        | pl_id |
        |     1 |

  Regel: Een wijziging in de BRP is gebeurtenis "ingeschreven" met subject "immigratie" wanneer een  persoon voor het eerst is ingeschreven in Nederland en de persoon is geïmmigreerd
    - "persoon voor het eerst is ingeschreven": Een wijziging is gebeurtenis "ingeschreven" wanneer de verschillen analyse geen was-situatie bevat, ofwel PL-versienummer=1
    - "ingeschreven in Nederland": gemeente van inschrijving (08.09.10) is ongelijk aan 1999 (RNI)
    - "is geïmmigreerd": land vanwaar ingeschreven (14.10) bestaat en heeft een waarde en datum vestiging in Nederland (14.20) bestaat en heeft een waarde

    Scenario: Persoon immigreert naar Nederland
      Gegeven de 1e inschrijving BRP van 'Jan'
      * is geboren in Duitsland
      * is gisteren geïmmigreerd
      Als de 1e inschrijving BRP van 'Jan' is verwerkt met PL id 1
      Dan is een gebeurtenis gepubliceerd
      * met de volgende gegevens
        | specversion | type                | subject    | id   | time          |
        |         1.0 | nl.brp.ingeschreven | immigratie | guid | timestamp-utc |
      * heeft de volgende 'data' gegevens
        | pl_id |
        |     1 |
