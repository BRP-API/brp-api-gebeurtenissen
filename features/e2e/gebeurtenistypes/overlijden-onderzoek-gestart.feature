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
  