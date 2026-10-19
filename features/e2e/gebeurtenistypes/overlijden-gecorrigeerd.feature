# language: nl
Functionaliteit: Gebeurtenis wanneer het overlijden is gecorrigeerd
  Als abonnee wil ik weten dat het overlijden is gecorrigeerd,
  zodat ik onderzoek kan doen naar de consequenties voor mijn dienstverlening aan betrokkene(n).

  In de gebeurtenis worden de volgende zaken opgenomen:
  - het burgerservicenummer van de persoon
  
  De abonnee kan meer informatie desgewenst ophalen in de BRP-API door het overlijden op te vragen. De abonnee ontvangt dan de nieuwe actuele situatie van het overlijden.

  Achtergrond:
    Gegeven de persoon 'Jan' is geregistreerd in de BRP
    En het overlijden van 'Jan' is verwerkt
    En groep 'client' bij abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft gebeurtenistype 'nl.brp.overlijden.gecorrigeerd'
    En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'client'

  Regel: Bij gebeurtenis overlijden.gecorrigeerd wordt het burgerservicenummer van de persoon geleverd

    Scenario: Het overlijden is gecorrigeerd
      Gegeven er is een 'nl.brp.overlijden.gecorrigeerd' gebeurtenis gepubliceerd voor persoon 'Jan'
      Als gebeurtenissen worden gevraagd door abonnee 'jz' van afnemer 'Gemeente Amsterdam'
      Dan wordt een 'nl.brp.overlijden.gecorrigeerd' gebeurtenis geleverd met de volgende data
      * het burgerservicenummer van 'Jan'
