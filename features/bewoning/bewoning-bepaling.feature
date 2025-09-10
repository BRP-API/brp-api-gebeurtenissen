# language: nl
Functionaliteit: Bewoning bepaling na verwerken van relevante gebeurtenissen

  Scenario: Een 'EersteInschrijvingBRP' gebeurtenis is verwerkt door het bewoning systeem
    Gegeven gemeente 'G1'
    En adres 'A1234' in gemeente 'G1'
    En de 'EersteInschrijvingBRP' gebeurtenis heeft de volgende 'data' gegevens
      | burgerservicenummer | gemeenteVanInschrijving.code | adres.id | adres.datumAanvangAdreshouding |
      |           345678901 | G1                           | A1234    |                     2025-04-03 |
    En de gebeurtenis is door het bewoning systeem verwerkt
    Als de bewoning van adres 'A1234' wordt gevraagd voor periode '2025-04-01' tot 'vandaag'
    Dan is adres 'A1234' in de periode '2025-04-03' tot 'vandaag' bewoond door de volgende personen
      | burgerservicenummer |
      |           345678901 |
