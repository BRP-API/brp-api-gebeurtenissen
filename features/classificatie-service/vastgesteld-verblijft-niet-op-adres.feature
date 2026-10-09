# language: nl
Functionaliteit: Gebeurtenis wanneer een onderzoek loopt naar de verblijfplaats en is vastgesteld dat de persoon niet meer op dit adres verblijft
  Een burger kan bij de gemeente melden dat iemand anders ten onrechte op diens adres staat ingeschreven. 
  De gemeente doet daar dan onderzoek naar en kan concluderen dat deze andere persoon inderdaad niet meer op dat adres verblijft. 
  Wanneer tijdens de uitvoer van het onderzoek vastgesteld wordt dat een persoon niet meer woont op het adres waarop hij is ingeschreven in de BRP, 
  kan dit deel van het onderzoeksresultaat al worden opgenomen op de persoonslijst van de persoon. 
  
  Dit wordt gedaan door het zetten van aanduiding onderzoek 089999.
  Hiermee wordt geregistreerd dat is vastgesteld dat een persoon niet (langer) op het adres verblijft waarop hij ingeschreven staat, 
  maar dat het onderzoek naar het (nieuwe) woonadres nog loopt.
  Hierdoor kunnen eventuele problemen voor de nieuwe of oude medebewoners voorkomen worden.

  In de gebeurtenis wordt de identificatie - het A-nummer - van de betreffende persoon in de data opgenomen.
  Daarnaast wordt ook de datum aanvang (van adreshouding of verblijf buitenland) van de verblijfplaats opgenomen.
  De datum wordt opgenomen, zodat de abonnee de gebeurtenis kan relateren aan een verblijf. De abonnee kan de gebeurtenis namelijk pas verwerken nadat het verblijf al historisch is geworden.
  
  De abonnee kan meer informatie over het onderzoek desgewenst ophalen in de BRP-API personen bevragen of met de BRP-API verblijfplaatshistorie met bijvoorbeeld peildatum gelijk aan de geleverde datum aanvang.
  De abonnee kan als datum vanaf wanneer geldt dat de persoon niet meer op het adres verblijft de begindatum van het onderzoek hanteren.
  In de BRP-API verblijfplaatshistorie wordt deze datum geleverd in 'verblijftNietOpAdresVanaf'.

  Achtergrond:
    Gegeven het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    * in gemeente 'Hengelo'
    En het adres 'Beursstraat_44_Hengelo'
    * in gemeente 'Hengelo'
    En de persoon 'Jan'
    * verblijft vanaf '14-04-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    * verblijft vanaf '14-06-2026' op het adres 'Beursstraat_44_Hengelo'

  Regel: Als is vastgesteld dat de persoon niet verblijft op het geregistreerde adres, heeft de gebeurtenis 'vastgesteld-verblijft-niet-op-adres' plaatsgevonden

    Scenario: Tijdens het onderzoek is vastgesteld dat de persoon niet verblijft op het adres
      Gegeven een onderzoek loopt naar het verblijf op het adres 'Beursstraat_44_Hengelo' van 'Jan'
      Als het onderzoek naar het verblijf op het adres 'Beursstraat_44_Hengelo' van 'Jan' is gewijzigd naar 'vastgesteld verblijft niet op adres'
      Dan is een 'vastgesteld-verblijft-niet-op-adres' gebeurtenis gepubliceerd

    Scenario: Bij de start van het onderzoek is al duidelijk dat de persoon niet verblijft op het adres
      Als is vastgesteld dat 'Jan' niet verblijft op het adres 'Beursstraat_44_Hengelo'
      Dan is een 'vastgesteld-verblijft-niet-op-adres' gebeurtenis gepubliceerd

  Regel: Bij gebeurtenistype 'vastgesteld-verblijft-niet-op-adres' wordt het A-nummer van de persoon meegeleverd plus de datum aanvang van het betreffende verblijf
    De datum aanvang waar hier op gedoeld wordt is de datum aanvang adreshouding, dan wel datum aanvang verblijf buitenland.

    Scenario: Tijdens het onderzoek is vastgesteld dat de persoon niet verblijft op het adres
      Gegeven een onderzoek loopt sinds '17-09-2026' naar het verblijf op het adres 'Beursstraat_44_Hengelo' van 'Jan'
      Als het onderzoek naar het verblijf op het adres 'Beursstraat_44_Hengelo' van 'Jan' is gewijzigd naar 'vastgesteld verblijft niet op adres'
      Dan is een 'vastgesteld-verblijft-niet-op-adres' gebeurtenis gepubliceerd met de volgende data
      * het A-nummer 'Jan'
      * datum aanvang '14-06-2026'
