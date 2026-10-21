# ADR008: Cucumber test suite in CI

## Status

Voorstel

## Context

Het team gebruikt CucumberJS om specificaties en end-to-end (e2e) tests te schrijven. 
De Cucumber test suite wordt beheerd in dezelfde repository als de documentatie, de "documentatie repository". 
Dit betekent dat de test suite gescheiden is van de broncode.

De CI-pipeline moet ervoor zorgen dat de Cucumber test suite wordt uitgevoerd bij elke build.

## Mogelijke oplossingen

### 1. Cucumber test suite verhuizen naar de broncode repository

Dit is de meest simpele oplossing. De test suite gaat naast de broncode leven en de bijbehorende GitHub Actions stappen worden samengevoegd.

Voordelen
- Zeer snel te realiseren vanwege de simpliciteit.
- Betere developer experience, omdat alle benodigdheden zich in een repository bevindt.
- Gebruikt Git voor versie beheer, zoals gebruikelijk.
- Geen periodieke handmatige handelingen nodig.
- Duurzaam (energieverbruik)

Nadelen
- Potentieel hergebruik in de toekomst van Cucumber stappen wordt minder vanzelfsprekend.

### 2. Cucumber test suite periodiek copy-pasten naar de broncode repository

Met behulp van een GitHub Action workflow worden de test suite code en CI code periodiek gekopieerd naar de broncode repository.
De veranderingen worden gepresenteerd in een pull request (PR), die vervolgens moet worden geapproved en gemerged.

Deze opzet wordt al gebruikt in andere repositories van BRP API.

Voordelen
- Zeer snel te realiseren, omdat het al is toegepast in andere repositories.
- Betere developer experience, omdat alle benodigdheden zich in een repository bevindt.

Nadelen
- Gebruikt in essentie geen Git voor versie beheer, omdat het een "domme" periodieke copy-paste-overwrite proces is.
  - Waardeloze Git history in de broncode repository, omdat elke copy-paste-overwrite wordt gecommit als "gesynchroniseerd" met op dat moment gevonden afwijkingen. Voor zinvolle Git history moet je in de documentatie repository kijken.
  - In het verleden heeft deze opzet geleid tot merge conflicts. Het oplossen ervan moet zonder ondersteuning van Git. Dit betekent dat je zelf de verschillen en de volgordelijkheid moet uitzoeken, waardoor het veel inspanning kost.
- Vereist periodieke handmatige handelingen, omdat alle broncode repositories moet worden nagelopen op PRs na een aanpassing in de test suite code of CI code in de documentatie repository.
- Minder duurzaam (energieverbruik)

### 3. Cucumber test suite uitchecken in de broncode repository bij elke build

Bij elke pipeline build [twee repositories uitchecken](https://github.com/actions/checkout#checkout-multiple-repos-nested): de broncode repository en de documentatie repository.
Hierdoor zijn zowel de test suite code als de CI code beschikbaar in de broncode repository.

Voordelen
- Snel te realiseren vanwege de simpliciteit.
- Gebruikt Git voor versie beheer, zoals gebruikelijk.
- Geen periodieke handmatige handelingen nodig.

Nadelen
- Slechtere developer experience, omdat alle benodigdheden zich in twee repositories bevinden.
- Minder duurzaam (energieverbruik)

### 4. Cucumber test suite uitvoeren in de documentatie repository door middel van een trigger vanuit de broncode repository

Bij elke pipeline build wordt een webhook trigger gestuurd vanuit de broncode repository naar de documentatie repository.
De webhook trigger zorgt ervoor dat een workflow in de documentatie repository draait die de Cucumber test suite uitvoert.

Voordelen
- Gebruikt Git voor versie beheer,
- Geen periodieke handmatige handelingen nodig.

Nadelen
- Langzamer te realiseren vanwege de complexiteit.
- Slechtere developer experience, omdat alle benodigdheden zich in twee repositories bevinden.
- Vervuilt de GitHub Container Registry, omdat iedere pipeline build een nieuwe container image moet pushen zodat het beschikbaar is voor de documentatie repository om te pullen. 
- Veel minder duurzaam (energieverbruik)
