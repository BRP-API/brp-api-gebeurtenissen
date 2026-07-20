# language: nl
@mutatie-service
Functionaliteit: Wijzigen van het adres naar een adres buiten Nederland
  Dit betreft het doorgeven van een aangifte van vertrek naar het buitenland.
  In de mutatie-service gebeurt dit met aangifte type 'AangifteVanVertrekNaarBuitenland'

  Achtergrond:
    Gegeven het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    * in gemeente 'Hengelo'
    * met adresseerbaar object identificatie '0164010000047847'
    En de persoon 'Jan' is geregistreerd in de BRP
    * verblijft vanaf '1-9-2025' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'

  Regel: Als een aangifte vertrek naar buitenland is gedaan, dan heeft de gebeurtenis 'verhuisd.naar-buitenland' plaatsgevonden

    Scenario: Aangifte van vertrek naar buitenland geeft een gebeurtenis
      Gegeven de abonnee 'jz' van afnemer 'Gemeente Hengelo' heeft een abonnement op 'nl.brp.verhuisd.naar-buitenland' gebeurtenissen van 'Jan'
      En de aangifte van vertrek naar buitenland van 'Jan' is verwerkt met de volgende gegevens
        | naam           | waarde                    |
        | datumEmigratie |                2026-02-10 |
        | regel1         | Paul-Henri Spaak Building |
        | regel2         | Rue Wiertz 60             |
        | regel3         | B-1047 Bruxelles          |
        | landCode       |                      5010 |
      Als gebeurtenissen worden gevraagd door abonnee 'jz' van afnemer 'Gemeente Hengelo'
      Dan wordt een gebeurtenis 'nl.brp.verhuisd.naar-buitenland' met de volgende gegevens geleverd
        | naam                    | waarde     |
        | burgerservicenummer     | Jan        |
        | verblijfplaats.datumVan | 2026-02-10 |

  Regel: Wanneer een aangifte van vertrek naar buitenland is verwerkt, worden de gewijzigde gegevens geleverd bij opvragen van betreffende de persoonsgegevens
    - gemeente van inschrijving en datum inschrijving in gemeente worden overgenomen van het vorige adres
    - de datum vertrek en de gegevens van het buitenlandse adres worden overgenomen van de aangifte
    - datum ingang geldigheid is gelijk aan de datum vertrek
    - omschrijving aangifte adreshouding is ingeschrevene (I)
    - overige gegevens in de nieuwe verblijfplaats zijn leeg (zoals adres, adreshouding en functie adres)
    - reden opschorting bijhouding is emigratie
    - datum opschorting bijhouding is gelijk aan de datum emigratie van de aangifte
    - overige gegevens van de inschrijving blijven ongewijzigd (zoals bijv. indicatie geheim en datum eerste inschrijving in de GBA/BRP)

    Scenario: Aangifte van vertrek naar buitenland wijzigt verblijfplaats en vult opschorting bijhouding
      Gegeven de aangifte van vertrek naar buitenland van 'Jan' is verwerkt met de volgende gegevens
        | naam           | waarde                    |
        | datumEmigratie |                2026-02-10 |
        | regel1         | Paul-Henri Spaak Building |
        | regel2         | Rue Wiertz 60             |
        | regel3         | B-1047 Bruxelles          |
        | landCode       |                      5010 |
      Als 'verblijfplaats, gemeenteVanInschrijving en datumInschrijvingInGemeente' wordt gevraagd van 'Jan'
      Dan heeft 'Jan' de volgende 'verblijfplaats' gegevens
        | naam                              | waarde                    |
        | type                              | VerblijfplaatsBuitenland  |
        | datumVan.type                     | Datum                     |
        | datumVan.datum                    |                2026-02-10 |
        | datumVan.langFormaat              |          10 februari 2026 |
        | verblijfadres.land.code           |                      5010 |
        | verblijfadres.land.omschrijving   | België                    |
        | verblijfadres.regel1              | Paul-Henri Spaak Building |
        | verblijfadres.regel2              | Rue Wiertz 60             |
        | verblijfadres.regel3              | B-1047 Bruxelles          |
        | datumIngangGeldigheid.type        | Datum                     |
        | datumIngangGeldigheid.datum       |                2026-02-10 |
        | datumIngangGeldigheid.langFormaat |          10 februari 2026 |
      En heeft 'Jan' de volgende 'gemeenteVanInschrijving' gegevens
        | naam         | waarde      |
        | code         |        0164 |
        | omschrijving | Hengelo (O) |
      En heeft 'Jan' de volgende 'datumInschrijvingInGemeente' gegevens
        | naam        | waarde           |
        | type        | Datum            |
        | datum       |       2025-09-01 |
        | langFormaat | 1 september 2025 |
      En heeft 'Jan' de volgende 'opschortingBijhouding' gegevens
        | naam               | waarde           |
        | reden.code         | E                |
        | reden.omschrijving | emigratie        |
        | datum.type         | Datum            |
        | datum.datum        |       2026-02-10 |
        | datum.langFormaat  | 10 februari 2026 |

    Scenario: Aangifte van vertrek naar buitenland voegt buitenlandse adres toe aan verblijfplaatshistorie
      Gegeven de aangifte van vertrek naar buitenland van 'Jan' is verwerkt met de volgende gegevens
        | naam           | waarde                    |
        | datumEmigratie |                2026-02-10 |
        | regel1         | Paul-Henri Spaak Building |
        | regel2         | Rue Wiertz 60             |
        | regel3         | B-1047 Bruxelles          |
        | landCode       |                      5010 |
      Als verblijfplaatshistorie wordt gevraagd van 'Jan' over de periode '01-08-2025' tot '01-03-2026'
      Dan heeft de response een verblijfplaats voorkomen met de volgende gegevens
        | naam                                 | waarde                    |
        | type                                 | VerblijfplaatsBuitenland  |
        | datumVan.type                        | Datum                     |
        | datumVan.datum                       |                2026-02-10 |
        | datumVan.langFormaat                 |          10 februari 2026 |
        | gemeenteVanInschrijving.code         |                      0164 |
        | gemeenteVanInschrijving.omschrijving | Hengelo                   |
        | verblijfadres.land.code              |                      5010 |
        | verblijfadres.land.omschrijving      | België                    |
        | verblijfadres.regel1                 | Paul-Henri Spaak Building |
        | verblijfadres.regel2                 | Rue Wiertz 60             |
        | verblijfadres.regel3                 | B-1047 Bruxelles          |
        | adressering.land.code                |                      5010 |
        | adressering.land.omschrijving        | België                    |
        | adressering.regel1                   | Paul-Henri Spaak Building |
        | adressering.regel2                   | Rue Wiertz 60             |
        | adressering.regel3                   | B-1047 Bruxelles          |
      En heeft de response een verblijfplaats voorkomen met de volgende gegevens
        | naam                                 | waarde           |
        | type                                 | Adres            |
        | datumVan.type                        | Datum            |
        | datumVan.datum                       |       2025-09-01 |
        | datumVan.langFormaat                 | 1 september 2025 |
        | datumTot.type                        | Datum            |
        | datumTot.datum                       |       2026-02-10 |
        | datumTot.langFormaat                 | 10 februari 2026 |
        | functieAdres.code                    | W                |
        | functieAdres.omschrijving            | woonadres        |
        | adresseerbaarObjectIdentificatie     | 0164010000047847 |
        | gemeenteVanInschrijving.code         |             0164 |
        | gemeenteVanInschrijving.omschrijving | Hengelo          |
      En heeft de response de volgende gegevens
        | naam                                     | waarde           |
        | opschortingBijhouding.reden.code         | E                |
        | opschortingBijhouding.reden.omschrijving | emigratie        |
        | opschortingBijhouding.datum.type         | Datum            |
        | opschortingBijhouding.datum.datum        |       2026-02-10 |
        | opschortingBijhouding.datum.langFormaat  | 10 februari 2026 |
