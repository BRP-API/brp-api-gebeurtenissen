# ADR 007: Migreren naar BRP API Gebeurtenissen

## Status

Concept

## Context

Wanneer een abonnee van een afnemer van de BRP API zijn systemen wil migreren naar het gebruik van de BRP API Gebeurtenissen, dan moet de abonnee voor de personen die hij in zijn systemen bijhoudt een abonnement nemen bij BRP API Gebeurtenissen met behulp van de AbonneerPersoonOpGroep command van de /abonnees/{abonneenaam}/abonnementen endpoint. Met deze command kan op één persoon tegelijk een abonnement op een groep van gebeurtenistypes worden genomen. Een abonnee volgt in de praktijk heel veel personen. Dit kunnen tien duizenden tot zelfs miljoenen personen zijn. Het lijkt daarom niet praktisch om bij het migreren naar BRP API Gebeurtenissen om voor elke persoon één voor één een abonnement te nemen. Dit leidt tot heel veel requests tijdens een migratie.

## Mogelijke oplossingen

### 1. Bestaande AbonneerPersoonOpGroep command gebruiken

De AbonneerPersoonOpGroep command en de abonnementen endpoint worden ongewijzigd gebruikt. De rate limit en concurrency limit moet voor de AbonneerPersoonOpGroep command worden bepaald zodat een abonnee hiermee rekening kan houden bij het implementeren van zijn migratieproces.

Voordelen:
- Er hoeft geen nieuwe abonneer functionaliteit te worden ontwikkeld.
- Het falen van een abonneer aanroep heeft geen gevolgen voor de andere abonneer aanroepen.

Nadelen:
- Een optimale rate limit en concurrency limit moet worden bepaald zodat BRP API Gebeurtenissen normaal blijft functioneren tijdens een migratie. Er moet rekening worden gehouden dat meerdere abonnees bij dezelfde of verschillende afnemers een migratie kunnen starten. Dit kan complex zijn.
- Een abonnee moet zelf een migratieproces implementeren dat rekening houdt met de rate limit en concurrency limit van de abonnementen endpoint. Dit kan complex zijn.

### 2. Synchroon bulk abonneren met een nieuwe command (AbonneerPersonenOpGroep)

Met de AbonneerPersonenOpGroep command kan in één aanroep voor meerdere personen een abonnement worden genomen. Ook voor deze command moet de rate limit en concurrency limit worden bepaald zodat een abonnee hiermee rekening kan houden bij het implementeren van zijn migratieproces.

Voordelen:
- Het aantal aanroepen dat nodig is om te migreren wordt sterk verminderd.
- Een abonnee krijgt in de response van een bulk abonneren aanroep het resultaat (voor welke personen en om welke reden is het niet gelukt om een abonnement aan te maken) van de verwerking. 

Nadelen:
- Er moet nieuwe abonneer functionaliteit worden ontwikkeld. Wanneer het abonneren van een persoon in de bulk aanroep faalt, dan moet dit geen gevolgen hebben voor de andere personen in de bulk aanroep. Wanneer voor één of meerdere personen het abonneren niet is gelukt, dan moet dit samen met de reden worden teruggegeven in de response. Er moet daarom ook worden gezorgd dat het aantal personen dat in een bulk aanroep wordt meegestuurd is niet te groot is om te voorkomen dat de abonnee een timeout krijgt bij een bulk aanroep.

### 3. Asynchroon bulk abonneren met een nieuwe command (AbonneerPersonenOpGroep)

De AbonneerPersonenOpGroep command kan asynchroon worden uitgevoerd. De abonnee krijgt voor een aanroep een identifier terug waarmee hij de status en resultaten van de bulk aanroep kan opvragen via een specifieke endpoint. Omdat het abonneren asynchroon wordt uitgevoerd, kan een abonnee alle personen (die hij voor dezelfde groep wil abonneren) in één aanroep meegeven.

Voordelen:
- Het aantal aanroepen dat nodig is kan worden teruggebracht tot één aanroep of tot het aantal groepen dat de abonnee heeft gedefinieerd.
- Een abonnee hoeft in principe geen rekening te houden met de rate limit en concurrency limit van de abonnementen endpoint. Deze moet wel worden bepaald om er voor te zorgen dat er onbedoeld veel bulk aanroepen wordt gestuurd.

Nadelen:
- Er moet nieuwe abonneer functionaliteit worden ontwikkeld. De body van een AbonneerPersonenOpGroep command moet tijdelijk worden opgeslagen (in een database) zodat het door een achtergrondproces kan worden afgehandeld. Er moet een endpoint worden ontwikkeld waarmee de status en resultaten van een bulk aanroep kan worden opgevraagd.
