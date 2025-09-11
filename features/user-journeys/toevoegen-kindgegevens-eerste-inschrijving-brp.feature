# language: nl
Functionaliteit: Gebeurtenis "kindgegevens-toegevoegd"

  Regel: Een bericht wordt geclassificeerd als "kindgegevens-toegevoegd" als een van de volgende wijzigingen plaatsvinden:
  - Opnemen kindgegevens bij eerste inschrijving
# Overige wijzigingen (niet beschreven in deze feature)
# - Opnemen kindgegevens bij geboorte
# - Opnemen kindgegevens bij adoptie
# - Opnemen kindgegevens bij herroeping van adoptie
# - Opnemen kindgegevens bij erkenning
# - Opnemen kindgegevens bij nietigverklaring van erkenning
# - Opnemen kindgegevens bij ontkenning
# - Opnemen kindgegevens bij ontkenning, gevolgd door erkenning
# - Opnemen kindgegevens bij adoptie ongeboren vrucht

    Scenario: Kindgegevens opgenomen bij eerste inschrijving van een persoon die ouder is van één kind
      Gegeven de 1e inschrijving BRP van 'Piet' 
      * heeft de volgende gegevens
        | anummer (01.10) | burgerservicenummer (01.20) | voornamen (02.10) | geslachtsnaam (02.40) | geboortedatum (03.10) | geslachtsaanduiding (04.10) |
        |      0000000002 |                   000000024 | Piet              | Boer                  |            24-07-1996 | M                           |
      * heeft de volgende 'kind' gegevens
        | naam                        | waarde    |
        | burgerservicenummer (01.20) | 000000036 |
        | voornamen (02.10)           | Jan       |
        | geslachtsnaam (02.40)       | Boer      |
        | geboortedatum (03.10)       |  20240101 |
        | geboorteplaats (03.20)      |      0518 |
        | geboorteland (03.30)        |      6030 |
        | geslachtsaanduiding (04.10) | M         |
        | aktenummer (81.20)          |   1XA1234 |
      Als de 1e inschrijving BRP van 'Piet' is verwerkt met PL id 1
      Dan is de gebeurtenis gepubliceerd met de volgende gegevens
        | naam           | waarde                         |
        | specversion    |                            1.0 |
        | type           | nl.brp.kindgegevens-toegevoegd |
        | id             | guid                           |
        | time           | timestamp-utc                  |
        | pl_id          |                              1 |
        | stapel_nr_kind |                              1 |

    Scenario: Kindgegevens zijn opgenomen bij een persoon
      Gegeven de persoon 'Piet' heeft de volgende gegevens
        | pl_id | persoon_type | stapel_nr | burgerservicenummer (01.20) | voornamen (02.10) | geslachtsnaam (02.40) | geboortedatum (03.10) |
        |     1 | P            |         0 |                   000000024 | Piet              | Boer                  |              19960724 |
        |     1 | K            |         0 |                   000000036 | Lisa              | Boer                  |              20120403 |
        |     1 | K            |         1 |                   000000048 | Jan               | Boer                  |              20200609 |
      En de volgende gebeurtenis is gepubliceerd
        | id             | type                    | time                    | pl_id | stapel_nr_kind |
        | 1234-ABCD-GUID | kindgegevens-toegevoegd | vandaag 2 dagen geleden |     1 |              1 |
      Als een gebeurtenis wordt gevraagd met identifier '1234-ABCD-GUID'
      Dan wordt de gebeurtenis met de volgende gegevens geleverd
        | specversion | type                           | id             | time                    |
        |         1.0 | nl.brp.kindgegevens-toegevoegd | 1234-ABCD-GUID | vandaag 2 dagen geleden |
      En heeft de gebeurtenis de volgende 'data' gegevens
        | burgerservicenummer | kind.burgerservicenummer | kind.naam.volledigeNaam | kind.geboorte.datum.type | kind.geboorte.datum.datum | kind.geboorte.datum.langFormaat | kind.geboorte.land.code | kind.geboorte.land.omschrijving | kind.geboorte.plaats.code | kind.geboorte.plaats.omschrijving |
        |           000000024 |                000000048 | Jan Boer                | Datum                    |                  20240101 |                  1 januari 2024 |                    6030 | Nederland                       |                      0518 | 's Gravenhage                     |
