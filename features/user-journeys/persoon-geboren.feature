# language: nl
Functionaliteit: Gebeurtenis "persoon-geboren"
  Deze gebeurtenis betekent dat een persoon voor het eerst is ingeschreven in de BRP na de geboorte.

  Achtergrond:
    Gegeven adres 'Prinses_Beatrixlaan_116' heeft de volgende gegevens
      | gemeentecode | straatnaam (11.10)  | naam openbare ruimte (11.15) | huisnummer (11.20) | postcode (11.60) | woonplaats (11.70) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      |         0518 | Prinses Beatrixlaan | Prinses Beatrixlaan          |                116 |           2595AL | 's-Gravenhage      |                         0518010000584404 |                           0518200000584403 |
    En persoon 'Saskia' heeft de volgende gegevens
      | anummer (01.10) | burgerservicenummer (01.20) | voornamen (02.10) | geslachtsnaam (02.40) | geboortedatum (03.10) | geslachtsaanduiding (04.10) |
      |      0000000001 |                   000000012 | Saskia            | Jansen                |            17-03-1998 | V                           |
    En persoon 'Piet' heeft de volgende gegevens
      | anummer (01.10) | burgerservicenummer (01.20) | voornamen (02.10) | geslachtsnaam (02.40) | geboortedatum (03.10) | geslachtsaanduiding (04.10) |
      |      0000000002 |                   000000024 | Piet              | Boer                  |            24-07-1996 | M                           |

  Regel: Een wijziging in de BRP is gebeurtenis "persoon-geboren" wanneer dit een nieuwe persoonslijst is, de gemeente van inschrijving is een Nederlandse gemeente, verblijft in Nederland en de persoon is niet geïmmigreerd
    - er is geen "oud" situatie
    - gemeente van inschrijving (08.09.10) is ongelijk aan 1999 (RNI)
    - land adres buitenland (13.10) heeft geen waarde
    - land vanwaar ingeschreven (14.10) heeft geen waarde
    
    De gebeurtenis "persoon-geboren" bevat alle gegevens in categorieën persoon, ouder 1, ouder 2 (optioneel), nationaliteit (optioneel), inschrijving en verblijfplaats

    Scenario: Kind is geboren in Nederland met twee ouders die beide ingezeten zijn
      Als persoon 'Jan' met A-nummer '0000000003' is toegevoegd in de BRP-V met de volgende gegevens
        | naam                        | waarde    |
        | burgerservicenummer (01.20) | 000000036 |
        | voornamen (02.10)           | Jan       |
        | geslachtsnaam (02.40)       | Boer      |
        | geboortedatum (03.10)       | gisteren  |
        | geboorteplaats (03.20)      |      0518 |
        | geboorteland (03.30)        |      6030 |
        | geslachtsaanduiding (04.10) | M         |
        | aktenummer (81.20)          |   1XA1234 |
      En 'Jan' verblijft vanaf 'gisteren' op adres 'Prinses_Beatrixlaan_116'
      En 'Jan' heeft 'Saskia' en 'Piet' als ouders
      Dan is een gebeurtenis 'persoon-geboren' vastgelegd met de volgende gegevens
        | naam                        | waarde     |
        | anummer (01.10)             | 0000000003 |
        | burgerservicenummer (01.20) |  000000036 |
        | voornamen (02.10)           | Jan        |
        | geslachtsnaam (02.40)       | Boer       |
        | geboortedatum (03.10)       | gisteren   |
        | geboorteplaats (03.20)      |       0518 |
        | geboorteland (03.30)        |       6030 |
        | geslachtsaanduiding (04.10) | M          |
        | aktenummer (81.20)          |    1XA1234 |
      En heeft de gebeurtenis de volgende 'Inschrijving' gegevens
        | naam                     | waarde |
        | indicatie geheim (70.10) |      0 |
      En heeft de gebeurtenis de volgende 'Ouder 1' gegevens
        | naam                                               | waarde     |
        | anummer (01.10)                                    | 0000000001 |
        | burgerservicenummer (01.20)                        |  000000012 |
        | voornamen (02.10)                                  | Saskia     |
        | geslachtsnaam (02.40)                              | Jansen     |
        | geboortedatum (03.10)                              | 17-03-1998 |
        | geslachtsaanduiding (04.10)                        | V          |
        | datum ingang familierechtelijke betrekking (62.10) | gisteren   |
      En heeft de gebeurtenis de volgende 'Ouder 2' gegevens
        | naam                                               | waarde     |
        | anummer (01.10)                                    | 0000000002 |
        | burgerservicenummer (01.20)                        |  000000024 |
        | voornamen (02.10)                                  | Piet       |
        | geslachtsnaam (02.40)                              | Boer       |
        | geboortedatum (03.10)                              | 24-07-1996 |
        | geslachtsaanduiding (04.10)                        | M          |
        | datum ingang familierechtelijke betrekking (62.10) | gisteren   |
      En heeft de gebeurtenis de volgende 'Verblijfplaats' gegevens
        | naam                                       | waarde              |
        | gemeente van inschrijving (09.10)          |                0518 |
        | datum aanvang adreshouding (10.30)         | gisteren            |
        | straatnaam (11.10)                         | Prinses Beatrixlaan |
        | naam openbare ruimte (11.15)               | Prinses Beatrixlaan |
        | huisnummer (11.20)                         |                 116 |
        | postcode (11.60)                           |              2595AL |
        | woonplaats (11.70)                         | 's-Gravenhage       |
        | identificatiecode verblijfplaats (11.80)   |    0518010000584404 |
        | identificatiecode nummeraanduiding (11.90) |    0518200000584403 |
