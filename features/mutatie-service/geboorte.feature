# language: nl
Functionaliteit: geboorteaangifte
  Als provider van BRP API Gebeurtenissen
  wil ik een mutatie service die het gedrag van de BRPV nabootst
  zodat ik de functionaliteit van BRP API Gebeurtenissen kan valideren zonder afhankelijk te zijn van een echte BRPV

  Achtergrond:
    Gegeven adres 'Sesamstraat' is de standaard adres die wordt opgegeven als verblijfplaats bij een standaard geboorte aangifte
    Als de aangifte van geboorte van 'Jan' is verwerkt

  Regel: de response van een successvolle geboorte aangifte is 201 Created en bevat de pl_id van het kind

    Scenario: een succesvol verwerkte aangifte van geboorte command
      Dan is de response een 'Created' response
      * heeft de volgende http headers
        | Status      | Content-Type     |
        | 201 Created | application/json |
      * heeft de body de volgende velden
        | pl_id |
        | Jan   |

  Regel: een successvolle geboorte aangifte leidt tot het aanmaken van een persoonslijst in de BRPV database

    Scenario: een succesvol verwerkte aangifte van geboorte command
      Dan is de volgende rij toegevoegd in tabel 'lo3_pl
        | pl_id |
        | Jan   |
      En zijn de volgende rijen toegevoegd in tabel 'lo3_pl_persoon
        | pl_id | persoon_type |
        | Jan   | P            |
        | Jan   |            1 |
        | Jan   |            2 |
      En is de volgende rij toegevoegd in tabel 'lo3_pl_verblijfplaats
        | pl_id | adres_id    |
        | Jan   | Sesamstraat |

  Regel: een successvolle geboorte aangifte leidt tot het publiceren van een 'ingeschreven' met subject 'geboorte' gebeurtenis

    Scenario: geboorteaangifte van een kind geboren in Nederland
      Dan is een 'ingeschreven.geboorte' gebeurtenis gepubliceerd
      * heeft de volgende gegevens
        | specversion | type                         | id   | time          |
        |         1.0 | nl.brp.ingeschreven.geboorte | guid | timestamp-utc |
      * heeft de volgende 'data' gegevens
        | pl_id |
        | Jan   |
