# language: nl
Functionaliteit: Gebeurtenis wanneer er een onderzoek gestart is naar het overlijden
  Als abonnee wil ik weten dat een onderzoek naar het overlijden is gestart,
  zodat ik een onderzoek kan starten naar de consequenties van dit onderzoek op mijn dienstverlening.

  In de gebeurtenis wordt burger van de betreffende persoon en het onderzoek in de data opgenomen.

  In de gebeurtenis worden de volgende zaken opgenomen:
  - het burgerservicenummer van de persoon

  Aan de abonnee wordt geen data meegestuurd waaruit af te leiden is wat exact onderzocht wordt, omdat we niet weten voor welke gegevens de abonnee geautoriseerd is.
  De abonnee kan meer informatie over het onderzoek desgewenst ophalen in de BRP-API, met enkele kanttekeningen:
  - Als het onderzoek alleen gaat over een gegeven waar de abonnee niet voor geautoriseerd is, kan de abonnee het onderzoek niet zien in de BRP-API
  - Als aanvullende gegevens over het onderzoek worden gevraagd nadat het onderzoek al is afgerond, kan de abonnee het onderzoek niet meer zien in de BRP-API

  Achtergrond:
    Gegeven de persoon 'Jan' is geregistreerd in de BRP
    En het overlijden van 'Jan' is verwerkt
    En groep 'client' bij abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft gebeurtenistype 'nl.brp.overlijden.onderzoek-gestart'
    En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'client'

  Regel: Bij gebeurtenis overlijden.onderzoek-gestart wordt het burgerservicenummer van de persoon geleverd

    Scenario: Een onderzoek naar het overlijden is gestart
      Gegeven er is een 'nl.brp.overlijden.onderzoek-gestart' gebeurtenis gepubliceerd voor persoon 'Jan'
      Als gebeurtenissen worden gevraagd door abonnee 'jz' van afnemer 'Gemeente Amsterdam'
      Dan wordt een 'nl.brp.overlijden.onderzoek-gestart' gebeurtenis geleverd met de volgende data
      * het burgerservicenummer van 'Jan'
