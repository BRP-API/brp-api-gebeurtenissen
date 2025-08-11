# language: nl
Functionaliteit: Adres specificeren

  Scenario: specificeren van een standaard adres
    Gegeven adres 'A1'
    Dan is een rij met de volgende gegevens toegevoegd in tabel 'lo3_adres'
      | naam                       | waarde           |
      | gemeente_code              |             0518 |
      | verblijf_plaats_ident_code | 0518010051001502 |
      | nummer_aand_ident_code     | 0518200000617227 |
      | postcode                   |           1234AB |
      | huis_nr                    |              321 |
      | straat_naam                | Hoofdstraat      |

  Scenario: specificeren van een adres met behulp van alle velden die kan worden opgegeven
    Gegeven adres 'A2' heeft de volgende gegevens
      | naam                             | waarde           |
      | gemeentecode                     |             0599 |
      | adresseerbaarObjectIdentificatie | 0599010051001502 |
      | nummeraanduidingIdentificatie    | 0599200000617227 |
      | postcode                         |           1234AB |
      | huisnummer                       |              321 |
      | officieleStraatnaam              | Laan             |
      | korteStraatnaam                  | Ln               |
      | huisletter                       | A                |
      | huisnummertoevoeging             | III              |
      | aanduidingBijHuisnummer          | to               |
      | woonplaats                       | Den Haag         |
    Dan is een rij met de volgende gegevens toegevoegd in tabel 'lo3_adres'
      | naam                       | waarde           |
      | gemeente_code              |             0599 |
      | verblijf_plaats_ident_code | 0599010051001502 |
      | nummer_aand_ident_code     | 0599200000617227 |
      | postcode                   |           1234AB |
      | huis_nr                    |              321 |
      | straat_naam                | Ln               |
      | open_ruimte_naam           | Laan             |
      | huis_letter                | A                |
      | huis_nr_toevoeging         | III              |
      | huis_nr_aand               | to               |
      | woon_plaats_naam           | Den Haag         |
