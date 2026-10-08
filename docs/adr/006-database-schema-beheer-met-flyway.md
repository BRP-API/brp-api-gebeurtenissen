# ADR006: database schema beheer met behulp van Flyway

## Status
Voorstel

## Context

Een nieuwe PostgreSQL database is aangemaakt voor BRP API Gebeurtenissen. Deze database dient twee doelen. Ten eerste fungeert het als _projectie database_: opslag bieden voor BRP API Gebeurtenissen om projecties in op te slaan. Ten tweede ondersteunt het interne mechanismes van Axon Framework, bijvoorbeeld opslag bieden voor streaming tokens.

Het DBA team heeft aan ons gevraagd om een tabel aan te maken voor het opslaan van database schema veranderingen. Aan de hand van de tabel kunnen schemas worden geversioneerd.

Een manier om aanpassingen aan database schema vast te leggen is met behulp van gestandaardiseerde tools. Zo'n tool geeft je de mogelijkheid om toekomstige migraties gecontroleerd te laten verlopen. In de Java wereld zijn er twee beschikbaar: Flyway en Liquibase. 

## Beslissing

Er is gekozen voor Flyway om het beheer van de database schema te regelen.

## Consequenties

Voordelen:
- Lage leer curve. De migratie scripts zijn geschreven in SQL en de naming scheme voor de bestandsnamen is vrij eenvoudig. De bestandsnamen zijn belangrijk voor zowel controles op integriteit als de volgordelijkheid van de uit te voeren migratie scripts. Voor de zekerheid biedt het ook een validatie op bestandsnamen aan om teams op het rechte pad te houden.
- Integriteit en voorspelbaarheid. Bij het opstarten valideert Flyway dat de schema in de database overeenkomt met de schema die de applicatie verwacht. Dit gebeurt op basis van checksums van de uitgevoerde migratie scripts. Bij een succesvolle startup weet je zeker dat de database schema migratie goed is verlopen
- Goede integratie met Spring Boot en CI/CD. Het wordt veelvuldig gebruikt in combinatie met Spring Boot. Dankzij Docker is het ook goed te gebruiken in Ci/CD pipelines.
- Open source.

Nadelen:
- Gebrekkige multi-engine ondersteuning. Elke dialect krijgt zijn eigen migratie scripts en versionering wanneer meerdere database dialecten ondersteunt moet worden. Hierdoor ontstaat veel duplicate bestanden die soms maar licht afwijken van elkaar. 
- Sommige features zijn pas beschikbaar in de commerciële versie.
- Applicatie vereist schrijfrechten om de database schema aan te kunnen passen. Als het toekennen van schrijfrechten onmogelijk is, dan moet het DBA team de database migratie scripts toepassen met behulp van de Flyway CLI. De CLI vult automatisch de tabel `flyway_schema_history` in met bijbehorende checksum per uitgevoerde script.
- De validatie bij het opstarten valideert de database schema op basis van bestandchecksums. Hierdoor faalt een validatie als ook maar iets wijzigt aan een bestand, zoals een extra spatie. Dit is normaliter geen probleem wanneer de applicatie zowel de migratie als de validatie uitvoert. Als het DBA team verantwoordelijk wordt voor het uitvoeren van de migratie scripts, dan moet de bestandsoverdracht wel secuur gebeuren om productiefalen te voorkomen. 

## Alternatieven

### Liquibase

Voordelen:
- Multi-engine ondersteuning. Write once, migrate everywhere.
- Integriteit en voorspelbaarheid.
- Goede integratie met Spring Boot en CI/CD.
- Open source.

Nadelen:
- Hogere leercurve. Scripts zijn veelal geschreven in JSON/YAML/XML. SQL is ook beschikbaar via de "Formatted SQL" feature.
- Sommige features zijn pas beschikbaar in de commerciële versie.

### Zonder tooling

Voordelen:
- Geen leercurve; simpelere development tool chain.

Nadelen:
- Database schema kan na verloop van tijd afwijken ("drift"), wat mogelijk niet gelijk wordt opgemerkt.
