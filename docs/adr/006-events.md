# ADR 006: BRP API Gebeurtenissen maakt onderscheid tussen verschillende typen events

## Status
Voorstel

## Context

### Definities

_Domain Events_ zijn events die aangeven dat er iets is veranderd binnen de context van het domein. Bijvoorbeeld in de context van het abonnement is het mogelijk dat er een event "AbonnementGeregistreerd" heeft plaatsgevonden.

_Integration Events_ is een term die gebruikt kan worden om aanpassingen over meerdere contexten aan te duiden. Bijvoorbeeld in de context van de BRP API Gebeurtenissen als er een event "IntergemeentelijkVerhuisd" heeft plaatsgevonden, dan kan dit event worden gebruikt in meerdere contexten, zoals Abonnementen en BRP API Gezag.

Een gebeurtenis van een persoon die staat geregistreerd in de BRP is een _integration event_. Een voorbeeld hiervan is het event "IntergemeentelijkVerhuisd".

Het beheren van een abonnement is ook een _domain event_ binnen de context van abonnementen. Bijvoorbeeld, het event "AbonneeGeregistreerd".

Het bevragen van ongelezen gebeurtenissen is ook een _domain event_ binnen de context van het bevragen. Bijvoorbeeld, het event "GebeurtenisBevraagd".

### Uitbreiding

Subsystemen van de BRP API die worden aangesloten op de Event Store hebben er profijt van als er onderscheid wordt gemaakt tussen verschillende typen gebeurtenissen die plaatsvinden op personen die staan geregistreerd in de BRP. 

Een voorbeeld is BRP API Bewoning. Die kan aansluiten op event "IntergemeentelijkVerhuisd", zodat het bevragen van de databron te optimaliseren is.

Een ander voorbeeld is BRP API Gezag. Die kan aansluiten op event "Gehuwd", zodat de beslisboom uitgefaseerd kan worden.


## Bronnen

- [EDA Event Types](https://www.shawnewallace.com/2025-07-08-eda-event-types/)