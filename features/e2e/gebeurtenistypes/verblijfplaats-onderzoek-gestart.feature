# language: nl
Functionaliteit: Gebeurtenis wanneer er een onderzoek gestart is naar de verblijfplaats
  Als abonnee wil ik weten dat een onderzoek naar de verblijfplaats is gestart,
  zodat ik een onderzoek kan starten naar de consequenties van dit onderzoek op mijn dienstverlening.

  Als abonnee wil ik weten als het adres van een debiteur in onderzoek wordt genomen, 
  want dan moeten we de invordering (tijdelijk) stoppen. 
  Waarom is dat? Antwoord: liever geen deurwaarder sturen als iemand er waarschijnlijk niet woont, en ook geen brieven meer sturen.

  In de gebeurtenis worden de volgende zaken opgenomen:
  - het burgerservicenummer van de persoon
  - datum vanaf wanneer de persoon op het betreffende adres verblijft

  De datum aanvang wordt geleverd, zodat de abonnee de gebeurtenis kan relateren aan een verblijf.
  Aan de abonnee wordt geen data geleverd waaruit af te leiden is waar het onderzoek over gaat, omdat we niet weten voor welke gegevens de abonnee geautoriseerd is.

  De abonnee kan meer informatie over het onderzoek desgewenst ophalen in de BRP-API personen bevragen of met de BRP-API verblijfplaatshistorie met bijvoorbeeld peildatum gelijk aan de geleverde datum van, met enkele kanttekeningen:
  - Als het onderzoek alleen gaat over een gegeven waar de abonnee niet voor geautoriseerd is, kan de abonnee het onderzoek niet zien in de BRP-API
  - Als informatie over het onderzoek wordt gevraagd nadat het onderzoek al is afgerond, kan de abonnee het onderzoek niet meer zien in de BRP-API
  