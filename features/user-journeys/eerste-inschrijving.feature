# language: nl
Functionaliteit: Gebeurtenissen die een eerste inschrijving betreffen

  Regel: Een wijziging in de BRP is gebeurtenis "ingeschreven" wanneer een persoon voor het eerst wordt ingeschreven in de BRP of RNI
    Een wijziging is gebeurtenis "ingeschreven" wanneer de verschillen analyse bevat geen was-situatie, of PL-versienummer=1

    Scenario: Kind is geboren in Nederland met twee ouders
      Gegeven de 1e inschrijving BRP van 'Jan'
      * heeft de volgende gegevens
        | naam                        | waarde    |
        | burgerservicenummer (01.20) | 000000036 |
        | voornamen (02.10)           | Jan       |
        | geslachtsnaam (02.40)       | Boer      |
        | geboortedatum (03.10)       | gisteren  |
        | geboorteplaats (03.20)      |      0518 |
        | geboorteland (03.30)        |      6030 |
        | aktenummer (81.20)          |   1XA1234 |
      * heeft een 'ouder' net de volgende gegevens
        | anummer (01.10) | burgerservicenummer (01.20) | voornamen (02.10) | geslachtsnaam (02.40) | geboortedatum (03.10) | datum ingang familierechtelijke betrekking (62.10) |
        |      0000000001 |                   000000012 | Saskia            | Jansen                |              19980317 | gisteren                                           |
      * heeft een 'ouder' net de volgende gegevens
        | anummer (01.10) | burgerservicenummer (01.20) | voornamen (02.10) | geslachtsnaam (02.40) | geboortedatum (03.10) | datum ingang familierechtelijke betrekking (62.10) |
        |      0000000002 |                   000000024 | Piet              | Boer                  |              19960724 | gisteren                                           |
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
      Als de 1e inschrijving BRP van 'Jan' is verwerkt met PL id 1
      Dan is de gebeurtenis gepubliceerd met de volgende gegevens
        | naam        | waarde              |
        | specversion |                 1.0 |
        | type        | nl.brp.ingeschreven |
        | id          | guid                |
        | time        | timestamp-utc       |
        | pl_id       |                   1 |

    Scenario: Persoon wordt ingeschreven als niet-ingezetene in het RNI
      Gegeven de 1e inschrijving BRP van 'Jan'
      * heeft de volgende gegevens
        | naam                        | waarde    |
        | burgerservicenummer (01.20) | 000000036 |
        | voornamen (02.10)           | Jan       |
        | geslachtsnaam (02.40)       | Boer      |
        | geboortedatum (03.10)       |  19980730 |
        | geboorteplaats (03.20)      | Antwerpen |
        | geboorteland (03.30)        |      5010 |
      * heeft de volgende 'inschrijving' gegevens
        | naam                                 | waarde   |
        | datum opschorting bijhouding (67.10) | gisteren |
        | reden opschorting bijhouding (67.20) | R        |
      * heeft de volgende 'verblijfplaats' gegevens
        | naam                                   | waarde         |
        | gemeente van inschrijving (09.10)      |           1999 |
        | land adres buitenland (13.10)          |           5010 |
        | datum aanvang adres buitenland (13.20) | gisteren       |
        | regel 1 adres buitenland (13.30)       | Grote Markt 1  |
        | regel 2 adres buitenland (13.40)       | 2000 Antwerpen |
      Als de 1e inschrijving BRP van 'Jan' is verwerkt met PL id 1
      Dan is de gebeurtenis gepubliceerd met de volgende gegevens
        | naam        | waarde              |
        | specversion |                 1.0 |
        | type        | nl.brp.ingeschreven |
        | id          | guid                |
        | time        | timestamp-utc       |
        | pl_id       |                   1 |

    Scenario: Persoon immigreert naar Nederland
      Gegeven de 1e inschrijving BRP van 'Jan'
      * heeft de volgende gegevens
        | naam                        | waarde    |
        | burgerservicenummer (01.20) | 000000036 |
        | voornamen (02.10)           | Jan       |
        | geslachtsnaam (02.40)       | Boer      |
        | geboortedatum (03.10)       |  19980730 |
        | geboorteplaats (03.20)      | Antwerpen |
        | geboorteland (03.30)        |      5010 |
      * heeft een 'ouder' net de volgende gegevens
        | anummer (01.10) | burgerservicenummer (01.20) | voornamen (02.10) | geslachtsnaam (02.40) | geboortedatum (03.10) | datum ingang familierechtelijke betrekking (62.10) |
        |      0000000001 |                   000000012 | Saskia            | Jansen                |              19980317 | gisteren                                           |
      * heeft een 'ouder' net de volgende gegevens
        | anummer (01.10) | burgerservicenummer (01.20) | voornamen (02.10) | geslachtsnaam (02.40) | geboortedatum (03.10) | datum ingang familierechtelijke betrekking (62.10) |
        |      0000000002 |                   000000024 | Piet              | Boer                  |              19960724 | gisteren                                           |
      * heeft de volgende 'verblijfplaats' gegevens
        | naam                                       | waarde              |
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
      Als de 1e inschrijving BRP van 'Jan' is verwerkt met PL id 1
      Dan is de gebeurtenis gepubliceerd met de volgende gegevens
        | naam        | waarde              |
        | specversion |                 1.0 |
        | type        | nl.brp.ingeschreven |
        | id          | guid                |
        | time        | timestamp-utc       |
        | pl_id       |                   1 |

  Regel: Bij gebeurtenis "ingeschreven" worden de actuele gegevens van de persoon aan afnemers geleverd in dezelfde vorm als die in de BRP personen API zitten

    Scenario: Persoon immigreert naar Nederland
      Gegeven de persoon 'Jan' heeft de volgende gegevens
        | naam                        | waarde     |
        | pl_id                       |          1 |
        | anummer (01.10)             | 0000000003 |
        | burgerservicenummer (01.20) |  000000036 |
        | voornamen (02.10)           | Jan        |
        | geslachtsnaam (02.40)       | Boer       |
        | geboortedatum (03.10)       |   20190730 |
        | geboorteplaats (03.20)      | Antwerpen  |
        | geboorteland (03.30)        |       5010 |
      * heeft een 'ouder' net de volgende gegevens
        | anummer (01.10) | burgerservicenummer (01.20) | voornamen (02.10) | geslachtsnaam (02.40) | geboortedatum (03.10) | datum ingang familierechtelijke betrekking (62.10) |
        |      0000000001 |                   000000012 | Saskia            | Jansen                |              19980317 |                                           20190730 |
      * heeft een 'ouder' net de volgende gegevens
        | anummer (01.10) | burgerservicenummer (01.20) | voornamen (02.10) | geslachtsnaam (02.40) | geboortedatum (03.10) | datum ingang familierechtelijke betrekking (62.10) |
        |      0000000002 |                   000000024 | Piet              | Boer                  |              19960724 |                                           20190730 |
      * heeft de volgende 'verblijfplaats' gegevens
        | naam                                       | waarde              |
        | gemeente van inschrijving (09.10)          |                0518 |
        | datum inschrijving in de gemeente (09.20)  |            20250907 |
        | functie adres (10.10)                      | W                   |
        | datum aanvang adreshouding (10.30)         |            20250907 |
        | straatnaam (11.10)                         | Prinses Beatrixlaan |
        | naam openbare ruimte (11.15)               | Prinses Beatrixlaan |
        | huisnummer (11.20)                         |                 116 |
        | postcode (11.60)                           |              2595AL |
        | woonplaats (11.70)                         | 's-Gravenhage       |
        | identificatiecode verblijfplaats (11.80)   |    0518010000584404 |
        | identificatiecode nummeraanduiding (11.90) |    0518200000584403 |
        | land vanwaar ingeschreven (14.10)          |                5010 |
        | datum vestiging in Nederland (14.20)       |            20250907 |
        | ingangsdatum geldigheid (85.10)            |            20250907 |
        | datum van opneming (86.10)                 |            20250908 |
      En de volgende gebeurtenis is gepubliceerd
        | id             | type         | time     | pl_id |
        | 1234-ABCD-GUID | ingeschreven | gisteren |     1 |
      Als een gebeurtenis wordt gevraagd met identifier '1234-ABCD-GUID'
      Dan wordt de gebeurtenis met de volgende gegevens geleverd
        | specversion | type                | id             | time     |
        |         1.0 | nl.brp.ingeschreven | 1234-ABCD-GUID | gisteren |
      En heeft de gebeurtenis de volgende 'data' gegevens
        | naam                                    | waarde           |
        | aNummer                                 |       0000000003 |
        | burgerservicenummer                     |        000000036 |
        | naam.voornamen                          | Jan              |
        | geslachtsnaam                           | Boer             |
        | geboorte.datum.type                     | datum            |
        | geboorte.datum.datum                    |       2019-07-30 |
        | geboorte.datum.langFormaat              |     30 juli 2019 |
        | geboorte.plaats.omschrijving            | Antwerpen        |
        | geboorte.land.code                      |             6030 |
        | geboorte.land.omschrijving              | België           |
        | gemeenteVanInschrijving.code            |             0518 |
        | gemeenteVanInschrijving.omschrijving    | 's-Gravenhage    |
        | datumInschrijvingInGemeente.type        | Datum            |
        | datumInschrijvingInGemeente.datum       |       2025-09-07 |
        | datumInschrijvingInGemeente.langFormaat | 7 september 2025 |
      En heeft de 'data' een 'ouder' met de volgende gegevens
        | naam                                                      | waarde        |
        | burgerservicenummer                                       |     000000012 |
        | naam.voornamen                                            | Saskia        |
        | naam.geslachtsnaam                                        | Jansen        |
        | geboorte.datum.type                                       | Datum         |
        | geboorte.datum.datum                                      |    1998-03-17 |
        | geboorte.datum.langFormaat                                | 17 maart 1998 |
        | datumIngangFamilierechtelijkeBetrekking.datum.type        | Datum         |
        | datumIngangFamilierechtelijkeBetrekking.datum.datum       |    2019-07-30 |
        | datumIngangFamilierechtelijkeBetrekking.datum.langFormaat |  30 juli 2019 |
      En heeft de 'data' een 'ouder' met de volgende gegevens
        | naam                                                      | waarde       |
        | burgerservicenummer                                       |    000000024 |
        | naam.voornamen                                            | Piet         |
        | naam.geslachtsnaam                                        | Boer         |
        | geboorte.datum.type                                       | Datum        |
        | geboorte.datum.datum                                      |   1996-07-24 |
        | geboorte.datum.langFormaat                                | 24 juli 1996 |
        | datumIngangFamilierechtelijkeBetrekking.datum.type        | Datum        |
        | datumIngangFamilierechtelijkeBetrekking.datum.datum       |   2019-07-30 |
        | datumIngangFamilierechtelijkeBetrekking.datum.langFormaat | 30 juli 2019 |
      En heeft de 'data' de volgende 'verblijfplaats' gegevens
        | naam                              | waarde              |
        | functieAdres.code                 | W                   |
        | functieAdres.omschrijving         | woonadres           |
        | datumVan.type                     | Datum               |
        | datumVan.datum                    |          2025-09-07 |
        | datumVan.langFormaat              |    7 september 2025 |
        | verblijfadres.korteStraatnaam     | Prinses Beatrixlaan |
        | verblijfadres.officieleStraatnaam | Prinses Beatrixlaan |
        | verblijfadres.huisnummer          |                 116 |
        | verblijfadres.postcode            |              2595AL |
        | verblijfadres.woonplaats          | 's-Gravenhage       |
        | adresseerbaarObjectIdentificatie  |    0518010000584404 |
        | nummeraanduidingIdentificatie     |    0518200000584403 |
      En heeft de 'data' de volgende 'immigratie' gegevens
        | naam                                  | waarde           |
        | landVanwaarIngeschreven.code          |             5010 |
        | landVanwaarIngeschreven.omschrijving  | België           |
        | datumVestigingInNederland.type        | Datum            |
        | datumVestigingInNederland.datum       |       2025-09-07 |
        | datumVestigingInNederland.langFormaat | 7 september 2025 |
