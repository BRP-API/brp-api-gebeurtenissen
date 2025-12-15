# ADR 002: BRP API Gebeurtenissen gebruikt Axon Server als Event Store en Event Bus/Message Broker

## Status
Voorstel

## Context

Afnemers van de BRP API willen zich kunnen abonneren op specifieke gebeurtenissen van personen die staan geregistreerd in de BRP. Hierdoor hoeven zij de BRP API niet te pollen en aan de hand van de opgehaalde gegevens te bepalen of er specifieke gebeurtenissen, zoals verhuizing naar een andere gemeente of emigratie, hebben plaatsgevonden bij personen aan wie zij diensten verlenen.

Ook is gebleken dat sub-systemen van de BRP API profijt zouden hebben als wijzigingen in de BRP werden geregistreerd als gebeurtenissen. De gezagsbepaling in de gezagsmodule kon met procenten worden verbeterd door te bepalen welke gebeurtenis heeft geleid tot een wijziging aan een persoon en dan aan de hand van de volgorde van de gebeurtenissen het gezag voor de persoon te bepalen.

BRP API Bewoning is ook een sub-systeem dat zou kunnen worden verbeterd wanneer verblijfplaats gerelateerde wijzigingen als gebeurtenissen worden vastgelegd. Nu wordt voor elke bewoning bevraging de bewoning van het bevraagde adres opnieuw bepaald, terwijl dat alleen hoeft te gebeuren wanneer er personen in/uit verhuizen op een adres.

En wanneer alle wijzigingen in de BRP registratie worden vastgelegd als gebeurtenissen, dan kan voor elke persoon in de registratie zijn actuele gegevens op een moment in tijd worden bepaald door alle gebeurtenissen van de betreffende persoon tot op dat moment in tijd af te spelen.

Een architectuur stijl die kan worden toegepast voor bovenstaande requirements is Event Driven Architecture (EDA). Ook heeft het toepassen van EDA als essentieel voordeel dat wijzigingen aan het EDA systeem zonder impact kan plaatsvinden. Nieuwe gebeurtenis typen kunnen worden gepubliceerd zonder aanpassingen aan bestaande abonnees en nieuwe abonnees kunnen zonder performance impact worden gekoppeld aan het EDA systeem. 

## Beslissingen

Om de bovenstaande requirements te realiseren moet BRP API Gebeurtenissen gebruik maken van een Event Store voor het langdurig vastleggen van gebeurtenissen en van een Event Bus/Message Broker om gebeurtenissen te kunnen routeren naar interne/externe abonnees.

Omdat het implementeren en beheren van een Event Store en Message Broker geen kerntaken zijn van de RvIG, is er gekeken naar bestaande Event Store en Message Broker producten.

Voor BRP API Gebeurtenissen is om de volgende redenen gekozen voor Axon Server:
- Axon Server biedt out-of-the-box Event Store en Message Routing functionaliteit. Hierdoor hoeft er maar één product te worden gekocht en te worden onderhouden.
- De Event Store van Axon Server kan zonder performance verlies oneindig worden opgeschaald.
- Axon Framework (Open-Source Java Framework voor Event Sourcing) integreert naadloos met Axon Server. Hierdoor kan Axon Framework worden gebruikt om CQRS en Event-Souring (EDA gerelateerde design patronen) toe te passen in nieuwe/bestaande JAVA/Kotlin applicaties.
- Axon Server biedt een Query Language voor het query-en van opgeslagen gebeurtenissen
- Axon Server biedt integratie APIs om applicaties geschreven in een ander programmeertaal dan JAVA/Kotlin te koppelen.