# Woordenlijst

## Event Driven Systeem

Systeem die met andere systemen communiceert door gebeurtenissen (events) te publiceren en te consumeren.

## Event Sourcing

Veranderingen aan de toestand van een systeem worden vastgelegd als een reeks gebeurtenissen (events).
De actuele toestand van het systeem kan worden opgebouwd door het 'afspelen van' de gebeurtenissen.
De actuele toestand van een entiteit beheerd in een event-sourced systeem kan worden opgebouwed door het afspelen van de gebeurtenissen vastgelegd voor die entiteit.

## Event

Vastlegging van een wijziging in de toestand van een entiteit.
Vastgelegd:
- de wijziging als dat het al heeft plaatsgevonden. v.b. verhuisd
- de data horende bij de wijziging. v.b. wie is verhuisd, wanneer en naar welk adres
- wanneer heeft de wijziging plaatsgevonden
- id van de event

## Projection

Een datastructuur dat wordt gecreeërd door het verwerken van een reeks gebeurtenissen.
De datastructuur kan worden gepersisteerd in database tabellen.

## Notificatie

Signaal dat een gebeurtenis heeft plaatsgevonden.
Een notificatie is een kopie van een event exclusief de data horende bij de wijziging.
Vastgelegd:
- de wijziging als dat het al heeft plaatsgevonden. v.b. verhuisd
- wanneer heeft de wijziging plaatsgevonden
- id van de event
