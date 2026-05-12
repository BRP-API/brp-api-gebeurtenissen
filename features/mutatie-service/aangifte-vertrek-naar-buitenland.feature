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
    * verblijft sinds 1-9-2025 op adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'

  Regel: Als een aangifte vertrek naar buitenland is gedaan, dan heeft de gebeurtenis 'verhuisd.naar-buitenland' plaatsgevonden

    Scenario: Aangifte van vertrek naar buitenland
      Als de aangifte van vertrek naar buitenland van 'Jan' is verwerkt met de volgende gegevens
        | naam           | waarde                    |
        | datumEmigratie |                2026-02-10 |
        | regel1         | Paul-Henri Spaak Building |
        | regel2         | Rue Wiertz 60             |
        | regel3         | B-1047 Bruxelles          |
        | landCode       |                      5010 |
      Dan is een 'verhuisd.naar-buitenland' gebeurtenis gepubliceerd met de volgende data
      * het A-nummer van 'Jan'
      * de datum emigratie van de opgave van vertrek van 'Jan'

  Regel: Wanneer een aangifte van adreswijziging is verwerkt, is de wijziging opgeslagen in categorie Verblijfplaats van de BRP-V waarbij
    - gemeente van inschrijving wordt overgenomen van het vorige adres
    - datum inschrijving in gemeente wordt overgenomen van het vorige adres

    Scenario: Aangifte van adreswijziging naar een andere gemeente in Nederland
      Als de aangifte van vertrek naar buitenland van 'Jan' is verwerkt met de volgende gegevens
        | naam           | waarde                    |
        | datumEmigratie |                2026-02-10 |
        | regel1         | Paul-Henri Spaak Building |
        | regel2         | Rue Wiertz 60             |
        | regel3         | B-1047 Bruxelles          |
        | landCode       |                      5010 |
      Dan is het 'volg_nr' van de 'lo3_pl_verblijfplaats' rijen van 'Jan' opgehoogd met 1
      En is een 'lo3_pl_verblijfplaats' rij toegevoegd
        | pl_id | volg_nr | gemeente van inschrijving (09.10) | datum inschrijving in de gemeente (09.20) | land (13.10) | datum aanvang adres buitenland (13.20) | regel 1 adres buitenland (13.30) | regel 2 adres buitenland (13.40) | regel 3 adres buitenland (13.50) | aangifte adreshouding (72.10) | ingangsdatum geldigheid (85.10) |
        | Jan   |       0 |                              0164 |                                  20250901 |         5010 |                               20260210 | Paul-Henri Spaak Building        | Rue Wiertz 60                    | B-1047 Bruxelles                 | I                             |                        20250901 |

  Regel: Wanneer een aangifte van adreswijziging is verwerkt, is Opschorting bijhouding opgeslagen in categorie Inschrijving van de BRP-V waarbij
    - reden opschorting bijhouding is emigratie
    - datum opschorting bijhouding is gelijk aan de datum emigratie
    - overige gegevens van de inschrijving blijven ongewijzigd

    Scenario: Aangifte van adreswijziging naar een andere gemeente in Nederland
      Als de aangifte van vertrek naar buitenland van 'Jan' is verwerkt met de volgende gegevens
        | naam           | waarde                    |
        | datumEmigratie |                2026-02-10 |
        | regel1         | Paul-Henri Spaak Building |
        | regel2         | Rue Wiertz 60             |
        | regel3         | B-1047 Bruxelles          |
        | landCode       |                      5010 |
      Dan is het 'volg_nr' van de 'lo3_pl_verblijfplaats' rijen van 'Jan' opgehoogd met 1
      En is een 'lo3_pl_verblijfplaats' rij toegevoegd
        | pl_id | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
        | Jan   |                             20260210 | E                                    |
