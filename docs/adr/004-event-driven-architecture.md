ADR0004: Event-Driven Architecture for BRP API Gebeurtenissen

# Status
Voorstel

## Context
Afnemers van de BRP API willen op de hoogte worden gesteld van specifieke gebeurtenissen van personen aan wie zij diensten verlenen. Deze gebeurtenissen zijn bijvoorbeeld intergemeentelijk verhuisd, geëmigreerd en overleden. Systemen van afnemers hoeven dan niet meer regelmatig BRP API Personen te bevragen om te bepalen of de specifieke gebeurtenissen hebben plaatsgevonden.

De sub-systemen van de BRP API zijn ook geïnteresseerd in gebeurtenissen van personen die geregistreerd staan in de BRP. BRP API Bewoningen is bijvoorbeeld een BRP API sub-systeem dat kan worden geoptimaliseerd door gebruik te maken van gebeurtenissen van personen in de BRP. Op dit moment wordt bij elke bewoning bevraging met een complexe query en complexe logica bepaald welke personen (mogelijke) bewoners zijn van een adresseerbaar object in de gevraagde periode. De complexe query en logica zorgen ervoor dat er veel meer data uit de database moet worden opgehaald en zorgen ervoor dat het vaak veel langer duurt om de response voor een response te genereren.
Wanneer BRP API Bewoningen kan worden gedreven door gebeurtenissen, dan hoeft de complexe logica alleen te worden uitgevoerd wanneer specifieke gebeurtenissen hebben plaatsgevonden. Hierdoor hoeft er geen data uit de database te worden opgehaald omdat de relevante data al in de gebeurtenis zit. De bewoning bepaling kan vervolgens geoptimaliseerd worden gepersisteerd in bijvoorbeeld een database zodat met een simpele query de bewoners van een adresseerbaar object in een periode kunnen worden opgehaald.

## Beslissingen
De Event-Driven Architecture (EDA) is de architectuur stijl die het beste past bij de behoeften van BRP API Gebeurtenissen. Binnen EDA staan gebeurtenissen centraal. Sub-systemen binnen een EDA communiceren met elkaar door middel van het publiceren en consumeren van gebeurtenissen. De sub-systemen zijn losjes gekoppeld, wat betekent dat ze onafhankelijk van elkaar kunnen worden ontwikkeld, gedeployed en geschaald.

![Event Model](./event-model.png)