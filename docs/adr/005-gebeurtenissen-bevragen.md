# ADR005: Gebeurtenissen bevragen met behulp van een HTTP API

## Status
Voorstel

## Context

Afnemers van de BRP API willen op de hoogte worden gesteld van specifieke gebeurtenissen van personen aan wie zij diensten verlenen. BRP API Gebeurtenissen biedt een Abonnementen API waarmee afnemers kunnen aangeven over welke gebeurtenissen zij willen worden geïnformeerd. Het informeren van afnemers over de gebeurtenissen waarop hij zich heeft geabonneerd kan met behulp van:
- webhooks
- message brokers
- een HTTP API

## Beslissingen

Voor de MVP van BRP API Gebeurtenissen is ervoor gekozen om afnemers te informeren over gebeurtenissen via een HTTP API. Afnemers kunnen met de API controleren of er gebeurtenissen hebben plaatsgevonden waarin zij geïnteresseerd zijn.

## Consequenties

Voordelen:
- Een HTTP API maakt het eenvoudiger voor afnemers om de functionaliteit van BRP API Gebeurtenissen te beproeven. Hij kan zich met bestaande tooling zoals curl of Postman snel vertrouwd maken met BRP API Gebeurtenissen. Hij hoeft voor het beproeven geen client te bouwen die webhooks of message brokers ondersteunt, wat de drempel verlaagt om te beginnen met het gebruik van BRP API Gebeurtenissen.

Nadelen:
- Geen real-time notificaties: Een afnemer moet regelmatig verzoeken doen om te weten of er gebeurtenissen hebben plaatsgevonden waarin hij geïnteresseerd is. Als hij (near) real-time de gebeurtenissen wilt ontvangen, dan moet hij gaan pollen, wat kan leiden tot een verhoogde belasting van de API. Dit kan in de toekomst worden opgelost door het implementeren van webhooks of message brokers, maar voor de MVP is gekozen voor een eenvoudiger oplossing met een HTTP API.
- Wanneer een afnemer zich op veel gebeurtenissen abonneert, maar niet regelmatig controleert of er gebeurtenissen hebben plaatsgevonden waarin hij is geïnteresseerd, dan kan de payload van een verzoek groot worden. Dit kan worden opgelost door paginering te implementeren in de Bevragen API. Dit leidt wel tot extra ontwikkelingsinspanningen.


## Alternatieven
- Webhooks
- Message brokers
