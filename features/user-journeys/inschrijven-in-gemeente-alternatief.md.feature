# language: nl
Functionaliteit: Inschrijven in gemeente
  Deze feature beschrijft voor één type gebeurtenis: 'PersoonIngeschreven':
  - hoe de inschrijving van een persoon in de BRP database wordt opgeslagen
  - hoe van deze gegevens een gebeurtenis wordt gemaakt en opgeslagen in de gebeurtenis opslag (database of event store)
  - hoe deze gebeurtenis kan worden geraadpleegd door afnemers (2 scenario's)

  Toelichting gebruik als-stappen:

  De als-stap: 
  Als 'Jan' zich heeft ingeschreven op adres 'A1' op '2025-07-01' 
  is een command die door de mutatie API wordt verwerkt
  
  De als-stap: 
  Als de inschrijving van 'Jan' op adres 'A1' op '2025-07-01' is verwerkt 
  is een taak in het ETL-proces (waarbij we mutaties omzetten naar gebeurtenissen)

  De als-stap: 
  Als de afnemer de gebeurtenissen met type 'PersoonIngeschreven' over 'Jan' raadpleegt 
  is een query naar de Gebeurtenis API

  De als-stap: 
  Als de afnemer de gebeurtenissen met type 'PersoonIngeschreven' in gemeente 's-Gravenhage' vanaf datum '2025-07-01' raadpleegt 
  is een query naar de Gebeurtenis API

  Scenario: Inschrijving via de mutatie api levert gegevens op die in de BRP database worden opgeslagen
    Gegeven persoon 'Jan' heeft de volgende gegevens
      | burgerservicenummer | geslachtsnaam | geboortedatum | geboorteplaats | geboorteland |
      |           000000012 | Janssen       |    1980-01-01 | 's-Gravenhage  | Nederland    |
    En adres 'A1' heeft de volgende gegevens
      | gemeentecode | postcode |
      |         0518 |   2500AB |
    Als 'Jan' zich heeft ingeschreven op adres 'A1' op '2025-07-01'
    Dan heeft 'Jan' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum | geslachts_aand |
      | Jan   |         0 |       0 | P            |         000000012 | Janssen        |       19800101 | M              |
    En heeft 'Jan' de volgende rij in tabel 'lo3_pl_verblijfplaats'
      | pl_id | adres_id | volg_nr | adres_functie | inschrijving_gemeente_code | adreshouding_start_datum |
      | Jan   | A1       |       0 | W             |                       0518 |                 20250701 |

  Scenario: Verwerking van inschrijving in BRP database levert gebeurtenis op in gebeurtenis opslag
    Gegeven persoon 'Jan' heeft de volgende gegevens
      | burgerservicenummer | geslachtsnaam | geboortedatum | geboorteplaats | geboorteland |
      |           000000012 | Janssen       |    1980-01-01 | 's-Gravenhage  | Nederland    |
    En adres 'A1' heeft de volgende gegevens
      | gemeentecode | postcode |
      |         0518 |   2500AB |
    Als de inschrijving van 'Jan' op adres 'A1' op '2025-07-01' is verwerkt
    Dan bevat de gebeurtenis opslag een gebeurtenis met de volgende gegevens
      | id | type                | datum    | burgerservicenummer | adres_id | gemeente_code | adreshouding_start_datum |
      |  1 | PersoonIngeschreven | 20250701 |           000000012 | A1       |          0518 |                 20250701 |

  Scenario: Afnemer raadpleegt de Gebeurtenis API met type gebeurtenis over persoon
    Gegeven de gebeurtenis opslag bevat de volgende gebeurtenis
      | id | type                | datum    | burgerservicenummer | adres_id | gemeente_code | adreshouding_start_datum |
      |  1 | PersoonIngeschreven | 20250701 |           000000012 | A1       |          0518 |                 20250701 |
    Als de afnemer de gebeurtenissen met type 'PersoonIngeschreven' over 'Jan' raadpleegt
    Dan bevat de response een gebeurtenis met de volgende gegevens
      | id | type                | datum      | burgerservicenummer | gemeentecode | adres_id | adreshouding_start_datum |
      |  1 | PersoonIngeschreven | 20250701 |           000000012 |         0518 | A1       |                 20250701 |
      
  Scenario: Afnemer raadpleegt de Gebeurtenis API met type gebeurtenis per gemeente vanaf datum
    Gegeven de gebeurtenis opslag bevat de volgende gebeurtenis
      | id | type                | datum    | burgerservicenummer | adres_id | gemeente_code | adreshouding_start_datum |
      |  1 | PersoonIngeschreven | 20250701 |           000000012 | A1       |          0518 |                 20250701 |
    Als de afnemer de gebeurtenissen met type 'PersoonIngeschreven' in gemeente 's-Gravenhage' vanaf datum '2025-07-01' raadpleegt
    Dan bevat de response een gebeurtenis met de volgende gegevens
      | id | type                | datum      | burgerservicenummer | gemeentecode | adres_id | adreshouding_start_datum |
      |  1 | PersoonIngeschreven | 20250701 |           000000012 |         0518 | A1       |                 20250701 |
