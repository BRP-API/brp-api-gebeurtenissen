# language: nl
Functionaliteit: Omschrijving van de Dan stappen voor een gebeurtenis

  Regel: met stap "Dan is een gebeurtenis '{gebeurtenisaanduiding}' vastgelegd met de volgende gegevens" wordt gecontroleerd dat de gebeurtenis met de verwachtte aanduiding en verwachte gegevens wordt bepaald
    - in deze stap worden gegevens uit categorie 1 Persoon aan de verwachte gebeurtenis toegevoegd
    - na de laatste Dan stap wordt gecontroleerd dat de beschreven gebeurtenis met de verwachte gegevens is vastgelegd

  Regel: met stap "Dan heeft de gebeurtenis de volgende '{categorie omschrijving}' gegevens" worden de verwachte gegevens in genoemde categorie aan de gebeurtenis toegevoegd
    - categorienamen vertalen als volgt:
      | categorie omschrijving | categorie nummer |
      | Ouder 1                | 2                |
      | Ouder 2                | 3                |
      | Nationaliteit          | 4                |
      | Partner                | 5                |
      | Overlijden             | 6                |
      | Inschrijving           | 7                |
      | Verblijfplaats         | 8                |

    Scenario: gebeurtenis
      Gegeven een gebeurtenis 'persoon-geboren' is vastgelegd
      En de gebeurtenis heeft de volgende gegevens in categorie 1
        | naam                                               | waarde     |
        | anummer (01.10)                                    | 0000000001 |
        | burgerservicenummer (01.20)                        |  000000036 |
        | geslachtsnaam (02.40)                              | Boer       |
        | geboortedatum (03.10)                              |   20250526 |
      En de gebeurtenis heeft de volgende gegevens in categorie 2
        | burgerservicenummer (01.20)                        |  000000012 |
        | geslachtsnaam (02.40)                              | Jansen     |
        | geboortedatum (03.10)                              |   19980317 |
        | datum ingang familierechtelijke betrekking (62.10) |   20250526 |
      En de gebeurtenis heeft de volgende gegevens in categorie 3
        | burgerservicenummer (01.20)                        |  000000024 |
        | geslachtsnaam (02.40)                              | Boer       |
        | geboortedatum (03.10)                              |   19960730 |
        | datum ingang familierechtelijke betrekking (62.10) |   20250526 |
        | indicatie geheim (70.10)                           |          0 |
      Dan is een gebeurtenis 'persoon-geboren' vastgelegd met de volgende gegevens
        | anummer (01.10) | burgerservicenummer (01.20) | geslachtsnaam (02.40) | geboortedatum (03.10) |
        |      0000000001 |                   000000036 | Boer                  |              20250526 |
      En heeft de gebeurtenis de volgende 'Inschrijving' gegevens
        | indicatie geheim (70.10) |
        |                        0 |
      En heeft de gebeurtenis de volgende 'Ouder 1' gegevens
        | burgerservicenummer (01.20) | geslachtsnaam (02.40) | geboortedatum (03.10) | datum ingang familierechtelijke betrekking (62.10) |
        |                   000000012 | Jansen                |            17-03-1998 |                                           20250526 |
      En heeft de gebeurtenis de volgende 'Ouder 2' gegevens
        | burgerservicenummer (01.20) | geslachtsnaam (02.40) | geboortedatum (03.10) | datum ingang familierechtelijke betrekking (62.10) |
        |                   000000024 | Boer                  |            30-07-1996 |                                           20250526 |
