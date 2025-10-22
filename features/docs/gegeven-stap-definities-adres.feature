# language: nl
Functionaliteit: Adres gegeven stap definities

  Scenario: Gegeven het adres '[adres aanduiding]'
    Gegeven het adres 'A1'
    Dan heeft het adres 'A1' geen eigenschappen

  Scenario: Gegeven in gemeente '[gemeente omschrijving]'
    Gegeven het adres 'A1'
    * in gemeente 'Hengelo'
    Dan heeft het adres 'A1' de volgende eigenschappen
      | gemeente_code |
      |          0164 |

  Scenario: Gegeven met adresseerbaar object identificatie '[waarde]'
    Gegeven het adres 'A1'
    * met adresseerbaar object identificatie '0164010000047847'
    Dan heeft het adres 'A1' de volgende eigenschappen
      | verblijf_plaats_ident_code |
      |           0164010000047847 |