# language: nl
Functionaliteit: Adres gegeven stap definities

  Scenario: Gegeven het adres '[adres aanduiding]'
    Gegeven het adres 'A1'
    Dan heeft het adres 'A1' geen eigenschappen

  Abstract Scenario: Gegeven in gemeente '[gemeente omschrijving]'
    Gegeven het adres 'A1'
    * in gemeente '<gemeente omschrijving>'
    Dan heeft het adres 'A1' de volgende eigenschappen
      | gemeente_code   |
      | <gemeente code> |

    Voorbeelden:
      | gemeente omschrijving | gemeente code |
      | Amsterdam             |          0363 |
      | Den Haag              |          0518 |
      | Hengelo               |          0164 |
      | Roosendaal            |          1674 |
      | Rotterdam             |          0599 |
      | Utrecht               |          0344 |

  Scenario: Gegeven met adresseerbaar object identificatie '[waarde]'
    Gegeven het adres 'A1'
    * met adresseerbaar object identificatie '0164010000047847'
    Dan heeft het adres 'A1' de volgende eigenschappen
      | verblijf_plaats_ident_code |
      |           0164010000047847 |

  Scenario: Gegeven het adres buitenland '[adres aanduiding]'
    Gegeven het adres buitenland 'A1'
    Dan heeft het adres 'A1' geen eigenschappen

  Abstract Scenario: Gegeven met adres regel 1 '[waarde]'
    Gegeven het adres buitenland 'A1'
    * met adres regel <regel nr> 'buitenlands adres regel'
    Dan heeft het adres 'A1' de volgende eigenschappen
      | vertrek_land_adres_<regel nr> |
      | buitenlands adres regel       |

    Voorbeelden:
      | regel nr |
      |        1 |
      |        2 |
      |        3 |

  Abstract Scenario: Gegeven in land '[land omschrijving]'
    Gegeven het adres buitenland 'A1'
    * in land '<land omschrijving>'
    Dan heeft het adres 'A1' de volgende eigenschappen
      | vertrek_land_code |
      | <land code>       |

    Voorbeelden:
      | land omschrijving            | land code |
      | Frankrijk                    |      5002 |
      | Zwitserland                  |      5003 |
      | België                       |      5010 |
      | Verenigde Staten van Amerika |      6014 |
      | Duitsland                    |      6029 |
      | Onbekend                     |      0000 |
