# language: nl
Functionaliteit: Gebeurtenis wanneer het overlijden is gecorrigeerd

  Achtergrond:
    Gegeven de persoon 'Jan'

  Regel: Als overlijden is gecorrigeerd, heeft de gebeurtenis 'overlijden-gecorrigeerd' plaatsgevonden

    Scenario: De persoon is niet overleden dus overlijden was ten onrechte geregistreerd
      Gegeven het overlijden van 'Jan' op '12-08-2026' in 'Gemeente Roosendaal' is verwerkt
      Als het overlijden op '12-08-2026' onjuist is
      En de persoon is niet overleden
      Dan is een 'overlijden-gecorrigeerd' gebeurtenis gepubliceerd

    Scenario: De datum van het overlijden was onjuist en is gecorrigeerd
      Gegeven het overlijden van 'Jan' op '12-08-2026' in 'Gemeente Roosendaal' is verwerkt
      Als het overlijden op '12-08-2026' onjuist is
      En 'Jan' is overleden op '13-08-2026' in 'Gemeente Roosendaal'
      Dan is een 'overlijden-gecorrigeerd' gebeurtenis gepubliceerd
