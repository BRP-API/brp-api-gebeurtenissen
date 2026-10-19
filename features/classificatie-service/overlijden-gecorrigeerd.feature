# language: nl
Functionaliteit: Gebeurtenis wanneer het overlijden is gecorrigeerd
  Als abonnee wil ik weten dat het overlijden is gecorrigeerd,
  zodat ik onderzoek kan doen naar de consequenties voor mijn dienstverlening aan betrokkene(n).

  Zie https://www.rvig.nl/hup/correcties-categorie-06.

  Als het overlijden is gecorrigeerd, heeft in de historisch geworden categorie Indicatie Onjuist (84.10) de waarde 'O' (Onjuist).

  In de gebeurtenis wordt de identificatie - het A-nummer - van de betreffende persoon in de data opgenomen.
  Ook wordt de datum overlijden opgenomen met zowel de gecorrigeerde (onjuiste) waarde als de juiste (actuele) waarde (als die er nog is).
  
  Achtergrond:
    Gegeven de persoon 'Jan'

  Regel: Als overlijden is gecorrigeerd, heeft de gebeurtenis 'overlijden.gecorrigeerd' plaatsgevonden
    Dit is alleen het geval wanneer met de correctie gegevens over het overlijden zijn gewijzigd:
    - datum, plaats en/of land (groep 08)

    Een correctie van administratieve gegevens leidt niet tot een gebeurtenis.

    Scenario: De persoon is niet overleden dus overlijden was ten onrechte geregistreerd
      Gegeven het overlijden van 'Jan' op '12-08-2026' in 'Gemeente Roosendaal' is verwerkt
      Als het overlijden van 'Jan' onjuist is en 'Jan' is niet overleden
      Dan is een 'overlijden.gecorrigeerd' gebeurtenis gepubliceerd

    Scenario: De datum van het overlijden was onjuist en is gecorrigeerd
      Gegeven het overlijden van 'Jan' op '12-08-2026' in 'Gemeente Roosendaal' is verwerkt
      Als het overlijden van 'Jan' onjuist is en 'Jan' is overleden op '13-08-2026' in 'Gemeente Roosendaal'
      Dan is een 'overlijden.gecorrigeerd' gebeurtenis gepubliceerd

    Scenario: De plaats en land van het overlijden waren onjuist en is gecorrigeerd
      Gegeven het overlijden van 'Jan' op '12-08-2026' in 'Gemeente Roosendaal' is verwerkt
      Als het overlijden van 'Jan' onjuist is en 'Jan' is overleden op '12-08-2026' in 'Berlijn' in 'Duitsland'
      Dan is een 'overlijden.gecorrigeerd' gebeurtenis gepubliceerd

    Scenario: Correctie van administratieve gegevens
      Gegeven het overlijden van 'Jan' op '12-08-2026' in 'Gemeente Roosendaal' is ontleend aan document 'verklaring overlijden'
      Als het overlijden van 'Jan' onjuist is en het overlijden is opgenomen met aktenummer '2XA0123'
      Dan is er geen 'verblijfplaats.gecorrigeerd' gebeurtenis gepubliceerd
  
  Regel: Bij gebeurtenistype 'overlijden.gecorrigeerd' wordt het A-nummer van de persoon meegeleverd plus de onjuiste en actuele datum overlijden

    Scenario: De persoon is niet overleden dus overlijden was ten onrechte geregistreerd
      Gegeven het overlijden van 'Jan' op '12-08-2026' in 'Gemeente Roosendaal' is verwerkt
      Als het overlijden van 'Jan' onjuist is en 'Jan' is niet overleden
      Dan is een 'overlijden.gecorrigeerd' gebeurtenis gepubliceerd met de volgende data
      * het A-nummer van 'Jan'
      * de onjuiste datum overlijden '12-08-2026'

    Scenario: De datum van het overlijden was onjuist en is gecorrigeerd
      Gegeven het overlijden van 'Jan' op '12-08-2026' in 'Gemeente Roosendaal' is verwerkt
      Als het overlijden van 'Jan' onjuist is en 'Jan' is overleden op '13-08-2026' in 'Gemeente Roosendaal'
      Dan is een 'overlijden.gecorrigeerd' gebeurtenis gepubliceerd met de volgende data
      * het A-nummer van 'Jan'
      * de onjuiste datum overlijden '12-08-2026'
      * de juiste datum overlijden '13-08-2026'

    Scenario: De plaats en land van het overlijden waren onjuist en is gecorrigeerd
      Gegeven het overlijden van 'Jan' op '12-08-2026' in 'Gemeente Roosendaal' is verwerkt
      Als het overlijden van 'Jan' onjuist is en 'Jan' is overleden op '12-08-2026' in 'Berlijn' in 'Duitsland'
      Dan is een 'overlijden.gecorrigeerd' gebeurtenis gepubliceerd met de volgende data
      * het A-nummer van 'Jan'
      * de onjuiste datum overlijden '12-08-2026'
      * de juiste datum overlijden '12-08-2026'
