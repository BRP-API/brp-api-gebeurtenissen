# language: nl
@integratie
Functionaliteit: Registreer abonnee
  Als afnemer van BRP API Gebeurtenissen
  wil ik mijn interne afnemers (applicaties, processen) als abonnee kunnen registreren
  zodat ik de voor hen relevante gebeurtenissen niet zelf hoef te distribueren
  zodat mijn interne afnemers zelf abonnementen kunnen beheren

  Regel: Bij het registreren van een abonnee moet een unieke naam binnen de context van de afnemer worden opgegeven

    Scenario: Een afnemer registreert een abonnee met een unieke naam binnen de context van de afnemer
      Gegeven de afnemer 'Gemeente Den Haag'
      * is geregistreerd als abonnee 'szw' van BRP API Gebeurtenissen
      Als de afnemer 'Gemeente Den Haag' zich registreert als abonnee 'JZ'
      Dan is de response '201 Created'

    Scenario: Een afnemer registreert een abonnee met een niet unieke naam binnen de context van de afnemer
      Gegeven de afnemer 'Gemeente Den Haag'
      * is geregistreerd als abonnee 'szw' van BRP API Gebeurtenissen
      Als de afnemer 'Gemeente Den Haag' zich registreert als abonnee 'szw'
      Dan is de response '409 Conflict' met de volgende velden
      * 'detail' met tekst 'Uw verzoek kan niet worden uitgevoerd omdat u al als abonnee geregistreerd bent.'

    Scenario: Twee afnemers registreren zich met dezelfde abonneenaam
      Gegeven de afnemer 'Gemeente Rotterdam'
      * is geregistreerd als abonnee 'szw' van BRP API Gebeurtenissen
      En de afnemer 'Gemeente Den Haag'
      * is niet geregistreerd als abonnee van BRP API Gebeurtenissen
      Als de afnemer 'Gemeente Den Haag' zich registreert als abonnee 'szw'
      Dan is de response '201 Created'
