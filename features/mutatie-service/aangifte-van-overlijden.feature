# language: nl
@mutatie-service
Functionaliteit: Aangifte van overlijden
 Dit betreft het doorgeven van een aangifte van overlijden.
 In de mutatie-service gebeurt dit met aangifte type 'AangifteVanOverlijden'

  Achtergrond:
    Gegeven de persoon 'Jan' is geregistreerd in de BRP

  Regel: Als een aangifte van overlijden is gedaan, dan heeft de gebeurtenis 'overleden' plaatsgevonden

    Scenario: Aangifte van overlijden
      Gegeven de abonnee 'jz' van afnemer 'Gemeente Hengelo' heeft een abonnement op nl.brp.overleden gebeurtenissen van 'Jan'
      En de aangifte van overlijden van 'Jan' is verwerkt met de volgende gegevens
        | naam            | waarde     |
        | datumOverlijden | 2026-02-10 |
        | plaats          |       1911 |
        | landCode        |       6030 |
      Als gebeurtenissen worden gevraagd door abonnee 'jz' van afnemer 'Gemeente Hengelo'
      Dan wordt een gebeurtenis 'nl.brp.overleden' met de volgende gegevens geleverd
        | naam                | waarde     |
        | burgerservicenummer | Jan        |
        | overlijden.datum    | 2026-02-10 |

  Regel: Wanneer een aangifte van overlijden is verwerkt, worden de gewijzigde gegevens geleverd bij opvragen van betreffende de persoonsgegevens
    - de datum, plaats en land worden overgenomen van de aangifte
    - reden opschorting bijhouding is overlijden
    - datum opschorting bijhouding is gelijk aan de datum overlijden van de aangifte

    Scenario: Aangifte van overlijden
      Gegeven de aangifte van overlijden van 'Jan' is verwerkt met de volgende gegevens
        | naam            | waarde     |
        | datumOverlijden | 2026-02-10 |
        | plaats          |       1911 |
        | landCode        |       6030 |
      Als 'overlijden' wordt gevraagd van 'Jan'
      Dan heeft 'Jan' de volgende 'overlijden' gegevens
        | naam                | waarde           |
        | datum.type          | Datum            |
        | datum.datum         |       2026-02-10 |
        | datum.langFormaat   | 10 februari 2026 |
        | plaats.code         |             1911 |
        | plaats.omschrijving | Hollands Kroon   |
        | land.code           |             6030 |
        | land.omschrijving   | Nederland        |
      En heeft 'Jan' de volgende 'opschortingBijhouding' gegevens
        | naam               | waarde           |
        | reden.code         | O                |
        | reden.omschrijving | Overlijden       |
        | datum.type         | Datum            |
        | datum.datum        |       2026-02-10 |
        | datum.langFormaat  | 10 februari 2026 |

  Regel: Wanneer een aangifte van overlijden is verwerkt en opschorting bijhouding was al gevuld, dan is Opschorting bijhouding niet gewijzigd

    Scenario: Aangifte van overlijden voor een persoon die eerder geëmigreerd is
      Gegeven 'Jan' is op 1-9-2025 geëmigreerd naar Duitsland
      En de aangifte van overlijden van 'Jan' is verwerkt met de volgende gegevens
        | naam            | waarde     |
        | datumOverlijden | 2026-02-10 |
        | plaats          |       1911 |
        | landCode        |       6030 |
      Als 'overlijden' wordt gevraagd van 'Jan'
      Dan heeft 'Jan' de volgende 'overlijden' gegevens
        | naam                | waarde           |
        | datum.type          | Datum            |
        | datum.datum         |       2026-02-10 |
        | datum.langFormaat   | 10 februari 2026 |
        | plaats.code         |             1911 |
        | plaats.omschrijving | Hollands Kroon   |
        | land.code           |             6030 |
        | land.omschrijving   | Nederland        |
      En heeft 'Jan' de volgende 'opschortingBijhouding' gegevens
        | naam               | waarde           |
        | reden.code         | E                |
        | reden.omschrijving | Emigratie        |
        | datum.type         | Datum            |
        | datum.datum        |       2025-09-01 |
        | datum.langFormaat  | 1 september 2025 |
