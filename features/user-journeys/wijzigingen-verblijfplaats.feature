# language: nl
Functionaliteit: Gebeurtenissen die een wijziging in de verblijfplaats betreffen
  Waar in deze feature wordt gesproken over de "wordt" situatie, dan wordt hiermee de set gegevens bedoeld die gewijzigd met hun nieuwe waarde
  Waar in deze feature wordt gesproken over de "was" situatie, dan wordt hiermee de gegevens bedoeld die gewijzigd zijn met hun oorspronkelijke waarde. Wanneer een voorkomen wordt toegevoegd, dan wordt hiermee bedoeld het vorige actuele voorkomen.

  Achtergrond:
    Gegeven adres 'Prinses_Beatrixlaan_116' heeft de volgende gegevens
      | adres_id | gemeentecode | straatnaam (11.10)  | naam openbare ruimte (11.15) | huisnummer (11.20) | postcode (11.60) | woonplaats (11.70) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      |       10 |         0518 | Prinses Beatrixlaan | Prinses Beatrixlaan          |                116 |           2595AL | 's-Gravenhage      |                         0518010000584404 |                           0518200000584403 |
    En adres 'Wilhelmina_van_Pruisenweg_52' heeft de volgende gegevens
      | adres_id | gemeentecode | straatnaam (11.10)       | naam openbare ruimte (11.15) | huisnummer (11.20) | postcode (11.60) | woonplaats (11.70) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      |       11 |         0518 | Wilhelmina van Pruisenwg | Wilhelmina van Pruisenweg    |                 52 |           2595AN | 's-Gravenhage      |                         0518010000713450 |                           0518200000713449 |
    En adres 'Wilhelmina_van_Pruisenweg_52' heeft de volgende gegevens
      | adres_id | gemeentecode | straatnaam (11.10) | naam openbare ruimte (11.15) | huisnummer (11.20) | postcode (11.60) | woonplaats (11.70) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      |       12 |         0344 | Stadsplateau       | Stadsplateau                 |                  1 |           3521AZ | Utrecht            |                         0344010000163715 |                           0344200000166576 |

  Regel: Een wijziging in de BRP is gebeurtenis "verhuisd" wanneer een persoon feitelijk verhuist
    Een wijziging is gebeurtenis "verhuisd" wanneer aan alle volgende condities wordt voldaan:
    - er is een "was" situatie (uit verschillen analyse, of PL-versienummer van "wordt" situatie >1)
    - ten minste één gegeven uit de actuele categorie 8 (verblijfplaats) in functie adres (10.10) of in groep 11 (adres), 12 (locatie) of 13 (verblijf buitenland) is de "wordt" situatie gewijzigd ten opzichte van de "was" situatie
    - de datum aanvang adreshouding (10.30) of de datum aanvang adres buitenland (13.20) is in de "wordt" situatie gewijzigd ten opzichte van de "was" situatie
    - er is geen (historisch) verblijfplaatsvoorkomen gecorrigeerd in de "wordt" situatie ten opzichte van de "was" situatie

    Scenario: Persoon is verhuisd binnen Nederland
      Gegeven de persoon 'Jan' heeft de volgende gegevens
        | naam                        | waarde    |
        | pl_id                       |         1 |
        | burgerservicenummer (01.20) | 000000036 |
      * heeft de volgende 'verblijfplaats' gegevens
        | naam                                       | waarde              |
        | gemeente van inschrijving (09.10)          |                0518 |
        | datum inschrijving in de gemeente (09.20)  |            20240507 |
        | functie adres (10.10)                      | W                   |
        | datum aanvang adreshouding (10.30)         |            20240507 |
        | straatnaam (11.10)                         | Prinses Beatrixlaan |
        | naam openbare ruimte (11.15)               | Prinses Beatrixlaan |
        | huisnummer (11.20)                         |                 116 |
        | postcode (11.60)                           |              2595AL |
        | woonplaats (11.70)                         | 's-Gravenhage       |
        | identificatiecode verblijfplaats (11.80)   |    0518010000584404 |
        | identificatiecode nummeraanduiding (11.90) |    0518200000584403 |
        | land vanwaar ingeschreven (14.10)          |                5010 |
        | datum vestiging in Nederland (14.20)       |            20240507 |
        | ingangsdatum geldigheid (85.10)            |            20240507 |
        | datum van opneming (86.10)                 |            20250908 |
      En de wijziging BRP van 'Jan'
      * heeft de volgende 'verblijfplaats' gegevens
        | naam                                       | waarde                    |
        | datum aanvang adreshouding (10.30)         | gisteren                  |
        | straatnaam (11.10)                         | Wilhelmina van Pruisenwg  |
        | naam openbare ruimte (11.15)               | Wilhelmina van Pruisenweg |
        | huisnummer (11.20)                         |                        52 |
        | postcode (11.60)                           |                    2595AN |
        | woonplaats (11.70)                         | 's-Gravenhage             |
        | identificatiecode verblijfplaats (11.80)   |          0518010000713450 |
        | identificatiecode nummeraanduiding (11.90) |          0518200000713449 |
        | ingangsdatum geldigheid (85.10)            | gisteren                  |
        | datum van opneming (86.10)                 | vandaag                   |
      Als de wijziging BRP van 'Jan' is verwerkt
      Dan is de gebeurtenis gepubliceerd met de volgende gegevens
        | naam        | waarde          |
        | specversion |             1.0 |
        | type        | nl.brp.verhuisd |
        | id          | guid            |
        | time        | timestamp-utc   |
        | pl_id       |               1 |
        | adres_id    |              11 |
        | datumVan    | gisteren        |

    Scenario: Persoon is geëmigreerd
      Gegeven de persoon 'Jan' heeft de volgende gegevens
        | naam                        | waarde    |
        | pl_id                       |         1 |
        | burgerservicenummer (01.20) | 000000036 |
      * de persoon heeft de volgende 'inschrijving' gegevens
        | naam                                 | waarde   |
        | datum opschorting bijhouding (67.10) | gisteren |
        | reden opschorting bijhouding (67.20) | E        |
      * heeft de volgende 'verblijfplaats' gegevens
        | naam                                       | waarde              |
        | gemeente van inschrijving (09.10)          |                0518 |
        | datum inschrijving in de gemeente (09.20)  |            20240507 |
        | functie adres (10.10)                      | W                   |
        | datum aanvang adreshouding (10.30)         |            20240507 |
        | straatnaam (11.10)                         | Prinses Beatrixlaan |
        | naam openbare ruimte (11.15)               | Prinses Beatrixlaan |
        | huisnummer (11.20)                         |                 116 |
        | postcode (11.60)                           |              2595AL |
        | woonplaats (11.70)                         | 's-Gravenhage       |
        | identificatiecode verblijfplaats (11.80)   |    0518010000584404 |
        | identificatiecode nummeraanduiding (11.90) |    0518200000584403 |
        | land vanwaar ingeschreven (14.10)          |                5010 |
        | datum vestiging in Nederland (14.20)       |            20240507 |
        | ingangsdatum geldigheid (85.10)            |            20240507 |
        | datum van opneming (86.10)                 |            20250908 |
      En de wijziging BRP van 'Jan'
      * heeft de volgende 'verblijfplaats' gegevens
        | naam                                       | waarde         |
        | functie adres (10.10)                      |                |
        | datum aanvang adreshouding (10.30)         |                |
        | straatnaam (11.10)                         |                |
        | naam openbare ruimte (11.15)               |                |
        | huisnummer (11.20)                         |                |
        | postcode (11.60)                           |                |
        | woonplaats (11.70)                         |                |
        | identificatiecode verblijfplaats (11.80)   |                |
        | identificatiecode nummeraanduiding (11.90) |                |
        | land vanwaar ingeschreven (14.10)          |                |
        | datum vestiging in Nederland (14.20)       |                |
        | land adres buitenland (13.10)              |           5010 |
        | datum aanvang adres buitenland (13.20)     | gisteren       |
        | regel 1 adres buitenland (13.30)           | Grote Markt 1  |
        | regel 2 adres buitenland (13.40)           | 2000 Antwerpen |
        | ingangsdatum geldigheid (85.10)            | gisteren       |
        | datum van opneming (86.10)                 | vandaag        |
      Als de wijziging BRP van 'Jan' is verwerkt
      Dan is de gebeurtenis gepubliceerd met de volgende gegevens
        | naam        | waarde          |
        | specversion |             1.0 |
        | type        | nl.brp.verhuisd |
        | id          | guid            |
        | time        | timestamp-utc   |
        | pl_id       |               1 |
        | datumVan    | gisteren        |

  Regel: Bij gebeurtenis "verhuisd" worden de actuele gegevens van de nieuwe verblijfplaats aan afnemers geleverd in dezelfde vorm als die in de BRP personen API zitten
    Met deze gebeurtenis worden alleen de op het moment van de gebeurtenis actueel geldende gegevens gestuurd.

    Hierbij worden de volgende gegevens gestuurd:
    - gemeenteVanInschrijving
    - alle velden van verblijfplaats met een waarde, met uitzondering van datumIngangGeldigheid (deze is deprecated)

    Gegevens over immigratie worden niet meegestuurd, ook niet wanneer die bij de gebeurtenis zijn gewijzigd.

    Scenario: Persoon is verhuisd binnen Nederland
      Gegeven de persoon 'Jan' heeft de volgende gegevens
        | naam                        | waarde    |
        | pl_id                       |         1 |
        | burgerservicenummer (01.20) | 000000036 |
      * heeft de volgende 'verblijfplaats' gegevens
        | naam                                       | waarde              |
        | gemeente van inschrijving (09.10)          |                0518 |
        | datum inschrijving in de gemeente (09.20)  |            20240503 |
        | functie adres (10.10)                      | W                   |
        | datum aanvang adreshouding (10.30)         |            20240503 |
        | straatnaam (11.10)                         | Prinses Beatrixlaan |
        | naam openbare ruimte (11.15)               | Prinses Beatrixlaan |
        | huisnummer (11.20)                         |                 116 |
        | postcode (11.60)                           |              2595AL |
        | woonplaats (11.70)                         | 's-Gravenhage       |
        | identificatiecode verblijfplaats (11.80)   |    0518010000584404 |
        | identificatiecode nummeraanduiding (11.90) |    0518200000584403 |
        | land vanwaar ingeschreven (14.10)          |                5010 |
        | datum vestiging in Nederland (14.20)       |            20240503 |
        | ingangsdatum geldigheid (85.10)            |            20240503 |
        | datum van opneming (86.10)                 |            20250908 |
      En de 'verblijfplaats' is gewijzigd naar de volgende gegevens
        | naam                                       | waarde                    |
        | gemeente van inschrijving (09.10)          |                      0518 |
        | datum inschrijving in de gemeente (09.20)  |                  20240503 |
        | functie adres (10.10)                      | W                         |
        | datum aanvang adreshouding (10.30)         |                  20250907 |
        | straatnaam (11.10)                         | Wilhelmina van Pruisenwg  |
        | naam openbare ruimte (11.15)               | Wilhelmina van Pruisenweg |
        | huisnummer (11.20)                         |                        52 |
        | postcode (11.60)                           |                    2595AN |
        | woonplaats (11.70)                         | 's-Gravenhage             |
        | identificatiecode verblijfplaats (11.80)   |          0518010000713450 |
        | identificatiecode nummeraanduiding (11.90) |          0518200000713449 |
        | ingangsdatum geldigheid (85.10)            |                  20250908 |
        | datum van opneming (86.10)                 |                  20250909 |
      En de volgende gebeurtenis is gepubliceerd
        | id             | type     | time    | pl_id | adres_id | datumVan |
        | 1234-ABCD-GUID | verhuisd | vandaag |     1 |       11 | 20250907 |
      Als een gebeurtenis wordt gevraagd met identifier '1234-ABCD-GUID'
      Dan wordt de gebeurtenis met de volgende gegevens geleverd
        | specversion | type            | id             | time    |
        |         1.0 | nl.brp.verhuisd | 1234-ABCD-GUID | vandaag |
      En heeft de gebeurtenis de volgende 'data' gegevens
        | naam                                 | waarde        |
        | gemeenteVanInschrijving.code         |          0518 |
        | gemeenteVanInschrijving.omschrijving | 's-Gravenhage |
      En heeft de 'data' de volgende 'verblijfplaats' gegevens
        | naam                              | waarde                    |
        | functieAdres.code                 | W                         |
        | functieAdres.omschrijving         | woonadres                 |
        | datumVan.type                     | Datum                     |
        | datumVan.datum                    |                2025-09-07 |
        | datumVan.langFormaat              |          7 september 2025 |
        | verblijfadres.korteStraatnaam     | Wilhelmina van Pruisenwg  |
        | verblijfadres.officieleStraatnaam | Wilhelmina van Pruisenweg |
        | verblijfadres.huisnummer          |                        52 |
        | verblijfadres.postcode            |                    2595AN |
        | verblijfadres.woonplaats          | 's-Gravenhage             |
        | adresseerbaarObjectIdentificatie  |          0518010000713450 |
        | nummeraanduidingIdentificatie     |          0518200000713449 |

    Scenario: Vragen om de gebeurtenis van een vorig adres geeft dat vorige adres
      Gegeven de persoon 'Jan' heeft de volgende gegevens
        | naam                        | waarde    |
        | pl_id                       |         1 |
        | burgerservicenummer (01.20) | 000000036 |
      * heeft de volgende 'verblijfplaats' gegevens
        | naam                                       | waarde              |
        | gemeente van inschrijving (09.10)          |                0518 |
        | datum inschrijving in de gemeente (09.20)  |            20240503 |
        | functie adres (10.10)                      | W                   |
        | datum aanvang adreshouding (10.30)         |            20240503 |
        | straatnaam (11.10)                         | Prinses Beatrixlaan |
        | naam openbare ruimte (11.15)               | Prinses Beatrixlaan |
        | huisnummer (11.20)                         |                 116 |
        | postcode (11.60)                           |              2595AL |
        | woonplaats (11.70)                         | 's-Gravenhage       |
        | identificatiecode verblijfplaats (11.80)   |    0518010000584404 |
        | identificatiecode nummeraanduiding (11.90) |    0518200000584403 |
        | land vanwaar ingeschreven (14.10)          |                5010 |
        | datum vestiging in Nederland (14.20)       |            20240503 |
        | ingangsdatum geldigheid (85.10)            |            20240503 |
        | datum van opneming (86.10)                 |            20250908 |
      En de 'verblijfplaats' is gewijzigd naar de volgende gegevens
        | naam                                       | waarde                    |
        | gemeente van inschrijving (09.10)          |                      0518 |
        | datum inschrijving in de gemeente (09.20)  |                  20240503 |
        | functie adres (10.10)                      | W                         |
        | datum aanvang adreshouding (10.30)         |                  20250201 |
        | straatnaam (11.10)                         | Wilhelmina van Pruisenwg  |
        | naam openbare ruimte (11.15)               | Wilhelmina van Pruisenweg |
        | huisnummer (11.20)                         |                        52 |
        | postcode (11.60)                           |                    2595AN |
        | woonplaats (11.70)                         | 's-Gravenhage             |
        | identificatiecode verblijfplaats (11.80)   |          0518010000713450 |
        | identificatiecode nummeraanduiding (11.90) |          0518200000713449 |
        | ingangsdatum geldigheid (85.10)            |                  20250201 |
        | datum van opneming (86.10)                 |                  20250203 |
      En de 'verblijfplaats' is gewijzigd naar de volgende gegevens
        | naam                                       | waarde           |
        | gemeente van inschrijving (09.10)          |             0344 |
        | datum inschrijving in de gemeente (09.20)  |         20250907 |
        | functie adres (10.10)                      | W                |
        | datum aanvang adreshouding (10.30)         |         20250907 |
        | straatnaam (11.10)                         | Stadsplateau     |
        | naam openbare ruimte (11.15)               | Stadsplateau     |
        | huisnummer (11.20)                         |                1 |
        | postcode (11.60)                           |           3521AZ |
        | woonplaats (11.70)                         | Utrecht          |
        | identificatiecode verblijfplaats (11.80)   | 0344010000163715 |
        | identificatiecode nummeraanduiding (11.90) | 0344200000166576 |
        | ingangsdatum geldigheid (85.10)            |         20250908 |
        | datum van opneming (86.10)                 |         20250909 |
      En de volgende gebeurtenis is gepubliceerd
        | id             | type     | time                      | pl_id | adres_id | datumVan |
        | 1234-ABCD-GUID | verhuisd | 2025-02-03T18:23:46+01:00 |     1 |       11 | 20250201 |
      En de volgende gebeurtenis is gepubliceerd
        | id             | type     | time                      | pl_id | adres_id | datumVan |
        | 5678-EFGH-GUID | verhuisd | 2025-09-09T19:03:24+01:00 |     1 |       12 | 20250907 |
      Als een gebeurtenis wordt gevraagd met identifier '1234-ABCD-GUID'
      Dan wordt de gebeurtenis met de volgende gegevens geleverd
        | specversion | type            | id             | time                      |
        |         1.0 | nl.brp.verhuisd | 1234-ABCD-GUID | 2025-02-03T18:23:46+01:00 |
      En heeft de gebeurtenis de volgende 'data' gegevens
        | naam                                 | waarde        |
        | gemeenteVanInschrijving.code         |          0518 |
        | gemeenteVanInschrijving.omschrijving | 's-Gravenhage |
      En heeft de 'data' de volgende 'verblijfplaats' gegevens
        | naam                              | waarde                    |
        | functieAdres.code                 | W                         |
        | functieAdres.omschrijving         | woonadres                 |
        | datumVan.type                     | Datum                     |
        | datumVan.datum                    |                2025-02-01 |
        | datumVan.langFormaat              |           1 februari 2025 |
        | verblijfadres.korteStraatnaam     | Wilhelmina van Pruisenwg  |
        | verblijfadres.officieleStraatnaam | Wilhelmina van Pruisenweg |
        | verblijfadres.huisnummer          |                        52 |
        | verblijfadres.postcode            |                    2595AN |
        | verblijfadres.woonplaats          | 's-Gravenhage             |
        | adresseerbaarObjectIdentificatie  |          0518010000713450 |
        | nummeraanduidingIdentificatie     |          0518200000713449 |
