# language: nl
Functionaliteit: Geboorteaangifte

  Achtergrond:
    Gegeven afnemers '000008 en 000009' willen worden genotificeerd over 'GeboorteAangegeven' gebeurtenissen
    En adres 'A1' heeft de volgende gegevens
      | gemeentecode | postcode |
      |         0518 |   2500AB |
    En persoon 'Saskia' heeft de volgende gegevens
      | geslachtsnaam | voornamen | geboortedatum | geslacht |
      | Janssen       | Saskia    |    1980-04-02 | V        |
    En 'Saskia' verblijft vanaf '2023-10-01' op adres 'A1'
    En 'Saskia' is ingeschreven in de BRP
    En persoon 'Piet' heeft de volgende gegevens
      | geslachtsnaam | voornamen | geboortedatum           | geslacht |
      | Janssen       | Piet      | vandaag 2 dagen geleden | M        |
    En 'Piet' verblijft vanaf 'vandaag 2 dagen geleden' op adres 'A1'
    En 'Piet' heeft 'Saskia' als ouder
    Als aangifte van de geboorte van 'Piet' wordt gedaan

  Regel: Een burgerservicenummer is toegekend aan het kind

    Scenario: geboorteaangifte
      Dan is een burgerservicenummer toegekend aan 'Piet'

  Regel: Mutaties zijn doorgevoerd in de lo3_pl, lo3_pl_persoon en de lo3_pl_verblijfplaats tabellen voor het kind

    Scenario: geboorteaangifte
      Dan heeft 'Piet' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | Piet  |          0 |
      En heeft 'Piet' de volgende rij in tabel 'lo3_pl_persoon'
        | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | voor_naam | geboorte_datum          | geslachts_aand |
        | Piet  |         0 |       0 | P            | Piet              | Janssen        | Piet      | vandaag 2 dagen geleden | M              |
        | Piet  |         0 |       0 |            1 | Saskia            | Janssen        | Saskia    |                19800402 | V              |
      En heeft 'Piet' de volgende rij in tabel 'lo3_pl_verblijfplaats'
        | pl_id | adres_id | volg_nr | adres_functie | inschrijving_gemeente_code | adreshouding_start_datum |
        | Piet  | A1       |       0 | W             |                       0518 | vandaag 2 dagen geleden  |

  Regel: Mutaties zijn doorgevoerd in de lo3_pl_persoon tabel voor de ouder

    Scenario: geboorteaangifte
      En heeft 'Saskia' de volgende rij in tabel 'lo3_pl_persoon'
        | pl_id  | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | voor_naam | geboorte_datum          | geslachts_aand | familie_betrek_start_datum |
        | Saskia |         0 |       0 | K            | Piet              | Janssen        | Piet      | vandaag 2 dagen geleden | M              | vandaag 2 dagen geleden    |

  Regel: Een 'GeboorteAangegeven' gebeurtenis is gepubliceerd voor het kind

    Scenario: geboorteaangifte
      Dan is een 'GeboorteAangegeven' gebeurtenis voor 'Piet' gepubliceerd

  Regel: Abonnees van 'GeboorteAangegeven' gebeurtenissen zijn genotificeerd

    Scenario: geboorteaangifte
      Dan zijn afnemers '000008 en 000009' genotificeerd over de 'GeboorteAangegeven' gebeurtenis van 'Piet'
