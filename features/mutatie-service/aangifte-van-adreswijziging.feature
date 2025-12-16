# language: nl
@mutatie-service
Functionaliteit: Wijzigen van het adres binnen Nederland
 Dit betreft het doorgeven van een aangifte van adreswijziging binnen een Nederlandse gemeente of naar een andere Nederlandse gemeente

  Achtergrond:
    Gegeven het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    * in gemeente 'Hengelo'
    * met adresseerbaar object identificatie '0164010000047847'
    En het adres 'Stadserf_1_Roosendaal'
    * in gemeente 'Roosendaal'
    * met adresseerbaar object identificatie '1674010000008508'

  Scenario: Aangifte van adreswijziging naar een andere gemeente in Nederland
    Gegeven de persoon 'Jan'
    * verblijft vanaf '14-4-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    Als de aangifte van adreswijziging van 'Jan' is verwerkt
    * verblijft vanaf '1-9-2025' op het adres 'Stadserf_1_Roosendaal'
    Dan is het 'volg_nr' van de 'lo3_pl_verblijfplaats' rijen van 'Jan' opgehoogd met 1
    En is een 'lo3_pl_verblijfplaats' rij toegevoegd
      | pl_id | adres_id              | volg_nr | gemeente van inschrijving (09.10) | datum inschrijving in de gemeente (09.20) | functie adres (10.10) | datum aanvang adreshouding (10.30) | aangifte adreshouding (72.10) | ingangsdatum geldigheid (85.10) |
      | Jan   | Stadserf_1_Roosendaal |       0 |                              1674 |                                  20250901 | W                     |                           20250901 | I                             |                        20250901 |
