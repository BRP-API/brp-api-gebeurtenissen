# language: nl
Functionaliteit: Gebeurtenis wanneer de verblijfplaats is gecorrigeerd

  Achtergrond:
    Gegeven het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    * in gemeente 'Hengelo'
    En het adres 'Stadserf_1_Roosendaal'
    * in gemeente 'Roosendaal'
    En het adres 'Kadeplein_2_Roosendaal'
    * in gemeente 'Roosendaal'
    En de persoon 'Jan'
    * verblijft vanaf '14-04-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    * verblijft vanaf '14-06-2026' op het adres 'Stadserf_1_Roosendaal'

  Regel: Als de verblijfplaats is gecorrigeerd, heeft de gebeurtenis 'verblijfplaats-gecorrigeerd' plaatsgevonden
    Dit is alleen het geval wanneer met de correctie gegevens over het verblijf zijn gewijzigd:
    - gemeente
    - adreshouding (o.a. datum aanvang adreshouding en functie adres)
    - adres, locatie of adres buitenland

    Bij de verblijfplaats wordt ook informatie over de immigratie opgeslagen.
    Een verblijfplaats kan dus ook 'onjuist' zijn wanneer de immigratiegegevens daarin worden gecorrigeerd.
    In dat geval is geen sprake van gebeurtenis 'verblijfplaats-gecorrigeerd'.

    Ook correctie van administratieve gegevens leidt niet tot een gebeurtenis.

    Scenario: Correctie van het adres
      Als de verblijfplaats vanaf '14-06-2026' op het adres 'Stadserf_1_Roosendaal' onjuist is
      En de juiste verblijfplaats is het adres 'Kadeplein_2_Roosendaal' vanaf '14-06-2026'
      Dan is een 'verblijfplaats-gecorrigeerd' gebeurtenis gepubliceerd

    Scenario: Correctie van de datum aanvang van het verblijf
      Als de verblijfplaats vanaf '14-06-2026' op het adres 'Stadserf_1_Roosendaal' onjuist is
      En de juiste datum aanvang is '17-06-2026'
      Dan is een 'verblijfplaats-gecorrigeerd' gebeurtenis gepubliceerd

    Scenario: Herstel naar vorige verblijfplaats die in een andere gemeente ligt
      Als de verblijfplaats vanaf '14-06-2026' op het adres 'Stadserf_1_Roosendaal' onjuist is
      En de juiste verblijfplaats is het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo' vanaf '14-04-2020'
      Dan is een 'verhuisd.intergemeentelijk' gebeurtenis gepubliceerd
      En is een 'verblijfplaats-gecorrigeerd' gebeurtenis gepubliceerd

    Scenario: Correctie van immigratie
      Gegeven de persoon 'Piet'
      * is op 14-06-2026 geïmmigreerd vanuit 'Frankrijk'
      * verblijft vanaf '14-06-2026' op het adres 'Stadserf_1_Roosendaal'
      Als de immigratie op '14-06-2026' onjuist is
      En het juiste immigratieland is 'Spanje'
      Dan is er geen 'verblijfplaats-gecorrigeerd' gebeurtenis gepubliceerd

    Scenario: Correctie van administratieve gegevens
      Gegeven het verblijf vanaf '14-06-2026' op het adres 'Stadserf_1_Roosendaal' is aangegeven door een meerderjarige gemachtigde
      Als de verblijfplaats vanaf '14-06-2026' op het adres 'Stadserf_1_Roosendaal' onjuist is
      En de juiste aangifte voor het verblijf vanaf '14-06-2026' is door de echtgenoot/partner
      Dan is er geen 'verblijfplaats-gecorrigeerd' gebeurtenis gepubliceerd

  Regel: Als de verblijfplaats is gewijzigd en daarbij de vorige verblijfplaats vervalt, heeft geen 'verblijfplaats-gecorrigeerd' gebeurtenis plaatsgevonden
    Dit betreft een situatie dat ten onrechte de verblijfplaats niet als onjuist is bestempeld, maar deze wel uit de verblijfplaatshistorie verdwijnt.
    Dit is het geval wanneer de datum aanvang adreshouding van het nieuwe verblijf gelijk is aan of eerder ligt dan de datum aanvang van het huidige verblijf.

    Scenario: De begindatum van het nieuwe verblijf ligt eerder dan de begindatum van het huidige verblijf
      Als de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf '01-05-2026' op het adres 'Kadeplein_2_Roosendaal'
      Dan is er geen 'verblijfplaats-gecorrigeerd' gebeurtenis gepubliceerd

  Regel: Als een historische verblijfplaats onjuist wordt, heeft geen 'verblijfplaats-gecorrigeerd' gebeurtenis plaatsgevonden

    Scenario: De vorige verblijfplaats was onjuist en de huidige verblijfplaats is ongewijzigd
      Als de verblijfplaats vanaf '14-04-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo' onjuist is
      En het juiste verblijf vanaf '14-04-2020' is op het adres 'Kadeplein_2_Roosendaal'
      En 'Jan' verblijft vanaf '14-06-2026' op het adres 'Stadserf_1_Roosendaal'
      Dan is er geen 'verblijfplaats-gecorrigeerd' gebeurtenis gepubliceerd
