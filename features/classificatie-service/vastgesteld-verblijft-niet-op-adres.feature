# language: nl
Functionaliteit: Gebeurtenis wanneer een onderzoek loopt naar de verblijfplaats en is vastgesteld dat de persoon niet meer op dit adres verblijft
  Als abonnee wil ik weten dat is vastgesteld dat een persoon niet meer op het adres verblijft,
  zodat ik een onderzoek kan starten naar de consequenties hiervan op mijn dienstverlening.

  De abonnee kan bijvoorbeeld naar aanleiding van deze gebeurtenis invordering (aanmaningen, deurwaarder) tijdelijk stopzetten en brieven niet versturen.

  Een burger kan bij de gemeente melden dat iemand anders ten onrechte op diens adres staat ingeschreven. 
  De gemeente doet daar dan onderzoek naar en kan concluderen dat deze andere persoon inderdaad niet meer op dat adres verblijft. 
  Wanneer tijdens de uitvoer van het onderzoek vastgesteld wordt dat een persoon niet meer woont op het adres waarop hij is ingeschreven in de BRP, 
  kan dit deel van het onderzoeksresultaat al worden opgenomen op de persoonslijst van de persoon. 
  
  Dit wordt gedaan door het zetten van aanduiding gegevens in onderzoek 089999.

  Hiermee wordt geregistreerd dat is vastgesteld dat een persoon niet (langer) op het adres verblijft waarop hij ingeschreven staat, 
  maar dat het onderzoek naar het (nieuwe) woonadres nog loopt.
  Hierdoor kunnen eventuele problemen voor betreffende persoon of voor andere (of nieuwe) bewoners van hetzelfde adres voorkomen worden.

  In de gebeurtenis wordt de identificatie - het A-nummer - van de betreffende persoon en het onderzoek in de data opgenomen.
  Daarnaast worden enkele gegevens van de verblijfplaats opgenomen:
  - datum aanvang adreshouding
  - adresseerbaar object identificatie van het adres (identificatiecode verblijfplaats)

  Achtergrond:
    Gegeven het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    * in gemeente 'Hengelo'
    En het adres 'Beursstraat_44_Hengelo'
    * in gemeente 'Hengelo'
    En de persoon 'Jan'
    * verblijft vanaf '14-04-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    * verblijft vanaf '19-06-2026' op het adres 'Beursstraat_44_Hengelo'

  Regel: Als is vastgesteld dat de persoon niet verblijft op het geregistreerde adres, heeft de gebeurtenis 'vastgesteld-verblijft-niet-op-adres' plaatsgevonden

    Scenario: Tijdens het onderzoek is vastgesteld dat de persoon niet verblijft op het adres
      Gegeven een onderzoek loopt naar het verblijf op adres 'Beursstraat_44_Hengelo' van 'Jan'
      Als het onderzoek naar het verblijf op adres 'Beursstraat_44_Hengelo' van 'Jan' is gewijzigd naar 'vastgesteld verblijft niet op adres'
      Dan is een 'vastgesteld-verblijft-niet-op-adres' gebeurtenis gepubliceerd

    Scenario: Bij de start van het onderzoek is al duidelijk dat de persoon niet verblijft op het adres
      Als een onderzoek is gestart met aanduiding 'vastgesteld verblijft niet op adres' over het verblijf op adres 'Beursstraat_44_Hengelo' van 'Jan'
      Dan is een 'verblijfplaats.onderzoek-gestart' gebeurtenis gepubliceerd
      En is een 'vastgesteld-verblijft-niet-op-adres' gebeurtenis gepubliceerd

  Regel: Bij gebeurtenistype 'vastgesteld-verblijft-niet-op-adres' wordt het A-nummer van de persoon meegeleverd en gegevens over het onderzoek en het betreffende verblijf
    Van de verblijfplaats worden alleen de volgende gegevens geleverd:
    - datum aanvang adreshouding dan wel datum aanvang verblijf buitenland
    - adresseerbaar object identificatie van het adres

    De gebeurtenis bevat gegevens over het onderzoek zoals ze geldig zijn na de wijziging.

    Scenario: Tijdens het onderzoek is vastgesteld dat de persoon niet verblijft op het adres
      Gegeven op '03-09-2026' een onderzoek is gestart naar het verblijf op adres 'Beursstraat_44_Hengelo' van 'Jan'
      Als op '28-09-2026' het onderzoek naar het verblijf op adres 'Beursstraat_44_Hengelo' van 'Jan' is gewijzigd naar 'vastgesteld verblijft niet op adres'
      Dan is een 'vastgesteld-verblijft-niet-op-adres' gebeurtenis gepubliceerd met de volgende data
      * het A-nummer 'Jan'
      * datum aanvang adreshouding '19-06-2026'
      * adresseerbaar object identificatie van het actuele adres 'Beursstraat_44_Hengelo'
      * aanduiding gegevens in onderzoek 'vastgesteld verblijft niet op adres'
      * datum ingang onderzoek '03-09-2026'
