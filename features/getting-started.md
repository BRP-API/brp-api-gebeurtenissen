# Getting started

## Prerequisites
- maak een kopie van het .env.example bestand en hernoem het naar .env
- vul in het .env bestand de missende user en password variabelen

## Uitvoeren van alle documentatie scenarios
```
npx cucumber-js -p Docs
npx cucumber-js -p DocsIntegratie
```

## Uitvoeren van alle end to end scenarios
```
npx cucumber-js -p EndToEnd
```

## Uitvoeren van een specifieke feature/scenario

uitvoeren van alle scenarios in bijv. het features/verhuisd.intergemeentelijk.feature bestand waarbij alle info, warn en error log regels wordt getoond in de terminal
```
npx cucumber-js features/verhuisd.intergemeentelijk.feature -p dev
```

uitvoeren van bijv. de scenario op regel 16 in het features/verhuisd.intergemeentelijk.feature waarbij alle debug, info, warn en error log regels wordt getoond in de terminal
```
npx cucumber-js features/verhuisd.intergemeentelijk.feature:16 -p debug
```
## Opbouw van de features
De features zijn ingedeeld naar doelgroep voor de functionaliteit. Hierbij onderscheiden we vier doelgroepen:
- afnemers die abonnees beheren: zie /features/beheer-abonnees
- abonnees die abonnementen beheren en gebeurtenissen vragen: zie features/beheer-abonnementen en features/vraag-gebeurtenissen
- testers die op de probeeromgeving wijzigingen en bijbehorende gebeurtenissen willen initiëren: zie /features/mutatie-service
- BRP-V ontwikkelaars die wijzigingen willen classificeren naar gebeurtenissen: zie /features/classificatie-service en /features/vraag-gebeurtenissen
