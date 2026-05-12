# language: nl
@mutatie-service
Functionaliteit: Aangifte van overlijden
 Dit betreft het doorgeven van een aangifte van overlijden.
 In de mutatie-service gebeurt dit met aangifte type 'AangifteVanOverlijden'

  Achtergrond:
    Gegeven de persoon 'Jan' is geregistreerd in de BRP

  Regel: Als een aangifte van overlijden is gedaan, dan heeft de gebeurtenis 'overleden' plaatsgevonden

    Scenario: Aangifte van overlijden
      Als de aangifte van overlijden van 'Jan' is verwerkt met de volgende gegevens
        | naam            | waarde     |
        | datumOverlijden | 2026-02-10 |
        | plaats          |       1911 |
        | landCode        |       6030 |
      Dan is een 'overleden' gebeurtenis gepubliceerd met de volgende data
      * het A-nummer van 'Jan'
      * de datum overlijden van de opgave van overlijden van 'Jan'

  Regel: Wanneer een aangifte van overlijden is verwerkt, is de wijziging opgeslagen in categorie Overlijden van de BRP-V

    Scenario: Aangifte van overlijden
      Als de aangifte van overlijden van 'Jan' is verwerkt met de volgende gegevens
        | naam            | waarde     |
        | datumOverlijden | 2026-02-10 |
        | plaats          |       1911 |
        | landCode        |       6030 |
      Dan is een 'lo3_pl_overlijden' rij toegevoegd
        | pl_id | volg_nr | datum overlijden (08.10) | plaats overlijden (08.20) | land overlijden (08.30) | ingangsdatum geldigheid (85.10) |
        | Jan   |       0 |                 20260210 |                      1911 |                    6030 |                        20260210 |

  Regel: Wanneer een aangifte van overlijden is verwerkt en opschorting bijhouding is nu leeg is, wordt Opschorting bijhouding opgeslagen in categorie Inschrijving van de BRP-V waarbij
    - reden opschorting bijhouding is overlijden
    - datum opschorting bijhouding is gelijk aan de datum overlijden
    - overige gegevens van de inschrijving blijven ongewijzigd

    Scenario: Aangifte van overlijden
      Als de aangifte van overlijden van 'Jan' is verwerkt met de volgende gegevens
        | naam            | waarde     |
        | datumOverlijden | 2026-02-10 |
        | plaats          |       1911 |
        | landCode        |       6030 |
      Dan heeft de 'lo3_pl' rij voor 'Jan' datum opschorting bijhouding (67.10) met waarde '20260210'
      En heeft de 'lo3_pl' rij voor 'Jan' reden opschorting bijhouding (67.20) met waarde 'O'

    Scenario: Aangifte van overlijden voor een persoon die eerder geëmigreerd is
      Gegeven 'Jan' is op 1-9-2025 geëmigreerd naar Duitsland
      Als de aangifte van overlijden van 'Jan' is verwerkt met de volgende gegevens
        | naam            | waarde     |
        | datumOverlijden | 2026-02-10 |
        | plaats          |       1911 |
        | landCode        |       6030 |
      Dan heeft de 'lo3_pl' rij voor 'Jan' opschorting bijhouding met datum '20260210' en reden 'E'
