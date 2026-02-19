# language: nl
@stap-documentatie
Functionaliteit: Persoon gegeven stap definities

  Scenario: Gegeven de persoon '[persoon aanduiding]'
    Gegeven de persoon 'P1'
    Dan heeft de persoon 'P1' de volgende eigenschappen
      | persoon_type | stapel_nr | volg_nr | geheim_ind | geslachts_naam |
      | P            |         0 |       0 |          0 | P1             |

  Scenario: Met A-nummer
    En de persoon 'P1'
    * met A-nummer '1234567890'
    Dan heeft de persoon 'P1' de volgende eigenschappen
      | persoon_type | stapel_nr | volg_nr | geheim_ind | geslachts_naam | a_nr       |
      | P            |         0 |       0 |          0 | P1             | 1234567890 |

  Scenario: Met burgerservicenummer
    En de persoon 'P1'
    * met burgerservicenummer '123456789'
    Dan heeft de persoon 'P1' de volgende eigenschappen
      | persoon_type | stapel_nr | volg_nr | geheim_ind | geslachts_naam | burger_service_nr |
      | P            |         0 |       0 |          0 | P1             |         123456789 |
