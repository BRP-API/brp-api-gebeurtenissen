# language: nl

Functionaliteit: 1e inschrijving BRP

  Als afnemer van de BRP
  wil ik een notificatie ontvangen als een Nederlander uit het buitenland zich heeft ingeschreven bij een gemeente

  Achtergrond:
    Gegeven adres 'A1' in gemeente 'G1'
    En de 1e inschrijving BRP van 'Jan'
    * met de volgende bewoning gegevens
      | adres | ingangsdatum            |
      | A1    | gisteren 5 jaar geleden |

  Regel: Een 'EersteInschrijvingBRP' gebeurtenis is gepubliceerd als een Nederlander uit het buitenland (zonder bsn) zich inschrijft bij een gemeente

    Scenario: Een Nederlander uit het buitenland (zonder bsn) schrijft zich in op een adres bij een gemeente
      Als de 1e inschrijving BRP van 'Jan' is verwerkt
      Dan is een 'EersteInschrijvingBRP' gebeurtenis gepubliceerd voor 'Jan'
      En heeft de gebeurtenis de volgende verblijfplaats gegevens
        | datumVan                | functieAdres.code |
        | gisteren 5 jaar geleden | W                 |

  Regel: Abonnees van 'EersteInschrijvingBRP' gebeurtenissen in de betreffende gemeente zijn genotificeerd

    Scenario: Een afnemer is geabonneerd op 'EersteInschrijvingBRP' gebeurtenissen
      Gegeven afnemer 'B1' is geabonneerd op 'EersteInschrijvingBRP' gebeurtenissen in gemeente 'G1'
      Als de 1e inschrijving BRP van 'Jan' is verwerkt
      Dan is afnemer 'B1' genotificeerd dat een 'EersteInschrijvingBRP' gebeurtenis heeft plaatsgevonden
