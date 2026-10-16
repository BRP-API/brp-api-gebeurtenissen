# language: nl
Functionaliteit: Gebeurtenis wanneer de verblijfplaats is gecorrigeerd
  Als abonnee wil ik weten dat een verhuizing is gecorrigeerd,
  zodat ik onderzoek kan doen naar de consequenties voor mijn dienstverlening aan betrokkene(n).

  In de gebeurtenis worden de volgende zaken opgenomen:
  - het burgerservicenummer van de persoon
  - datum vanaf wanneer de persoon op het gecorrigeerde adres verbleef (dit is de datum aanvang die vóór de correctie geregistreerd stond)
  
  Aan de abonnee wordt in de gebeurtenis de onjuiste datum aanvang geleverd, zodat de abonnee de gebeurtenis kan relateren aan een verblijf.
  Aan de abonnee wordt geen data meegestuurd waaruit af te leiden is wat exact gecorrigeerd is, omdat we niet weten voor welke gegevens de abonnee geautoriseerd is.

  De abonnee kan meer informatie over de correctie desgewenst ophalen in de BRP-API personen bevragen of met de BRP-API verblijfplaatshistorie met bijvoorbeeld peildatum gelijk aan de geleverde datum aanvang, met enkele kanttekeningen:
  - Als de correctie alleen gaat over een gegeven waar de abonnee niet voor geautoriseerd is, kan de abonnee in de BRP-API niet zien wat er gewijzigd is
  - Mogelijk moet de abonnee meer verblijfplaatshistorie vragen dan alleen op peildatum van de datum aanvang om een compleet beeld te krijgen van de verblijfplaats(en) na correctie.
