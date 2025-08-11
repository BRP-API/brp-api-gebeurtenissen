# language: nl
Functionaliteit: Ingeschreven in de BRP

  Scenario: een standaard persoon ingeschreven in de gemeente van een standaard adres
    Gegeven adres 'A1'
    En persoon 'Jan'
    En 'Jan' verblijft vanaf 'gisteren 5 jaar geleden' op adres 'A1'
    En 'Jan' is ingeschreven in de BRP
    Dan is een rij met de volgende gegevens toegevoegd in tabel 'lo3_pl'
      | naam       | waarde |
      | pl_id      | Jan    |
      | geheim_ind |      0 |
    En is een rij met de volgende gegevens toegevoegd in tabel 'lo3_pl_persoon'
      | naam              | waarde                   |
      | pl_id             | Jan                      |
      | stapel_nr         |                        0 |
      | volg_nr           |                        0 |
      | persoon_type      | P                        |
      | burger_service_nr |                000000012 |
      | geslachts_naam    | Jan                      |
      | geboorte_datum    | gisteren 18 jaar geleden |
    En is een rij met de volgende gegevens toegevoegd in tabel 'lo3_pl_verblijfplaats'
      | naam                       | waarde                  |
      | pl_id                      | Jan                     |
      | adres_id                   | A1                      |
      | volg_nr                    |                       0 |
      | inschrijving_gemeente_code |                    0518 |
      | adres_functie              | W                       |
      | adreshouding_start_datum   | gisteren 5 jaar geleden |
