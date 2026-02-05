# ADR 003: BRP API Gebeurtenissen maakt onderscheid tussen verschillende business events

## Status
Voorstel

## Context

Een gebeurtenis van een persoon die staat geregistreerd in de BRP is een _business event_. Een voorbeeld hiervan is de gebeurtenis "Intergemeentelijke Verhuizing".

Het beheren van een abonnement is ook een _business event_. Een voorbeeld hiervan is het registeren van abonnees.

Het bevragen van ongelezen gebeurtenissen is ook een _business event_. Een voorbeeld hiervan is het ophalen van gebeurtenissen.

### Uitbreiding

Subsystemen van de BRP API die worden aangesloten op de Event Store hebben er profijt van als er onderscheid  wordt gemaakt tussen verschillende type gebeurtenissen die plaatsvinden op personen die staan geregistreerd in de BRP. 

Een voorbeeld is BRP API Bewoning. Die kan aansluiten op gebeurtenis "Intergemeentelijke Verhuizing", zodat het bevragen van de databron te optimaliseren is.

Een ander voorbeeld is BRP API Gezag. Die kan aansluiten op gebeurtenis "Huwelijk", zodat de beslisboom uitgefaseerd kan worden.
