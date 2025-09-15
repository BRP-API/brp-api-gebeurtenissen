# language: nl
Functionaliteit: Gebeurtenis "inschrijving-op-adres"

  Regel: Een bericht wordt geclassificeerd als "inschrijving-op-adres" als een van de volgende processen plaatsvinden:
  - Inschrijving op adres bij geboorteaangifte
  - Inschrijving op adres bij binnengemeentelijke verhuizing
  - Inschrijving op adres bij intergemeentelijke verhuizing
  - Inschrijving op adres bij immigratie (inschrijving vanuit het buitenland)

    Scenario: Inschrijving op adres bij geboorteaangifte
      Gegeven de 1e inschrijving BRP van 'Piet'
      * heeft de volgende gegevens
        | anummer (01.10) | burgerservicenummer (01.20) | voornamen (02.10) | geslachtsnaam (02.40) | geboortedatum (03.10) | geslachtsaanduiding (04.10) |
        |      0000000002 |                   000000024 | Piet              | Boer                  | gisteren              | M                           |
      * heeft de volgende 'verblijfplaats' gegevens
        | naam                                       | waarde              |
        | gemeente van inschrijving (09.10)          |                0518 |
        | datum inschrijving in de gemeente (09.20)  | gisteren            |
        | functie adres (10.10)                      | W                   |
        | datum aanvang adreshouding (10.30)         | gisteren            |
        | straatnaam (11.10)                         | Prinses Beatrixlaan |
        | naam openbare ruimte (11.15)               | Prinses Beatrixlaan |
        | huisnummer (11.20)                         |                 116 |
        | postcode (11.60)                           |              2595AL |
        | woonplaats (11.70)                         | 's-Gravenhage       |
        | identificatiecode verblijfplaats (11.80)   |    0518010000584404 |
        | identificatiecode nummeraanduiding (11.90) |    0518200000584403 |
        | ingangsdatum geldigheid (85.10)            | gisteren            |
        | datum van opneming (86.10)                 | vandaag             |
      Als de 1e inschrijving BRP van 'Piet' is verwerkt met PL id 1 en adres id 1
      Dan is de gebeurtenis gepubliceerd met de volgende gegevens
        | naam          | waarde                    |
        | specversion   |                       1.0 |
        | type          | nl.brp.bewoning-gewijzigd |
        | id            | guid                      |
        | subject       | geboorteaangifte          |
        | time          | timestamp-utc             |
        | data.pl_id    |                         1 |
        | data.adres_id |                         1 |

    Scenario: Inschrijving op adres bij binnengemeentelijke verhuizing
      Gegeven persoon 'Piet' heeft de volgende gegevens
        | pl_id | anummer (01.10) | burgerservicenummer (01.20) | voornamen (02.10) | geslachtsnaam (02.40) | geboortedatum (03.10) | geslachtsaanduiding (04.10) |
        |     1 |      0000000002 |                   000000024 | Piet              | Boer                  |              19960724 | M                           |
      En adres 'A1' heeft de volgende gegevens
        | gemeente van inschrijving (09.10) | postcode (11.60) |
        |                              0518 |           2595AL |
      En 'Piet' verblijft vanaf 'vandaag 5 jaar geleden' op adres 'A1'
      En adres 'A2' heeft de volgende gegevens
        | gemeente van inschrijving (09.10) | postcode (11.60) |
        |                              0518 |           2595AC |
      En 'Piet' verhuist 'vandaag' van adres 'A1' naar adres 'A2'
      Als de verhuizing van 'Piet' is verwerkt met adres id 2
      Dan is de gebeurtenis gepubliceerd met de volgende gegevens
        | naam          | waarde                         |
        | specversion   |                            1.0 |
        | type          | nl.brp.bewoning-gewijzigd      |
        | id            | guid                           |
        | subject       | binnengemeentelijke verhuizing |
        | time          | timestamp-utc                  |
        | data.pl_id    |                              1 |
        | data.adres_id |                              2 |

    Scenario: Inschrijving op adres bij intergemeentelijke verhuizing
      Gegeven persoon 'Piet' heeft de volgende gegevens
        | pl_id | anummer (01.10) | burgerservicenummer (01.20) | voornamen (02.10) | geslachtsnaam (02.40) | geboortedatum (03.10) | geslachtsaanduiding (04.10) |
        |     1 |      0000000002 |                   000000024 | Piet              | Boer                  |              19960724 | M                           |
      En adres 'A1' heeft de volgende gegevens
        | gemeente van inschrijving (09.10) | postcode (11.60) |
        |                              0518 |           2595AL |
      En 'Piet' verblijft vanaf 'vandaag 5 jaar geleden' op adres 'A1'
      En adres 'A2' heeft de volgende gegevens
        | gemeente van inschrijving (09.10) | postcode (11.60) |
        |                              0363 |           1012NP |
      En 'Piet' verhuist 'vandaag' van adres 'A1' naar adres 'A2'
      Als de verhuizing van 'Piet' is verwerkt met adres id 2
      Dan is de gebeurtenis gepubliceerd met de volgende gegevens
        | naam          | waarde                        |
        | specversion   |                           1.0 |
        | type          | nl.brp.bewoning-gewijzigd     |
        | id            | guid                          |
        | subject       | intergemeentelijke verhuizing |
        | time          | timestamp-utc                 |
        | data.pl_id    |                             1 |
        | data.adres_id |                             2 |

    Scenario: Inschrijving op adres bij immigratie (inschrijving BRP vanuit het buitenland)
      Gegeven de 1e inschrijving BRP vanuit het buitenland van 'Piet'
      * heeft de volgende gegevens
        | anummer (01.10) | burgerservicenummer (01.20) | voornamen (02.10) | geslachtsnaam (02.40) | geboortedatum (03.10) | geslachtsaanduiding (04.10) |
        |      0000000002 |                   000000024 | Piet              | Boer                  | gisteren              | M                           |
      * heeft de volgende 'verblijfplaats' gegevens
        | naam                                       | waarde              |
        | gemeente van inschrijving (09.10)          |                0518 |
        | datum inschrijving in de gemeente (09.20)  | gisteren            |
        | functie adres (10.10)                      | W                   |
        | datum aanvang adreshouding (10.30)         | gisteren            |
        | straatnaam (11.10)                         | Prinses Beatrixlaan |
        | naam openbare ruimte (11.15)               | Prinses Beatrixlaan |
        | huisnummer (11.20)                         |                 116 |
        | postcode (11.60)                           |              2595AL |
        | woonplaats (11.70)                         | 's-Gravenhage       |
        | identificatiecode verblijfplaats (11.80)   |    0518010000584404 |
        | identificatiecode nummeraanduiding (11.90) |    0518200000584403 |
        | ingangsdatum geldigheid (85.10)            | gisteren            |
        | datum van opneming (86.10)                 | vandaag             |
      Als de 1e inschrijving vanuit het buitenland van 'Piet' is verwerkt met PL id 1 en adres id 1
      Dan is de gebeurtenis gepubliceerd met de volgende gegevens
        | naam          | waarde                    |
        | specversion   |                       1.0 |
        | type          | nl.brp.bewoning-gewijzigd |
        | id            | guid                      |
        | subject       | immigratie                |
        | time          | timestamp-utc             |
        | data.pl_id    |                         1 |
        | data.adres_id |                         1 |

    Scenario: Inschrijving op een adres
      Gegeven de persoon 'Piet' heeft de volgende gegevens
        | pl_id | persoon_type | stapel_nr | burgerservicenummer (01.20) | voornamen (02.10) | geslachtsnaam (02.40) | geboortedatum (03.10) |
        |     1 | P            |         0 |                   000000024 | Piet              | Boer                  |              19960724 |
      En adres 'A1' heeft de volgende gegevens
        | naam                                       | waarde              |
        | adres_id                                   |                   1 |
        | gemeente van inschrijving (09.10)          |                0518 |
        | datum inschrijving in de gemeente (09.20)  |            20250907 |
        | functie adres (10.10)                      | W                   |
        | datum aanvang adreshouding (10.30)         | gisteren            |
        | straatnaam (11.10)                         | Prinses Beatrixlaan |
        | naam openbare ruimte (11.15)               | Prinses Beatrixlaan |
        | huisnummer (11.20)                         |                 116 |
        | postcode (11.60)                           |              2595AL |
        | woonplaats (11.70)                         | 's-Gravenhage       |
        | identificatiecode verblijfplaats (11.80)   |    0518010000584404 |
        | identificatiecode nummeraanduiding (11.90) |    0518200000584403 |
        | land vanwaar ingeschreven (14.10)          |                5010 |
        | datum vestiging in Nederland (14.20)       |            20250907 |
        | ingangsdatum geldigheid (85.10)            | gisteren            |
        | datum van opneming (86.10)                 | vandaag             |
      En 'Piet' verblijft vanaf 'gisteren' op adres 'A1'
      En de volgende gebeurtenis is gepubliceerd
        | id             | type                      | time                    | data.pl_id | data.adres_id |
        | 1234-ABCD-GUID | nl.brp.bewoning-gewijzigd | vandaag 2 dagen geleden |          1 |             1 |
      Als een gebeurtenis wordt gevraagd met identifier '1234-ABCD-GUID'
      Dan wordt de gebeurtenis met de volgende gegevens geleverd
        | specversion | type                      | id             | time                    |
        |         1.0 | nl.brp.bewoning-gewijzigd | 1234-ABCD-GUID | vandaag 2 dagen geleden |
      En heeft de gebeurtenis de volgende 'data' gegevens
        | burgerservicenummer | gemeenteVanInschrijving | datumInschrijvingInGemeente | verblijfplaats |
        |           000000024 | ...                     | ...                         | ...            |
