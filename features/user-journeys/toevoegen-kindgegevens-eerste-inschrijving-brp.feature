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

    Scenario: Kindgegevens opgenomen bij eerste inschrijving van een persoon die ouder is van een kind
      Gegeven de persoon 'Piet' met PL id 1 heeft de volgende gegevens
        | anummer (01.10) | burgerservicenummer (01.20) | voornamen (02.10) | geslachtsnaam (02.40) | geboortedatum (03.10) | geslachtsaanduiding (04.10) |
        |      0000000002 |                   000000024 | Piet              | Boer                  |            24-07-1996 | M                           |
      En de 1e inschrijving BRP van 'Piet'
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
      Als de 1e inschrijving BRP van 'Piet' is verwerkt
      Dan is de gebeurtenis gepubliceerd met de volgende gegevens
        | naam  | waarde                  |
        | type  | kindgegevens-toegevoegd |
        | pl_id |                       1 |
