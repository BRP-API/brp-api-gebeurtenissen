# Getting started

## Prerequisites
- maak een kopie van het .env.example bestand en hernoem het naar .env
- vul in het .env bestand de missende user en password variabelen

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
