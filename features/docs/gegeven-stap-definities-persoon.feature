# language: nl
Functionaliteit: Persoon gegeven stap definities

  Scenario: Gegeven de persoon '[persoon aanduiding]'
    Gegeven de persoon 'P1'
    Dan heeft de persoon 'P1' de volgende eigenschappen
      | persoon_type | stapel_nr | volg_nr | geheim_ind |
      | P            |         0 |       0 |          0 |

  Scenario: Met A-nummer
    En de persoon 'P1'
    * met A-nummer '1234567890'
    Dan heeft de persoon 'P1' de volgende eigenschappen
      | persoon_type | stapel_nr | volg_nr | geheim_ind | a_nr       |
      | P            |         0 |       0 |          0 | 1234567890 |

  Scenario: Met burgerservicenummer
    En de persoon 'P1'
    * met burgerservicenummer '123456789'
    Dan heeft de persoon 'P1' de volgende eigenschappen
      | persoon_type | stapel_nr | volg_nr | geheim_ind | burger_service_nr |
      | P            |         0 |       0 |          0 |         123456789 |
