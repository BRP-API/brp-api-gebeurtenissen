# ADR 006: BRP API Gebeurtenissen maakt onderscheid tussen verschillende business events

## Status
Voorstel

## Context

_Domain Events_ zijn events die aangeven dat er iets heeft plaatsgevonden binnen de context van het domein. Bijvoorbeeld in de context van het abonnement is het mogelijk dat er een event "AbonnementGeregistreerd" heeft plaatsgevonden.

_Business Events_ is een bredere term die zowel gebruikt kan worden om _domain events_ aan te duiden, maar kan ook andere events omvatten die niet binnen het _core domain_ vallen. Bijvoorbeeld in de context van de BRP API Gebeurtenissen is het mogelijk dat er een event "IntergemeentelijkVerhuisd" heeft plaatsgevonden, wat niet direct binnen het domein van abonnementen valt.

Een gebeurtenis van een persoon die staat geregistreerd in de BRP is een _business event_. Een voorbeeld hiervan is het event "IntergemeentelijkVerhuisd".

Het beheren van een abonnement is ook een _domain event_ binnen de context van abonnementen. Bijvoorbeeld, het event "AbonneeGeregistreerd".

Het bevragen van ongelezen gebeurtenissen is ook een _domain event_ binnen de context van het bevragen. Bijvoorbeeld, het event "GebeurtenisBevraagd".

### Uitbreiding

Subsystemen van de BRP API die worden aangesloten op de Event Store hebben er profijt van als er onderscheid wordt gemaakt tussen verschillende typen gebeurtenissen die plaatsvinden op personen die staan geregistreerd in de BRP. 

Een voorbeeld is BRP API Bewoning. Die kan aansluiten op event "IntergemeentelijkVerhuisd", zodat het bevragen van de databron te optimaliseren is.

Een ander voorbeeld is BRP API Gezag. Die kan aansluiten op event "Gehuwd", zodat de beslisboom uitgefaseerd kan worden.
