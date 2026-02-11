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
- Beveiligen van een HTTP API is eenvoudiger dan het beveiligen van webhooks of message brokers. Afnemers kunnen zich authenticeren met behulp van de bestaande authenticatiemechanismen (OAuth 2.0) van de BRP API. Ook voor het protocolleren van een Gebeurtenissen Bevragen verzoek kan dezelfde protocollering mechanisme van de BRP API worden gebruikt.
- Het is makkelijker om nieuwe functionaliteit toe te voegen aan een HTTP API, zoals het opnieuw kunnen opvragen van gebeurtenissen die al eerder zijn opgevraagd (replay functionaliteit).

Nadelen:
- Geen real-time notificaties: Een afnemer moet regelmatig verzoeken doen om te weten of er gebeurtenissen hebben plaatsgevonden waarin hij geïnteresseerd is. Als hij (near) real-time de gebeurtenissen wilt ontvangen, dan moet hij gaan pollen, wat kan leiden tot een verhoogde belasting van de API. Dit kan in de toekomst worden opgelost door het implementeren van webhooks of message brokers, maar voor de MVP is gekozen voor een eenvoudiger oplossing met een HTTP API.
- Wanneer een afnemer zich op veel gebeurtenissen abonneert, maar niet regelmatig controleert of er gebeurtenissen hebben plaatsgevonden waarin hij is geïnteresseerd, dan kan de payload van een verzoek groot worden. Dit kan worden opgelost door paginering te implementeren in de Bevragen API. Dit leidt wel tot extra ontwikkelingsinspanningen.
- Er moet extra functionaliteit worden geïmplementeerd om tijdelijk bij te houden welke gebeurtenissen een afnemer moet ontvangen en welke gebeurtenissen een afnemer al heeft ontvangen. Dit is voor een goede performance van de Bevragen API noodzakelijk. We willen niet bij elk verzoek een complexe query uitvoeren om te bepalen welke gebeurtenissen een afnemer moet ontvangen.

## Alternatieven

### Webhooks

Voordelen:
- Real-time notificaties: Afnemers ontvangen direct een notificatie/de gebeurtenis payload wanneer de gebeurtenis heeft plaatsgevonden.
- Geen polling.

Nadelen:
- Afnemers moeten een endpoint implementeren waarop zij notificaties/gebeurtenis payloads willen ontvangen.
- Afnemers moeten om kunnen gaan met varierende belasting van hun webhook endpoints.
- Afnemers moeten hun webhook endpoints beveiligen tegen ongeautoriseerde toegang en misbruik.
- BRP API Gebeurtenissen moet kunnen omgaan met tijdelijke onbeschikbaarheid van het endpoint van een afnemer (retry mechanisme).
- Geen standaard replay functionaliteit. Er moet extra functionaliteit worden geïmplementeerd (API) om afnemers in staat te stellen om aan te geven dat zij eerder ontvangen gebeurtenissen opnieuw willen ontvangen.

### Message brokers

Voordelen:
- durable storage. Queues kunnen worden gebruikt om voor (een abonnee van) een afnemer bij te houden welke gebeurtenissen hij moet ontvangen. Bij message brokers kan vaak een retentieperiode worden ingesteld, zodat reeds ontvangen gebeurtenissen na de retentieperiode automatisch worden verwijderd. Hierdoor kan de opslag efficiënt worden beheerd.
- bijhouden van reeds ontvangen gebeurtenissen. Message brokers bieden vaak standaard deze functionaliteit.
- replay functionaliteit. Doordat message brokers bij kunnen houden welke berichten/gebeurtenissen een afnemer al heeft ontvangen, kunnen zij ook standaard replay functionaliteit bieden.

Nadelen:
- Afnemers moeten een message broker specifieke client implementeren. Wordt er bijvoorbeeld gebruik gemaakt van Apache Kafka, dan moeten afnemers een Kafka client implementeren. Een mogelijke oplossing hiervoor is om de message broker te verbergen achter een HTTP API.

