# language: nl
Functionaliteit: Gebeurtenissen die een eerste inschrijving betreffen
  Een wijziging in de BRP is gebeurtenis "ingeschreven" wanneer een persoon voor het eerst is ingeschreven in de BRP of het RNI.
  Een persoon is voor het eerst ingeschreven wanneer het versienummer (80.10) van de persoonslijst de waarde "0000" heeft.

  # Vraag: versienummer (80.10) heeft bij eerste inschrijving standaardwaarde 0000, maar kan ook bij wijziging 10000 opnieuw de waarde 0000 krijgen (het is immers een 4-cijferige code).
  # Komt dit voor? En moeten we dus een andere manier bedenken om te bepalen/toevoegen dat het een eerste inschrijving betreft? (bijvoorbeeld er is geen "was" situatie)

  # opmerking: één type command (1e inschrijving BRP) leidt tot drie verschillende gebeurtenissen (ingeschreven.geboorte, ingeschreven.niet-ingezeten, ingeschreven.immigratie)?
  # er is volgens mij afgesproken dan één command tot één gebeurtenis leidt. Wat is de reden om nu hiervan af te wijken?
  # En is dit wel handig? Bij een gemeente vraagt je volgens mij niet om een 1e inschrijving formulier om geboorteaangifte te doen

  Regel: Een wijziging in de BRP is gebeurtenis "ingeschreven" met subject "geboorte" wanneer een persoon voor het eerst is ingeschreven in Nederland en er is geen immigratie
    Waarbij:
    - "ingeschreven in Nederland": gemeente van inschrijving (08.09.10) is ongelijk aan 1999 (RNI)
    - "er is geen immigratie": groep 14 (immigratie) ontbreekt of is leeg

    Scenario: Kind is geboren in Nederland
      Als de 1e inschrijving BRP van 'Jan' is verwerkt
      * is gisteren geboren
      * verblijft in gemeente Rotterdam
      Dan is een 'ingeschreven.geboorte' gebeurtenis gepubliceerd
      * met de volgende gegevens
        | specversion | type                         | id   | time          |
        |         1.0 | nl.brp.ingeschreven.geboorte | guid | timestamp-utc |
      * heeft de volgende 'data' gegevens
        | pl_id |
        | Jan   |

    Scenario: bla
      Als het bericht '1e inschrijving' is verwerkt
      """
      {
        // is gisteren geboren
        "geboorte": {
          "datum": "gisteren"
        },
        // is dit omdat 'Jan' in een Nederlandse gemeente verblijft? Of komt dit door de impliciete gegeven 'ingeschreven in Nederland' dat alleen in de Regel staat?
        "gemeenteVanInschrijving": {
          "code": "!=1999"
        },
        "immigratie": {},
        // betekent 'verblijft in gemeente Rotterdam' een locatie of ee adres?
        "verblijfplaats": {
          "adresseerbaarObjectIdentificatie": "0599xxxxxxx"
        }
      }
      """

    Scenario: bla
      Als het bericht '1e inschrijving' is verwerkt
      """
      {
        "geboorte": {
          "datum": "gisteren"
        },
        "gemeenteVanInschrijving": {
          "code": "!=1999"
        },
        "immigratie": {},
        "verblijfplaats": {
          "verblijfadres": {
            "locatiebeschrijving": "een locatiebeschrijving"
          }
        }
      }
      """

  Regel: Een wijziging in de BRP is gebeurtenis "ingeschreven" met subject "niet-ingezeten" wanneer een persoon voor het eerst is ingeschreven en de persoon staat ingeschreven in het RNI (Registratie van Niet-Ingezetenen)
    Waarbij:
    - "staat ingeschreven in het RNI": gemeente van inschrijving (08.09.10) is gelijk aan 1999 (RNI)

    Scenario: Persoon wordt ingeschreven als niet-ingezetene in het RNI
      Als de 1e inschrijving BRP van 'Jan' is verwerkt
      * verblijft in België
      Dan is een 'ingeschreven.niet-ingezeten' gebeurtenis gepubliceerd
      * met de volgende gegevens
        | specversion | type                               | id   | time          |
        |         1.0 | nl.brp.ingeschreven.niet-ingezeten | guid | timestamp-utc |
      * heeft de volgende 'data' gegevens
        | pl_id |
        | Jan   |

    Scenario: bla
      Als het bericht '1e inschrijving' is verwerkt
      """
      {
        // is dit het geval omdat 'Jan' in het buitenland verblijft? Of komt dit door de impliciete gegeven 'staat ingeschreven in het RNI' dat alleen in de Regel staat?
        "gemeenteVanInschrijving": {
          "code": "1999"
        },
        // verblijft in België
        "verblijfplaats": {
          "land": {
            "code": "vier cijferig code van België"
          }
        },
      }
      """

  Regel: Een wijziging in de BRP is gebeurtenis "ingeschreven" met subject "immigratie" wanneer een persoon voor het eerst is ingeschreven in Nederland en de persoon is geïmmigreerd
    Waarbij:
    - "ingeschreven in Nederland": gemeente van inschrijving (08.09.10) is ongelijk aan 1999 (RNI)
    - "is geïmmigreerd": land vanwaar ingeschreven (14.10) bestaat en heeft een waarde en datum vestiging in Nederland (14.20) bestaat en heeft een waarde

    Scenario: Persoon immigreert naar Nederland
      Als de 1e inschrijving BRP van 'Jan' is verwerkt
      * is geïmmigreerd uit Duitsland
      * verblijft in gemeente Rotterdam
      Dan is een 'ingeschreven.immigratie' gebeurtenis gepubliceerd
      * met de volgende gegevens
        | specversion | type                           | id   | time          |
        |         1.0 | nl.brp.ingeschreven.immigratie | guid | timestamp-utc |
      * heeft de volgende 'data' gegevens
        | pl_id |
        |  Jan  |

    Scenario: bla
      Als het bericht '1e inschrijving' is verwerkt
      """
      {
        "gemeenteVanInschrijving": {
          "code": "!=1999"
        },
        "immigratie": {
          "landVanwaarIngeschreven": {
            "code": "vier cijferig code van Duitsland"
          },
          "datumVestigingInNederland": "een datum"
        },
        "verblijfplaats": {
          "adresseerbaarObjectIdentificatie": "0599xxxxxxx"
        }
      }
      """

    Scenario: bla
      Als het bericht '1e inschrijving' is verwerkt
      """
      {
        "gemeenteVanInschrijving": {
          "code": "!=1999"
        },
        "immigratie": {
          "landVanwaarIngeschreven": {
            "code": "vier cijferig code van Duitsland"
          },
          "datumVestigingInNederland": "een datum"
        },
        "verblijfplaats": {
          "verblijfadres": {
            "locatiebeschrijving": "een locatiebeschrijving"
          }
        }
      }
      """

