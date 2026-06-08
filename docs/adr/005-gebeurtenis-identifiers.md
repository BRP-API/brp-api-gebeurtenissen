# ADR 005 - Gebeurtenis Identifiers

## Status
Concept

## Context
Voor één persoon kan in de BRP (inclusief RNI) meerdere persoonslijsten voorkomen. Ook kan het voorkomen dat een persoon een actieve persoonslijst heeft in zowel de BRP als in de PIVA van Bonaire, Sint Eustatius of Saba. Zo'n persoon heeft hierdoor meerdere persoonslijsten (verschillend pl_id) met dezelfde/verschillend A-nummer/burgerservicenummer.

Dubbelopnames worden teruggebracht tot één persoonslijst. Dit wordt gedaan door middel van actualiserings- en correctieprocedures die kunnen worden uitgevoerd op zowel actuele als historische gegevens. Wanneer het A-nummer en burgerservicenummer op de twee persoonslijsten niet hetzelfde zijn, dan wordt dit gelijkgetrokken.

Een situatie waar dubbelopnames ontstaan is bijvoorbeeld wanneer een persoon verhuist naar een andere gemeente of naar het buitenland en de persoonslijst in de vertrekgemeente wordt niet verwijderd. (Aanname: de persoon heeft in dit geval één persoonslijst in de BRP)
Wanneer de dubbelopnames worden teruggebracht tot één persoonslijst en er staan gegevens op de persoonslijst bij de vertrekgemeente die niet op de persoonslijst bij de nieuwe gemeente staan, dan worden deze gegevens doorgegeven aan de nieuwe gemeente (Aanname: deze gegevens kunnen in de persoonslijst bij de nieuwe gemeente historische gegevens zijn geworden, met andere woorden, ook historische gegevens kunnen worden geactualiseerd en dit kan op een later moment worden opgenomen dan het actuele variant van dat gegeven. Vraag: hoe moet er worden omgegaan met dit soort wijzigingen? Moeten gebeurtenissen die gerelateerd zijn aan dit soort gegevens worden gemeld aan afnemers die geabonneerd zijn op deze gebeurtenissen?).

De classificatiemodule gebruikt het A-nummer om aan te geven bij welke persoon een gebeurtenis heeft plaatsgevonden. Omdat meerdere persoonslijsten hetzelfde A-nummer kunnen hebben, kan het A-nummer niet worden gebruikt om aan te geven bij welke persoon een gebeurtenis heeft plaatsgevonden.

## Besluit
De pl_id moet bij het publiceren van een gebeurtenis met de gebeurtenissen publiceren service worden meegegeven. De pl_id is uniek en kan worden gebruikt om aan te geven bij welke persoon/persoonslijst een gebeurtenis heeft plaatsgevonden.

## Bronnen
- [HUP - Dubbelinschrijving](https://rvig.nl/hup/dubbelinschrijving)
- [HUP - Wijzigen BSN](https://www.rvig.nl/hup/wijzigen-bsn)
- [Axon - Event Transformation](https://docs.axoniq.io/axon-server-reference/v2026.0/axon-server/administration/event-transformation/)
- [Event Sourcing and Post/Pre Dated Transactions](https://gregfyoung.wordpress.com/2014/03/02/event-sourcing-and-postpre-dated-transactions/)