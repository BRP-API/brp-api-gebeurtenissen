# language: nl

@integratie
Functionaliteit: Database dan stap definities gebeurtenissen

  Scenario: Gegeven het adres '[adres aanduiding]'
    Gegeven het adres 'A1'
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft tabel 'lo3_adres' de volgende rij
      | adres_id | gemeente_code | verblijf_plaats_ident_code |
      | A1       | A1            | A1                         |

  Scenario: Gegeven de persoon '[persoon aanduiding]'
    Gegeven de persoon 'P1'
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft tabel 'lo3_pl' de volgende rij
      | pl_id | geheim_ind |
      | P1    |          0 |
    En heeft tabel 'lo3_pl_persoon' de volgende rij
      | pl_id | persoon_type | stapel_nr | volg_nr | a_nr | burger_service_nr |
      | P1    | P            |         0 |       0 | P1   | P1                |

  Scenario: Gegeven verblijft vanaf '[datum]' op het adres '[adres aanduiding]'
    Gegeven het adres 'A1'
    En de persoon 'P1'
    * verblijft vanaf '1-9-2025' op het adres 'A1'
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft tabel 'lo3_pl_verblijfplaats' de volgende rij
      | pl_id | adres_id | volg_nr | vanaf_datum | verblijf_status |
      | P1    | A1       | 0      | 2025-09-01  | V               |