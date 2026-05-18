# Gebeurtenissen API - Verifieren van code gegenereerd met behulp van de OpenAPI Specificatie

De src folder bevat code en resources die kunnen worden gebruikt om te verifiëren of de code gegenereerd met behulp van de OpenAPI Specificatie correct functioneert.

Gebruikte code generatoren
- [OpenApi Generator v7.22](https://openapi-generator.tech/)

Gebruikte OpenAPI specificaties
- openapi.yaml in de 'specificaties/abonnementen-en-bevragen/resolved' map

Prerequisites
- Java 21 of hoger
- Go 1.20 of hoger
- Docker voor het genereren van client code met de OpenAPI Generator Docker image

## Gebeurtenissen Mock

De Gebeurtenissen Mock in de gebeurtenissen-mock map is een mock implementatie van de Gebeurtenissen API.
Het is een Spring Boot 4/Kotlin project dat een hardcoded response teruggeeft voor de /abonnees/{abonneenaam}/gebeurtenissen endpoint. Deze endpoint is gemockt om te verifiëren dat met de gegenereerde Gebeurtenis en Datum types correcte JSON wordt geproduceerd.

Start de server mock door het uitvoeren van de volgende statements:

```bash
cd gebeurtenissen-mock
./gradlew bootRun
```

De base URL van de server mock is http://localhost:8080.
Bevraag de hardcoded gebeurtenissen via de endpoint /abonnees/{abonneenaam}/gebeurtenissen, waarbij {abonneenaam} kan worden vervangen door een willekeurige naam. Bijvoorbeeld:

```bash
curl http://localhost:8080/abonnees/test/gebeurtenissen
```

## Test Clients

In de clients map zijn test clients geïmplementeerd in verschillende programmeertalen die de gegenereerde client code gebruiken om de Gebeurtenissen API mock te bevragen. Deze clients worden gebruikt om te verifiëren dat met de gegenereerde code de JSON respons van de mock correct wordt gedeserialiseerd.

### Go Test Client

Genereer client code voor de test geïmplementeerd in Go door het uitvoeren van de 'generate-client-code.sh' script:

```bash
cd src/clients/go
./generate-client-code.sh
```

Voer de test uit met de volgende statement:

```bash
go test -v ./...
```

#### Opmerkingen
De client code moet worden gegenereerd met de volgende OpenAPI Generator opties:
- `disallowAdditionalPropertiesIfNotPresent=false` om ervoor te zorgen dat de gegenereerde Gebeurtenis en Datum struct types de additionalProperties veld bevatten, wat nodig is voor correcte JSON serialisatie/deserialisatie.
