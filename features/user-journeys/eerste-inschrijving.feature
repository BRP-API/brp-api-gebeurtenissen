# language: nl
Functionaliteit: Gebeurtenissen die een eerste inschrijving betreffen
  Een wijziging in de BRP is gebeurtenis "ingeschreven" wanneer een  persoon voor het eerst is ingeschreven in de BRP of het RNI.
  Een persoon is voor het eerst ingeschreven wanneer het versienummer (80.10) van de persoonslijst de waarde "0000" heeft.

  # Vraag: versienummer (80.10) heeft bij eerste inschrijving standaardwaarde 0000, maar kan ook bij wijziging 10000 opnieuw de waarde 0000 krijgen (het is immers een 4-cijferige code).
  # Komt dit voor? En moeten we dus een andere manier bedenken om te bepalen/toevoegen dat het een eerste inschrijving betreft? (bijvoorbeeld er is geen "was" situatie)

  Regel: Een wijziging in de BRP is gebeurtenis "ingeschreven" met subject "geboorte" wanneer een  persoon voor het eerst is ingeschreven in Nederland en er is geen immigratie
    Waarbij:
    - "ingeschreven in Nederland": gemeente van inschrijving (08.09.10) is ongelijk aan 1999 (RNI)
    - "er is geen immigratie": groep 14 (immigratie) ontbreekt of is leeg

    Scenario: Kind is geboren in Nederland
      Als de 1e inschrijving BRP van 'Jan' is verwerkt met PL id 1
      * is gisteren geboren
      * is ingeschreven met een verblijfplaats in gemeente Rotterdam
      Dan is een gebeurtenis gepubliceerd
      * met de volgende gegevens
        | specversion | type                | subject  | id   | time          |
        |         1.0 | nl.brp.ingeschreven | geboorte | guid | timestamp-utc |
      * heeft de volgende 'data' gegevens
        | pl_id |
        |     1 |

  Regel: Een wijziging in de BRP is gebeurtenis "ingeschreven" met subject "niet-ingezeten" wanneer een  persoon voor het eerst is ingeschreven en de persoon staat ingeschreven in het RNI (Registratie van Niet-Ingezetenen)
    Waarbij:
    - "staat ingeschreven in het RNI": gemeente van inschrijving (08.09.10) is gelijk aan 1999 (RNI)

    Scenario: Persoon wordt ingeschreven als niet-ingezetene in het RNI
      Als de 1e inschrijving BRP van 'Jan' is verwerkt met PL id 1
      * is ingeschreven als niet-ingezetene met een verblijfplaats in België
      Dan is een gebeurtenis gepubliceerd
      * met de volgende gegevens
        | specversion | type                | subject        | id   | time          |
        |         1.0 | nl.brp.ingeschreven | niet-ingezeten | guid | timestamp-utc |
      * heeft de volgende 'data' gegevens
        | pl_id |
        |     1 |

  Regel: Een wijziging in de BRP is gebeurtenis "ingeschreven" met subject "immigratie" wanneer een  persoon voor het eerst is ingeschreven in Nederland en de persoon is geïmmigreerd
    Waarbij:
    - "ingeschreven in Nederland": gemeente van inschrijving (08.09.10) is ongelijk aan 1999 (RNI)
    - "is geïmmigreerd": land vanwaar ingeschreven (14.10) bestaat en heeft een waarde en datum vestiging in Nederland (14.20) bestaat en heeft een waarde

    Scenario: Persoon immigreert naar Nederland
      Als de 1e inschrijving BRP van 'Jan' is verwerkt met PL id 1
      * is geboren in Duitsland
      * is gisteren geïmmigreerd
      * is ingeschreven met een verblijfplaats in gemeente Rotterdam
      Dan is een gebeurtenis gepubliceerd
      * met de volgende gegevens
        | specversion | type                | subject    | id   | time          |
        |         1.0 | nl.brp.ingeschreven | immigratie | guid | timestamp-utc |
      * heeft de volgende 'data' gegevens
        | pl_id |
        |     1 |
