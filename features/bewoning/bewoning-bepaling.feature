# language: nl
Functionaliteit: Bewoning bepaling na verwerken van relevante gebeurtenissen

  Achtergrond:
    Gegeven het adres 'Sesamstraat' heeft de volgende gegevens
      | adresseerbaarObjectIdentificatie |
      |                 0999010051001502 |
    En de persoon 'Bert' heeft de volgende gegevens
      | burgerservicenummer | geslachtsnaam | voornamen | geboortedatum |
      |           345678901 | Jansen        | Bert      |    1979-11-18 |
    En de persoon 'Ernie' heeft de volgende gegevens
      | burgerservicenummer | geslachtsnaam | voornamen | geboortedatum |
      |           456789012 | Pietersen     | Ernie     |    2010-09-02 |

  Regel: Een persoon is in (een deel van) een gevraagde periode bewoner van een adresseerbaar object als hij binnen (het deel van) de gevraagde periode op het adresseerbaar object verblijft/heeft verbleven

    Abstract Scenario: Een 'EersteInschrijvingBRP' gebeurtenis is verwerkt door het bewoning systeem
      Gegeven de 'EersteInschrijvingBRP' gebeurtenis heeft de volgende 'data' gegevens
        | burgerservicenummer | gemeenteVanInschrijving.code | adres.adresseerbaarObjectIdentificatie | adres.datumAanvangAdreshouding |
        |           345678901 |                         0999 |                       0999010051001502 |                     2025-04-03 |
      En de gebeurtenis is door het bewoning systeem verwerkt
      Als bewoning wordt gevraagd van een adres met de adresseerbaar object identificatie van 'Sesamstraat' en <periode/peildatum parameter>
      Dan wordt voor adres 'Sesamstraat' de volgende bewoningen geleverd
        | periode                | bewoners |
        | 2025-04-03 tot vandaag | Bert     |

      Voorbeelden:
        | periode/peildatum parameter        | periode                   |
        | periode '2025-04-01' tot 'vandaag' |    2025-04-03 tot vandaag |
        | peildatum '2025-05-01'             | 2025-05-01 tot 2025-05-02 |

  Regel: Een gevraagde periode bevat meerdere bewoningen als de samenstelling van bewoners binnen de gevraagde periode verandert

    Scenario: Meerdere 'EersteInschrijvingBRP' gebeurtenissen die relevant zijn voor hetzelfde adres zijn verwerkt door het bewoning systeem
      Gegeven de 'EersteInschrijvingBRP' gebeurtenis heeft de volgende 'data' gegevens
        | burgerservicenummer | gemeenteVanInschrijving.code | adres.adresseerbaarObjectIdentificatie | adres.datumAanvangAdreshouding |
        |           345678901 |                         0999 |                       0999010051001502 |                     2025-04-03 |
      En de 'EersteInschrijvingBRP' gebeurtenis heeft de volgende 'data' gegevens
        | burgerservicenummer | gemeenteVanInschrijving.code | adres.adresseerbaarObjectIdentificatie | adres.datumAanvangAdreshouding |
        |           456789012 |                         0999 |                       0999010051001502 |                     2025-05-01 |
      En de gebeurtenissen zijn door het bewoning systeem verwerkt
      Als bewoning wordt gevraagd met de adresseerbaar object identificatie van adres 'Sesamstraat' en periode '2025-04-01' tot 'vandaag'
      Dan wordt voor adres 'Sesamstraat' de volgende bewoningen geleverd
        | periode                   | bewoners   |
        | 2025-04-03 tot 2025-04-30 | Bert       |
        |    2025-05-01 tot vandaag | Bert,Ernie |

  Regel: Voor elke (mogelijke) bewoner wordt zijn volledige naam en geboortedatum meegeleverd

    Scenario: Een 'EersteInschrijvingBRP' gebeurtenis is verwerkt door het bewoning systeem
      Gegeven de 'EersteInschrijvingBRP' gebeurtenis heeft de volgende 'data' gegevens
        | burgerservicenummer | gemeenteVanInschrijving.code | adres.adresseerbaarObjectIdentificatie | adres.datumAanvangAdreshouding |
        |           345678901 |                         0999 |                       0999010051001502 |                     2025-04-03 |
      En de gebeurtenis is door het bewoning systeem verwerkt
      Als bewoning wordt gevraagd van een adres met de adresseerbaar object identificatie van 'Sesamstraat' en periode '2025-04-01' tot 'vandaag'
      Dan wordt voor adres 'Sesamstraat' de volgende bewoningen geleverd
        | periode                | bewoners |
        | 2025-04-03 tot vandaag | Bert     |
      En wordt voor 'Bert' de volgende gegevens geleverd
        | burgerservicenummer | naam.volledigeNaam | geboorte.datum.type | geboorte.datum.datum | geboorte.datum.langFormaat |
        |           345678901 | Bert Jansen        | Datum               |           1979-11-18 |           18 november 1979 |
