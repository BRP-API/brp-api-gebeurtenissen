# language: nl
Functionaliteit: Gebeurtenis wanneer de verblijfplaats is gecorrigeerd
  Als abonnee wil ik weten dat een verblijfplaats is gecorrigeerd,
  zodat ik onderzoek kan doen naar de consequenties voor mijn dienstverlening aan betrokkene(n).

  In de gebeurtenis worden de volgende zaken opgenomen:
  - het burgerservicenummer van de persoon
  - datum vanaf wanneer de persoon op het gecorrigeerde adres verbleef (dit is de datum aanvang die vóór de correctie geregistreerd stond)
  
  Aan de abonnee wordt in de gebeurtenis de onjuiste datum aanvang geleverd, zodat de abonnee de gebeurtenis kan relateren aan een verblijf.
  Aan de abonnee wordt geen data meegestuurd waaruit af te leiden is wat exact gecorrigeerd is, omdat we niet weten voor welke gegevens de abonnee geautoriseerd is.

  De abonnee kan meer informatie over de correctie desgewenst ophalen in de BRP-API personen bevragen of met de BRP-API verblijfplaatshistorie met bijvoorbeeld peildatum gelijk aan de geleverde datum aanvang, met enkele kanttekeningen:
  - Als de correctie alleen gaat over een gegeven waar de abonnee niet voor geautoriseerd is, kan de abonnee in de BRP-API niet zien wat er gewijzigd is
  - Mogelijk moet de abonnee meer verblijfplaatshistorie vragen dan alleen op peildatum van de datum aanvang om een compleet beeld te krijgen van de verblijfplaats(en) na correctie.

  Achtergrond:
    Gegeven het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    * in gemeente 'Hengelo'
    En de persoon 'Jan' is geregistreerd in de BRP
    * verblijft vanaf '14-04-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    En groep 'client' bij abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft gebeurtenistype 'nl.brp.verblijfplaats.gecorrigeerd'
    En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'client'

  Regel: Bij gebeurtenis 'verblijfplaats.gecorrigeerd' wordt het burgerservicenummer van de persoon geleverd

    Scenario: Een onderzoek naar het overlijden is gestart
      Gegeven op '17-09-2026' is een 'verblijfplaats.gecorrigeerd' gebeurtenis gepubliceerd voor persoon 'Jan'
      Als gebeurtenissen worden gevraagd door abonnee 'jz' van afnemer 'Gemeente Amsterdam'
      Dan wordt een 'nl.brp.overlijden.onderzoek-gestart' gebeurtenis geleverd met de volgende data
      * het burgerservicenummer van 'Jan'
      * verblijfplaats.datumVan '14-04-2020'
