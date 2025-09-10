# language: nl
Functionaliteit: Omschrijving van de Als stappen voor een gebeurtenis met toevoegen of wijzigen van een persoonslijst

  Achtergrond:
    Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode | straatnaam (11.10)  | huisnummer (11.20) | postcode (11.60) |
      |         0518 | Prinses Beatrixlaan |                116 |           2595AL |
    En persoon 'P1' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) | geboortedatum (03.10) |
      |                   000000012 | Jansen                |            17-03-1998 |
    En persoon 'P2' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) | geboortedatum (03.10) |
      |                   000000024 | Jansen                |            30-07-1996 |

  Regel: met stap "Als persoon '{persoonaanduiding}' met A-nummer '{anummer}' is toegevoegd in de BRP-V met de volgende gegevens" wordt een synchronisatiebericht opgegeven
    - in deze stap worden gegevens uit categorie 1 Persoon aan het bericht toegevoegd
    - in deze stap wordt default categorie 7 (Inschrijving) gemaakt met indicatie geheim (70.10) met waarde 0 (geen beperking)
    - datums worden opgegeven in formaat "DD-MM-JJJJ" en vertaald naar formaat "JJJJMMDD"
    - datums kunnen een relatieve datum bevatten, zoals "gisteren". Deze datum wordt bepaald en vertaald naar formaat "JJJJMMDD"

    Scenario: Als persoon '{persoonaanduiding}' met A-nummer '{anummer}' is toegevoegd in de BRP-V met de volgende gegevens
      Als persoon 'P3' met A-nummer '0000000001' is toegevoegd in de BRP-V met de volgende gegevens
        | burgerservicenummer (01.20) | geslachtsnaam (02.40) | geboortedatum (03.10) |
        |                   000000036 | Boer                  |            26-05-2025 |
      Dan is een bericht voor A-nummer '0000000001' verwerkt met de volgende gegevens op de persoonslijst
        | naam   | waarde     |
        | 010110 | 0000000001 |
        | 010120 |  000000036 |
        | 010240 | Boer       |
        | 010310 |   20250526 |
        | 077010 |          0 |

  Regel: met stap "Als '{persoonaanduiding}' verblijft vanaf '{datum aanvang}' op adres '{adresaanduiding}'" worden de gegevens van de verblijfplaas opgegeven
    - in deze stap worden gegevens uit categorie 8 Verblijfplaats aan het bericht toegevoegd
    - gemeente van inschrijving (09.10) wordt gevuld met de waarde van gemeentecode van het adres waarnaar {adresaanduiding} verwijst
    - datum aanvang adreshouding (10.30) wordt gevuld met de waarde in {datum aanvang}
    - velden in groep 11 adres worden gevuld op basis van het adres waarnaar {adresaanduiding} verwijst
    - datums worden opgegeven in formaat "DD-MM-JJJJ" en vertaald naar formaat "JJJJMMDD"
    - datums kunnen een relatieve datum bevatten, zoals "gisteren". Deze datum wordt bepaald en vertaald naar formaat "JJJJMMDD"

    Scenario: Als '{persoonaanduiding}' verblijft vanaf '{datum aanvang}' op adres '{adresaanduiding}'
      Als persoon 'P3' met A-nummer '0000000001' is toegevoegd in de BRP-V met de volgende gegevens
        | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
        |                   000000036 | Boer                  |
      En 'P2' verblijft vanaf '30-07-2025' op adres 'A1'
      Dan is een bericht voor A-nummer '0000000001' verwerkt met de volgende gegevens op de persoonslijst
        | naam   | waarde              |
        | 010110 |          0000000001 |
        | 010120 |           000000036 |
        | 010240 | Boer                |
        | 077010 |                   0 |
        | 080910 |                0518 |
        | 081030 |            20250730 |
        | 081110 | Prinses Beatrixlaan |
        | 081120 |                 116 |
        | 081160 |              2595AL |

  Regel: met stap "'{persoonaanduiding}' heeft '{aanduiding persoon ouder 1}' en '{aanduiding persoon ouder 2}' als ouders" worden de gegevens van de ouders opgegeven
    - in deze stap worden gegevens uit categorie 2 en 3 (ouder 1 en ouder 2) aan het bericht toegevoegd
    - datum ingang familierechtelijke betrekking (62.10) wordt gevuld met de geboortedatum van de persoon
    - datums worden opgegeven in formaat "DD-MM-JJJJ" en vertaald naar formaat "JJJJMMDD"
    - datums kunnen een relatieve datum bevatten, zoals "gisteren". Deze datum wordt bepaald en vertaald naar formaat "JJJJMMDD"

    Scenario: '{persoonaanduiding}' heeft '{aanduiding persoon ouder 1}' en '{aanduiding persoon ouder 2}' als ouders
      Als persoon 'P3' met A-nummer '0000000001' is toegevoegd in de BRP-V met de volgende gegevens
        | burgerservicenummer (01.20) | geslachtsnaam (02.40) | geboortedatum (03.10) |
        |                   000000012 | Boer                  |            26-05-2025 |
      En 'P3' heeft 'P1' en 'P2' als ouders
      Dan is een bericht voor A-nummer '0000000001' verwerkt met de volgende gegevens op de persoonslijst
        | naam   | waarde     |
        | 010110 | 0000000001 |
        | 010120 |  000000036 |
        | 010240 | Boer       |
        | 010310 |   20250526 |
        | 020120 |  000000012 |
        | 020240 | Jansen     |
        | 020310 |   19980317 |
        | 026210 |   20250526 |
        | 030120 |  000000024 |
        | 030240 | Boer       |
        | 030310 |   19960730 |
        | 036210 |   20250526 |
        | 077010 |          0 |
