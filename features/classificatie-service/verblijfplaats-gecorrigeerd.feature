# language: nl
Functionaliteit: Gebeurtenis wanneer de verblijfplaats is gecorrigeerd
  Als abonnee wil ik weten dat een verhuizing is gecorrigeerd,
  zodat ik onderzoek kan doen naar de consequenties voor mijn dienstverlening aan betrokkene(n).

  In de gebeurtenis wordt de identificatie - het A-nummer - van de betreffende persoon in de data opgenomen.
  Daarnaast worden enkele gegevens van de verblijfplaats opgenomen met zowel de gecorrigeerde (onjuiste) waarde als de actuele waarde
  - datum aanvang adreshouding
  - adresseerbaar object identificatie van het adres (identificatiecode verblijfplaats)
  
  Aan de abonnee wordt in de gebeurtenis alleen de onjuiste datum aanvang geleverd, zodat de abonnee de gebeurtenis kan relateren aan een verblijf.
  Aan de abonnee wordt geen data meegestuurd waaruit af te leiden is wat exact gecorrigeerd is, omdat we niet weten voor welke gegevens de abonnee geautoriseerd is.

  De abonnee kan meer informatie over de correctie desgewenst ophalen in de BRP-API personen bevragen of met de BRP-API verblijfplaatshistorie met bijvoorbeeld peildatum gelijk aan de geleverde datum aanvang, met enkele kanttekeningen:
  - Als de correctie alleen gaat over een gegeven waar de abonnee niet voor geautoriseerd is, kan de abonnee in de BRP-API niet zien wat er gewijzigd is
  - Mogelijk moet de abonnee meer verblijfplaatshistorie vragen dan alleen op peildatum van de datum aanvang om een compleet beeld te krijgen van de verblijfplaats(en) na correctie.

  Achtergrond:
    Gegeven het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    * in gemeente 'Hengelo'
    En het adres 'Stadserf_1_Roosendaal'
    * in gemeente 'Roosendaal'
    En het adres 'Kadeplein_2_Roosendaal'
    * in gemeente 'Roosendaal'
    En de persoon 'Jan'
    * verblijft vanaf '14-04-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    * verblijft vanaf '19-06-2026' op het adres 'Stadserf_1_Roosendaal'

  Regel: Als de verblijfplaats is gecorrigeerd, heeft de gebeurtenis 'verblijfplaats.gecorrigeerd' plaatsgevonden
    Dit is alleen het geval wanneer met de correctie gegevens over het verblijf zijn gewijzigd:
    - gemeente
    - adreshouding (o.a. datum aanvang adreshouding en functie adres)
    - adres, locatie of adres buitenland

    Bij de verblijfplaats wordt ook informatie over de immigratie opgeslagen.
    Een verblijfplaats kan dus ook 'onjuist' zijn wanneer de immigratiegegevens daarin worden gecorrigeerd.
    In dat geval is geen sprake van gebeurtenis 'verblijfplaats.gecorrigeerd'.

    Een correctie van administratieve gegevens leidt niet tot een gebeurtenis.

    Scenario: Correctie van het adres
      Als de verblijfplaats vanaf '19-06-2026' op het adres 'Stadserf_1_Roosendaal' onjuist is
      En de juiste verblijfplaats is het adres 'Kadeplein_2_Roosendaal' vanaf '19-06-2026'
      Dan is een 'verblijfplaats.gecorrigeerd' gebeurtenis gepubliceerd

    Scenario: Correctie van de datum aanvang van het verblijf
      Als de verblijfplaats vanaf '19-06-2026' op het adres 'Stadserf_1_Roosendaal' onjuist is
      En de juiste datum aanvang is '17-06-2026'
      Dan is een 'verblijfplaats.gecorrigeerd' gebeurtenis gepubliceerd

    Scenario: Herstel naar vorige verblijfplaats die in een andere gemeente ligt
      Als de verblijfplaats vanaf '19-06-2026' op het adres 'Stadserf_1_Roosendaal' onjuist is
      En de juiste verblijfplaats is het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo' vanaf '14-04-2020'
      Dan is een 'verhuisd.intergemeentelijk' gebeurtenis gepubliceerd
      En is een 'verblijfplaats.gecorrigeerd' gebeurtenis gepubliceerd

    Scenario: Correctie van immigratie
      Gegeven de persoon 'Piet'
      * is op 19-06-2026 geïmmigreerd vanuit 'Frankrijk'
      * verblijft vanaf '19-06-2026' op het adres 'Stadserf_1_Roosendaal'
      Als de immigratie op '19-06-2026' onjuist is
      En het juiste immigratieland is 'Spanje'
      Dan is er geen 'verblijfplaats.gecorrigeerd' gebeurtenis gepubliceerd

    Scenario: Correctie van administratieve gegevens
      Gegeven het verblijf vanaf '19-06-2026' op het adres 'Stadserf_1_Roosendaal' is aangegeven door een meerderjarige gemachtigde
      Als de verblijfplaats vanaf '19-06-2026' op het adres 'Stadserf_1_Roosendaal' onjuist is
      En de juiste aangifte voor het verblijf vanaf '19-06-2026' is door de echtgenoot/partner
      Dan is er geen 'verblijfplaats.gecorrigeerd' gebeurtenis gepubliceerd

  Regel: Bij gebeurtenistype 'verblijfplaats.gecorrigeerd' wordt het A-nummer van de persoon meegeleverd plus de onjuiste en actuele datum verblijfplaats
    Van de verblijfplaats worden alleen de volgende gegevens geleverd:
    - datum aanvang adreshouding
    - adresseerbaar object identificatie van het adres

    Deze gegevens worden geleverd van zowel de onjuist geworden (nu historische) categorie als de juiste (nu actuele) categorie.

    Scenario: Correctie van het adres
      Als de verblijfplaats vanaf '19-06-2026' op het adres 'Stadserf_1_Roosendaal' onjuist is
      En de juiste verblijfplaats is het adres 'Kadeplein_2_Roosendaal' vanaf '19-06-2026'
      Dan is een 'verblijfplaats.gecorrigeerd' gebeurtenis gepubliceerd met de volgende data
      * het A-nummer van 'Jan'
      * de onjuiste datum aanvang adreshouding '19-06-2026'
      * de onjuiste adresseerbaar object identificatie van het onjuiste adres 'Stadserf_1_Roosendaal'
      * de juiste datum aanvang adreshouding '19-06-2026'
      * de juiste adresseerbaar object identificatie van het actuele adres 'Kadeplein_2_Roosendaal'

    Scenario: Correctie van de datum aanvang van het verblijf
      Als de verblijfplaats vanaf '19-06-2026' op het adres 'Stadserf_1_Roosendaal' onjuist is
      En de juiste datum aanvang is '17-06-2026'
      Dan is een 'verblijfplaats.gecorrigeerd' gebeurtenis gepubliceerd met de volgende data
      * het A-nummer van 'Jan'
      * de onjuiste datum aanvang adreshouding '19-06-2026'
      * de adresseerbaar object identificatie van het onjuiste adres 'Stadserf_1_Roosendaal'
      * de juiste datum aanvang adreshouding '17-06-2026'
      * de juiste object identificatie van het actuele adres 'Stadserf_1_Roosendaal'

    Scenario: De persoon heeft nooit op het adres gewoond, het adres is eerst gewijzigd en daarna wordt aangegeven dat het vorige adres onjuist was
      Gegeven de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf '1-10-2026' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
      Als de verblijfplaats vanaf '19-06-2026' op het adres 'Stadserf_1_Roosendaal' onjuist is
      En de juiste verblijfplaats is het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo' vanaf '14-04-2020'
      Dan is er geen 'verblijfplaats.gecorrigeerd' gebeurtenis gepubliceerd met de volgende data
      * het A-nummer van 'Jan'
      * de onjuiste datum aanvang adreshouding '19-06-2026'
      * de adresseerbaar object identificatie van het onjuiste adres 'Stadserf_1_Roosendaal'
      * de juiste datum aanvang adreshouding '14-04-2020'
      * de juiste object identificatie van het actuele adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'

  Regel: Als de verblijfplaats is gewijzigd en daarbij de vorige verblijfplaats vervalt, heeft geen 'verblijfplaats.gecorrigeerd' gebeurtenis plaatsgevonden
    Dit betreft een situatie dat ten onrechte de verblijfplaats niet als onjuist is bestempeld, maar deze wel uit de verblijfplaatshistorie verdwijnt.
    Dit is het geval wanneer de datum aanvang adreshouding van het nieuwe verblijf gelijk is aan of eerder ligt dan de datum aanvang van het huidige verblijf.
    Dit had eigenlijk als correctie verwerkt mogen worden. Dit is dus volgens LO BRP en HUP geen correcte situatie.

    Scenario: De begindatum van het nieuwe verblijf ligt eerder dan de begindatum van het huidige verblijf
      Als de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf '01-05-2026' op het adres 'Kadeplein_2_Roosendaal'
      Dan is er geen 'verblijfplaats.gecorrigeerd' gebeurtenis gepubliceerd

  Regel: Als een historische verblijfplaats onjuist wordt, heeft geen 'verblijfplaats.gecorrigeerd' gebeurtenis plaatsgevonden

    Scenario: De vorige verblijfplaats was onjuist en de huidige verblijfplaats is ongewijzigd
      Als de verblijfplaats vanaf '14-04-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo' onjuist is
      En het juiste verblijf vanaf '14-04-2020' is op het adres 'Kadeplein_2_Roosendaal'
      En 'Jan' verblijft vanaf '19-06-2026' op het adres 'Stadserf_1_Roosendaal'
      Dan is er geen 'verblijfplaats.gecorrigeerd' gebeurtenis gepubliceerd
