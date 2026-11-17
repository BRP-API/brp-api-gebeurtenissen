# language: nl
Functionaliteit: Traceren van een aanroep naar events in Axon Server

  Als functioneel beheerder, technisch beheerder of tester
  wil ik kunnen terugvinden welke API-aanroep tot een event in Axon Server heeft geleid
  zodat ik bij incidenten, analyses en testen het hele pad kan volgen: van de aanroep,
  via de logregels, naar de commands en events in Axon Server.

  Elke aanroep krijgt één tracekenmerk. Dat kenmerk is:
  - de correlationId in de metadata van de commands en events in Axon
  - de trace.id in de ECS-log
  - de Request-Id in de response-header

  Regel: Een geldige Request-Id (UUID) wordt het tracekenmerk van een aanroep

    Scenario: Een afnemer registreert een abonnee
      Als de afnemer 'Gemeente Amsterdam' de abonnee 'jz' registreert
      En de aanroep bevat een 'Request-ID' header met waarde 'f100bca1-4c42-488a-a0c1-6da4c33729f8'
      Dan is een 'AbonneeGeregistreerd' gebeurtenis gepubliceerd met in de metadata een veld 'correlationId' met waarde 'f100bca1-4c42-488a-a0c1-6da4c33729f8'

  Regel: Een Request-Id wordt bij het afhandelen van een aanroep gegenereerd als een aanroep geen of een ongeldige Request-Id bevat
