# language: nl
Functionaliteit: Gebeurtenis wanneer de verblijfplaats is gecorrigeerd
  Als abonnee wil ik weten dat een verblijfplaats is gecorrigeerd,
  zodat ik onderzoek kan doen naar de consequenties voor mijn dienstverlening aan betrokkene(n).

  In de gebeurtenis wordt de identificatie - het A-nummer - van de betreffende persoon in de data opgenomen.
  Daarnaast worden enkele gegevens van de verblijfplaats opgenomen met zowel de gecorrigeerde (onjuiste) waarde als de actuele waarde
  - datum aanvang adreshouding
  - adresseerbaar object identificatie van het adres (identificatiecode verblijfplaats)

  Achtergrond:
    Gegeven het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    * in gemeente 'Hengelo'
    En het adres 'Stadserf_1_Roosendaal'
    * in gemeente 'Roosendaal'
    En het adres 'Kadeplein_2_Roosendaal'
    * in gemeente 'Roosendaal'
    En het adres 'Coolsingel_40_Rotterdam'
    * in gemeente 'Rotterdam'
    En de persoon 'Jan'
    * verblijft vanaf '14-04-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    * verblijft vanaf '19-06-2026' op het adres 'Stadserf_1_Roosendaal'

  Regel: Als de verblijfplaats is gecorrigeerd, heeft de gebeurtenis 'verblijfplaats.gecorrigeerd' plaatsgevonden
    Een correctie van administratieve gegevens leidt niet tot deze gebeurtenis.

    Scenario: Correctie van het adres
      Als de verblijfplaats van 'Jan' vanaf '19-06-2026' op het adres 'Stadserf_1_Roosendaal' onjuist is
      En de juiste verblijfplaats van 'Jan' is het adres 'Kadeplein_2_Roosendaal' vanaf '19-06-2026'
      Dan is een 'verblijfplaats.gecorrigeerd' gebeurtenis gepubliceerd

    Scenario: Correctie van de datum aanvang van het verblijf
      Als de verblijfplaats van 'Jan' vanaf '19-06-2026' op het adres 'Stadserf_1_Roosendaal' onjuist is
      En de juiste datum aanvang is '17-06-2026'
      Dan is een 'verblijfplaats.gecorrigeerd' gebeurtenis gepubliceerd

    Scenario: Correctie van de verblijfplaats met inschrijving in andere gemeente
      Als de verblijfplaats van 'Jan' vanaf '19-06-2026' op het adres 'Stadserf_1_Roosendaal' onjuist is
      En de juiste verblijfplaats van 'Jan' is het adres 'Coolsingel_40_Rotterdam' vanaf '19-06-2026'
      Dan is een 'verblijfplaats.gecorrigeerd' gebeurtenis gepubliceerd

    Scenario: Herstel naar vorige verblijfplaats die in een andere gemeente ligt
      Als de verblijfplaats van 'Jan' vanaf '19-06-2026' op het adres 'Stadserf_1_Roosendaal' onjuist is
      En de juiste verblijfplaats van 'Jan' is het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo' vanaf '14-04-2020'
      Dan is een 'verhuisd.intergemeentelijk' gebeurtenis gepubliceerd
      En is een 'verblijfplaats.gecorrigeerd' gebeurtenis gepubliceerd

    Scenario: Correctie van administratieve gegevens
      Gegeven het verblijf van 'Jan' vanaf '19-06-2026' op het adres 'Stadserf_1_Roosendaal' is aangegeven door een meerderjarige gemachtigde
      Als de verblijfplaats van 'Jan' vanaf '19-06-2026' op het adres 'Stadserf_1_Roosendaal' onjuist is
      En de juiste aangifte voor het verblijf vanaf '19-06-2026' is door de echtgenoot/partner
      Dan is er geen 'verblijfplaats.gecorrigeerd' gebeurtenis gepubliceerd

  Regel: Bij gebeurtenistype 'verblijfplaats.gecorrigeerd' wordt het A-nummer van de persoon meegeleverd plus de onjuiste en actuele datum verblijfplaats
    Van de verblijfplaats worden alleen de volgende gegevens geleverd, wanneer het een adres in Nederland betreft:
    - datum aanvang adreshouding
    - adresseerbaar object identificatie van het adres

    Wanneer de correctie een verblijfplaats in het buitenland betreft, dan wordt datum aanvang verblijf buitenland geleverd.

    Deze gegevens worden geleverd van zowel de onjuist geworden (nu historische) categorie als de juiste (nu actuele) categorie.

    Scenario: Correctie van het adres
      Als de verblijfplaats van 'Jan' vanaf '19-06-2026' op het adres 'Stadserf_1_Roosendaal' onjuist is
      En de juiste verblijfplaats van 'Jan' is het adres 'Kadeplein_2_Roosendaal' vanaf '19-06-2026'
      Dan is een 'verblijfplaats.gecorrigeerd' gebeurtenis gepubliceerd met de volgende data
      * het A-nummer van 'Jan'
      * de onjuiste datum aanvang adreshouding '19-06-2026'
      * de onjuiste adresseerbaar object identificatie van het onjuiste adres 'Stadserf_1_Roosendaal'
      * de juiste datum aanvang adreshouding '19-06-2026'
      * de juiste adresseerbaar object identificatie van het actuele adres 'Kadeplein_2_Roosendaal'

    Scenario: Correctie van de verblijfplaats met adres buitenland
      Gegeven het adres buitenland 'Chemin_du_Calvaire_19_Lausanne'
      * met adresregel 1 'Chemin de Calvaire 19'
      * met adresregel 2 'Lausanne'
      * met adresregel 3 'Vaud'
      * in land 'Zwitserland'
      En het adres buitenland 'KayaGrandi_12_Kralendijk'
      * met adresregel 1 'Kaya Grandi 12'
      * met adresregel 2 'Kralendijk'
      * in land 'Bonaire'
      En de persoon 'Jan'
      * verblijft vanaf '1-10-2026' op het adres 'Chemin_du_Calvaire_19_Lausanne'
      Als de verblijfplaats van 'Jan' vanaf '1-10-2026' op het adres 'Chemin_du_Calvaire_19_Lausanne' onjuist is
      En de juiste verblijfplaats van 'Jan' is het adres 'KayaGrandi_12_Kralendijk' vanaf '1-10-2026'
      Dan is een 'verblijfplaats.gecorrigeerd' gebeurtenis gepubliceerd met de volgende data
      * het A-nummer van 'Jan'
      * de onjuiste datum aanvang verblijf buitenland '1-10-2026'
      * de juiste datum aanvang verblijf buitenland '1-10-2026'

    Scenario: Correctie van de datum aanvang van het verblijf
      Als de verblijfplaats van 'Jan' vanaf '19-06-2026' op het adres 'Stadserf_1_Roosendaal' onjuist is
      En de juiste datum aanvang is '17-06-2026'
      Dan is een 'verblijfplaats.gecorrigeerd' gebeurtenis gepubliceerd met de volgende data
      * het A-nummer van 'Jan'
      * de onjuiste datum aanvang adreshouding '19-06-2026'
      * de adresseerbaar object identificatie van het onjuiste adres 'Stadserf_1_Roosendaal'
      * de juiste datum aanvang adreshouding '17-06-2026'
      * de juiste object identificatie van het actuele adres 'Stadserf_1_Roosendaal'

  Regel: Als de verblijfplaats is gewijzigd en daarbij de vorige verblijfplaats logisch vervalt, heeft geen 'verblijfplaats.gecorrigeerd' gebeurtenis plaatsgevonden
    Dit betreft een situatie dat ten onrechte de verblijfplaats niet als onjuist is bestempeld, maar deze wel uit de verblijfplaatshistorie verdwijnt.
    Dit is het geval wanneer de datum aanvang adreshouding van het nieuwe verblijf gelijk is aan of eerder ligt dan de datum aanvang van het huidige verblijf.
    Dit had eigenlijk als correctie verwerkt mogen worden. Dit is dus volgens LO BRP en HUP geen correcte situatie.

    Scenario: De begindatum van het nieuwe verblijf ligt eerder dan de begindatum van het huidige verblijf
      Als de verblijfplaats van 'Jan' is gewijzigd
      * verblijft vanaf '01-05-2026' op het adres 'Kadeplein_2_Roosendaal'
      Dan is er geen 'verblijfplaats.gecorrigeerd' gebeurtenis gepubliceerd

  Regel: Als een historische verblijfplaats onjuist wordt, heeft geen 'verblijfplaats.gecorrigeerd' gebeurtenis plaatsgevonden

    Scenario: De vorige verblijfplaats was onjuist en de huidige verblijfplaats is ongewijzigd
      Als de verblijfplaats van 'Jan' vanaf '14-04-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo' onjuist is
      En de juiste verblijfplaats van 'Jan' vanaf '14-04-2020' is op het adres 'Kadeplein_2_Roosendaal'
      Dan is er geen 'verblijfplaats.gecorrigeerd' gebeurtenis gepubliceerd
