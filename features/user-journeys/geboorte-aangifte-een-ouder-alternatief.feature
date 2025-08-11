# language: nl
Functionaliteit: Geboorteaangifte (alternatief voorstel)

  Achtergrond:
    Gegeven afnemers '000008 en 000009' willen worden genotificeerd over 'GeboorteAangegeven' gebeurtenissen
    En adres 'A1' heeft de volgende gegevens
      | gemeentecode | postcode |
      |         0518 |   2500AB |
    En persoon 'Saskia' heeft de volgende gegevens
      | burgerservicenummer | geslachtsnaam | voornamen | geboortedatum | geslacht |
      |           000000012 | Janssen       | Saskia    |    1980-04-02 | V        |
    En 'Saskia' verblijft vanaf '2023-10-01' op adres 'A1'
    En 'Saskia' is ingeschreven in de BRP

  Regel: Mutaties zijn doorgevoerd in de lo3_pl, lo3_pl_persoon en de lo3_pl_verblijfplaats tabellen voor het kind

    Scenario: geboorteakte in Gegeven stappen gedefinieerd
      Gegeven de geboorteakte van 'Piet' heeft de volgende gegevens
        | burgerservicenummer | geslachtsnaam | voornamen | geboortedatum           | geslacht |
        |           000000024 | Janssen       | Piet      | vandaag 2 dagen geleden | M        |
      En en de geboorteakte van 'Piet' heeft 'Saskia' als ouder
      Als de geboortekte van 'Piet' is verwerkt
      Dan heeft 'Piet' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | Piet  |          0 |
      En heeft 'Piet' de volgende rij in tabel 'lo3_pl_persoon'
        | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | voor_naam | geboorte_datum          | geslachts_aand | datum ingang familierechtelijke betrekking |
        | Piet  |         0 |       0 | P            |         000000024 | Janssen        | Piet      | vandaag 2 dagen geleden | M              |                                            |
        | Piet  |         0 |       0 |            1 |         000000012 | Janssen        | Saskia    |                19800402 | V              | vandaag 2 dagen geleden                    |
      En heeft 'Piet' de volgende rij in tabel 'lo3_pl_verblijfplaats'
        | pl_id | adres_id | volg_nr | adres_functie | inschrijving_gemeente_code | adreshouding_start_datum |
        | Piet  | A1       |       0 | W             |                       0518 | vandaag 2 dagen geleden  |

    Scenario: geboorteakte in Als stappen gedefinieerd
      Als de geboorteakte van 'Piet' is verwerkt met de volgende gegevens
        | burgerservicenummer | geslachtsnaam | voornamen | geboortedatum           | geslacht |
        |           000000024 | Janssen       | Piet      | vandaag 2 dagen geleden | M        |
      En en de geboorteakte van 'Piet' heeft 'Saskia' als ouder
      Dan heeft 'Piet' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | Piet  |          0 |
      En heeft 'Piet' de volgende rij in tabel 'lo3_pl_persoon'
        | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | voor_naam | geboorte_datum          | geslachts_aand | datum ingang familierechtelijke betrekking |
        | Piet  |         0 |       0 | P            |         000000024 | Janssen        | Piet      | vandaag 2 dagen geleden | M              |                                            |
        | Piet  |         0 |       0 |            1 |         000000012 | Janssen        | Saskia    |                19800402 | V              | vandaag 2 dagen geleden                    |
      En heeft 'Piet' de volgende rij in tabel 'lo3_pl_verblijfplaats'
        | pl_id | adres_id | volg_nr | adres_functie | inschrijving_gemeente_code | adreshouding_start_datum |
        | Piet  | A1       |       0 | W             |                       0518 | vandaag 2 dagen geleden  |
  