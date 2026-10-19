# language: nl
Functionaliteit: Gebeurtenis wanneer een onderzoek loopt naar de verblijfplaats en is vastgesteld dat de persoon niet meer op dit adres verblijft
  Als abonnee wil ik weten dat is vastgesteld dat een persoon niet meer op het adres verblijft,
  zodat ik een onderzoek kan starten naar de consequenties hiervan op mijn dienstverlening.

  De abonnee kan bijvoorbeeld naar aanleiding van deze gebeurtenis invordering (aanmaningen, deurwaarder) tijdelijk stopzetten en brieven niet versturen.

  Een burger kan bij de gemeente melden dat iemand anders ten onrechte op diens adres staat ingeschreven. 
  De gemeente doet daar dan onderzoek naar en kan concluderen dat deze andere persoon inderdaad niet meer op dat adres verblijft. 
  Wanneer tijdens de uitvoer van het onderzoek vastgesteld wordt dat een persoon niet meer woont op het adres waarop hij is ingeschreven in de BRP, 
  kan dit deel van het onderzoeksresultaat al worden opgenomen op de persoonslijst van de persoon. 
  
  Hiermee wordt geregistreerd dat is vastgesteld dat een persoon niet (langer) op het adres verblijft waarop hij ingeschreven staat, 
  maar dat het onderzoek naar het (nieuwe) woonadres nog loopt.
  Hierdoor kunnen eventuele problemen voor betreffende persoon of voor andere (of nieuwe) bewoners van hetzelfde adres voorkomen worden.

  In de gebeurtenis worden de volgende zaken opgenomen:
  - het burgerservicenummer van de persoon
  - datum vanaf wanneer de persoon op het betreffende adres verbleef
  - datum vanaf wanneer is vastgesteld dat de persoon niet op het adres verblijft

  Achtergrond:
    Gegeven het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    * in gemeente 'Hengelo'
    En de persoon 'Jan' is geregistreerd in de BRP
    * verblijft vanaf '14-04-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    En groep 'client' bij abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft gebeurtenistype 'nl.brp.vastgesteld-verblijft-niet-op-adres'
    En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'client'

  Regel: Bij gebeurtenis 'vastgesteld-verblijft-niet-op-adres' wordt het burgerservicenummer van de persoon geleverd

    Scenario: Er is vastgesteld dat de persoon niet meer op het geregistreerde adres verblijft
      Gegeven op '03-09-2026' een onderzoek is gestart naar het verblijf op adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo' van 'Jan'
      En op '17-09-2026' is een 'vastgesteld-verblijft-niet-op-adres' gebeurtenis gepubliceerd voor persoon 'Jan'
      Als gebeurtenissen worden gevraagd door abonnee 'jz' van afnemer 'Gemeente Amsterdam'
      Dan wordt een 'nl.brp.overlijden.onderzoek-gestart' gebeurtenis geleverd met de volgende data
      * het burgerservicenummer van 'Jan'
      * verblijfplaats.datumVan '14-04-2020'
      * verblijfplaats.verblijftNietOpAdresVanaf '03-09-2026'
