# language: nl
@mutatie-service
Functionaliteit: Wijzigen van het adres binnen Nederland
  Dit betreft het doorgeven van een aangifte van adreswijziging binnen een Nederlandse gemeente of naar een andere Nederlandse gemeente

  Achtergrond:
    Gegeven het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    * in gemeente 'Hengelo'
    * met adresseerbaar object identificatie '0164010000047847'
    * met straat 'Burg van der Dussenplein'
    * met huisnummer '1'
    * met postcode '7551EB'
    En het adres 'Stadserf_1_Roosendaal'
    * in gemeente 'Roosendaal'
    * met adresseerbaar object identificatie '1674010000008508'
    * met straat 'Stadserf'
    * met huisnummer '1'
    * met postcode '4701NK'
    En de persoon 'Jan' is geregistreerd in de BRP
    * verblijft sinds 1-9-2025 op adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'

  Regel: Als een aangifte adreswijziging is gedaan naar een andere Nederlandse gemeente dan waar de persoon nu verblijft, dan heeft de gebeurtenis 'verhuisd.intergemeentelijk' plaatsgevonden

    Scenario: Aangifte van adreswijziging naar een briefadres in andere gemeente in Nederland
      Gegeven de abonnee 'jz' van afnemer 'Gemeente Hengelo' heeft een abonnement op nl.brp.verhuisd.intergemeentelijk gebeurtenissen van 'Jan'
      En de aangifte van adreswijziging van 'Jan' is verwerkt
      * heeft vanaf '10-2-2026' het briefadres 'Stadserf_1_Roosendaal'
      Als gebeurtenissen worden gevraagd door abonnee 'jz' van afnemer 'Gemeente Hengelo'
      Dan wordt een gebeurtenis 'nl.brp.intergemeentelijk' met de volgende gegevens geleverd
        | naam                    | waarde     |
        | burgerservicenummer     | Jan        |
        | verblijfplaats.datumVan | 2026-02-10 |

  Regel: Wanneer een aangifte van adreswijziging is verwerkt, worden de gewijzigde gegevens geleverd bij opvragen van betreffende de persoonsgegevens

    Scenario: Aangifte van adreswijziging naar een andere gemeente in Nederland wijzigt de verblijfplaatsgegevens van de persoon
      Gegeven de persoon 'Jan'
      * verblijft vanaf '14-4-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
      En de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf '10-2-2026' op het adres 'Stadserf_1_Roosendaal'
      Als 'verblijfplaats, gemeenteVanInschrijving en datumInschrijvingInGemeente' wordt gevraagd van 'Jan'
      Dan heeft 'Jan' de volgende 'verblijfplaats' gegevens
        | naam                               | waarde           |
        | type                               | Adres            |
        | datumVan.type                      | Datum            |
        | datumVan.datum                     |       2026-02-10 |
        | datumVan.langFormaat               | 10 februari 2026 |
        | adresseerbaar object identificatie | 1674010000008508 |
        | functieAdres.code                  | W                |
        | functieAdres.omschrijving          | woonadres        |
        | verblijfadres.korteStraatnaam      | Stadserf         |
        | verblijfadres.huisnummer           |                1 |
        | verblijfadres.postcode             |           4701NK |
        | datumIngangGeldigheid.type         | Datum            |
        | datumIngangGeldigheid.datum        |       2026-02-10 |
        | datumIngangGeldigheid.langFormaat  | 10 februari 2026 |
      En heeft 'Jan' de volgende 'gemeenteVanInschrijving' gegevens
        | naam         | waarde     |
        | code         |       1674 |
        | omschrijving | Roosendaal |
      En heeft 'Jan' de volgende 'datumInschrijvingInGemeente' gegevens
        | naam        | waarde           |
        | type        | Datum            |
        | datum       |       2026-02-10 |
        | langFormaat | 10 februari 2026 |

    Scenario: Aangifte van adreswijziging naar een andere gemeente in Nederland voegt de nieuwe verblijfplaats toe aan de verblijfplaatshistorie
      Gegeven de persoon 'Jan'
      * verblijft vanaf '14-4-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
      En de aangifte van adreswijziging van 'Jan' is verwerkt
      * heeft vanaf '10-2-2026' het briefadres 'Stadserf_1_Roosendaal'
      Als verblijfplaatshistorie wordt gevraagd van 'Jan' over de periode '01-08-2025' tot '01-03-2026'
      Dan heeft de response een verblijfplaats voorkomen met de volgende gegevens
        | naam                                 | waarde              |
        | type                                 | Adres               |
        | datumVan.type                        | Datum               |
        | datumVan.datum                       |          2026-02-10 |
        | datumVan.langFormaat                 |    10 februari 2026 |
        | gemeenteVanInschrijving.code         |                1674 |
        | gemeenteVanInschrijving.omschrijving | Roosendaal          |
        | functieAdres.code                    | B                   |
        | functieAdres.omschrijving            | briefadres          |
        | adresseerbaar object identificatie   |    1674010000008508 |
        | verblijfadres.korteStraatnaam        | Stadserf            |
        | verblijfadres.huisnummer             |                   1 |
        | verblijfadres.postcode               |              4701NK |
        | adressering.regel1                   | Stadserf 1          |
        | adressering.regel2                   | 4701 NK  ROOSENDAAL |
      En heeft de response een verblijfplaats voorkomen met de volgende gegevens
        | naam                                 | waarde                     |
        | type                                 | Adres                      |
        | datumVan.type                        | Datum                      |
        | datumVan.datum                       |                 2025-09-01 |
        | datumVan.langFormaat                 |           1 september 2025 |
        | datumTot.type                        | Datum                      |
        | datumTot.datum                       |                 2026-02-10 |
        | datumTot.langFormaat                 |           10 februari 2026 |
        | gemeenteVanInschrijving.code         |                       0164 |
        | gemeenteVanInschrijving.omschrijving | Hengelo                    |
        | functieAdres.code                    | W                          |
        | functieAdres.omschrijving            | woonadres                  |
        | adresseerbaarObjectIdentificatie     |           0164010000047847 |
        | verblijfadres.korteStraatnaam        | Burg van der Dussenplein   |
        | verblijfadres.huisnummer             |                          1 |
        | verblijfadres.postcode               |                     7551EB |
        | adressering.regel1                   | Burg van der Dussenplein 1 |
        | adressering.regel2                   |           7551 EB  HENGELO |
