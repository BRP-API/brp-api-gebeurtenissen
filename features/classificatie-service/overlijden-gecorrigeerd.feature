# language: nl
Functionaliteit: Gebeurtenis wanneer het overlijden is gecorrigeerd
  In de gebeurtenis wordt alleen de identificatie - het A-nummer - van de betreffende persoon in de data opgenomen.
  Meer gegevens zijn niet nodig om de correctie aan te duiden, omdat overlijden geen historie heeft.
  
  Er wordt geen data meegestuurd waaruit af te leiden is wat exact gecorrigeerd is, omdat we niet weten voor welke gegevens de abonnee geautoriseerd is.

  De abonnee kan meer informatie desgewenst ophalen in de BRP-API door het overlijden op te vragen. De abonnee ontvangt dan de nieuwe actuele situatie.
  Als bij de correctie het overlijden is verwijderd, dan ontvangt de abonnee geen overlijden uit de BRP-API en moet de abonnee daaruit concluderen dat de persoon toch in leven is.

  Achtergrond:
    Gegeven de persoon 'Jan'

  Regel: Als overlijden is gecorrigeerd, heeft de gebeurtenis 'overlijden-gecorrigeerd' plaatsgevonden

    Scenario: De persoon is niet overleden dus overlijden was ten onrechte geregistreerd
      Gegeven het overlijden van 'Jan' op '12-08-2026' in 'Gemeente Roosendaal' is verwerkt
      Als het overlijden van 'Jan' onjuist is en 'Jan' is niet overleden
      Dan is een 'overlijden-gecorrigeerd' gebeurtenis gepubliceerd

    Scenario: De datum van het overlijden was onjuist en is gecorrigeerd
      Gegeven het overlijden van 'Jan' op '12-08-2026' in 'Gemeente Roosendaal' is verwerkt
      Als het overlijden van 'Jan' onjuist is en 'Jan' is overleden op '13-08-2026' in 'Gemeente Roosendaal'
      Dan is een 'overlijden-gecorrigeerd' gebeurtenis gepubliceerd

    Scenario: De plaats van het overlijden was onjuist en is gecorrigeerd
      Gegeven het overlijden van 'Jan' op '12-08-2026' in 'Gemeente Roosendaal' is verwerkt
      Als het overlijden van 'Jan' onjuist is en 'Jan' is overleden op '12-08-2026' in 'Berlijn' in 'Duitsland'
      Dan is een 'overlijden-gecorrigeerd' gebeurtenis gepubliceerd

  Regel: Bij gebeurtenistype 'overlijden-gecorrigeerd' wordt het A-nummer van de persoon meegeleverd

    Scenario: De persoon is niet overleden dus overlijden was ten onrechte geregistreerd
      Gegeven het overlijden van 'Jan' op '12-08-2026' in 'Gemeente Roosendaal' is verwerkt
      Als het overlijden van 'Jan' onjuist is en 'Jan' is niet overleden
      Dan is een 'overlijden-gecorrigeerd' gebeurtenis gepubliceerd met de volgende data
      * het A-nummer van 'Jan'
