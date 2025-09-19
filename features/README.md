# BRP API Gebeurtenissen functionaliteit documentatie

De features map bevat de documentatie van de functionaliteit van BRP API Gebeurtenissen. De functionaliteit is gespecificeerd met behulp van scenario/voorbeelden geschreven in [Gherkin](https://cucumber.io/docs/#what-is-gherkin) syntax.

BRP API Gebeurtenissen is een systeem geïmplementeerd conform de Event-Driven Architecture (EDA) design pattern. In een EDA systeem worden significante wijzigingen in het systeem gecommuniceerd door het publiceren van events (gebeurtenissen). BRP API Gebeurtenissen communiceert de wijzigingen die hebben plaats gevonden op personen geregistreerd in de BRP. Voorbeelden van BRP specifieke gebeurtenissen zijn geëmigreerd, geïmmigreerd, geboren, verhuisd en overleden.

Binnen een EDA systeem kunnen gebeurtenissen worden geïnitieerd door commands. Voorbeelden van BRP specifieke commands zijn 'aangeven immigratie', 'aangeven geboorte', 'aangeven verhuizing', en 'aangeven overlijden'.

Voor het specificeren van de BRP API Gebeurtenissen functionaliteit zijn stappen gedefinieerd om in scenarios zoveel mogelijk wijzigingen aan personen in het BRP domein te kunnen illustreren. Het verwerken van bijv. een geboorteaangifte kan dan als volgt worden gespecificeerd:

```feature
Scenario: aangeven van een geboorte
  Als de aangifte van geboorte van 'Jan' is verwerkt
  Dan is een 'ingeschreven.geboorte' gebeurtenis gepubliceerd
```

Voorbeelden van BRP command stap definities zijn:
- Als de opgave van verhuizing van 'persoon aanduiding' is verwerkt
- Als de aangifte van overlijden van 'persoon aanduiding' is verwerkt

Een voordeel van het specificeren van functionaliteit met behulp van in Gherkin voorbeelden/scenarios, is dat de voorbeelden kan worden omgezet tot uitvoerbare specificaties. De stap definitie `Als de geboorteaangifte van 'Jan' is verwerkt` kan dan worden gekoppeld aan een script die een geboorteaangifte JSON bericht genereert met een willekeurige waarde voor de verplichte velden

```json
{
    "type": "geboorteaangifte",
    "geboorte": {
        "datum": "een datum vandaag of max. 3 dagen in het verleden"
    },
    "gemeenteVanInschrijving": {
        "code": "vier cijferig waarde ongelijk aan 1999"
    },
    "verblijfplaats": {
      // verplichte adres of locatie velden om resp. een adres of locatie uniek te kunnen identificeren 
    }
}
```

en het gegenereerde bericht stuurt naar de Persoon Mutatie API.

Of de stap definitie kan worden gekoppeld aan een script die het volgende JSON bericht genereert

```json
{
    "was": {},
    "wordt": {
        "c01": {
            "e0310": "een datum vandaag of max. 3 dagen in het verleden"
        },
        "c08": {
            "e0910": "vier cijferig waarde ongelijk aan 1999",
            // overige verplichte adres of locatie velden om resp. een adres of locatie uniek te kunnen identificeren
        }
    }
}
```

en het gegenereerde bericht stuurt naar de classificatie service.

Ook zijn er BRP stap definities waarmee er aan het gegenereerde JSON bericht van een BRP command velden kunnen worden toegevoegd of bestaande velden worden gewijzigd. Voorbeelden van deze extensie stap definities zijn:
- verblijft vanaf [datum] op adres '[adres aanduiding]'
- verblijft vanaf [datum] op buitenlands adres '[regel 1]', '[regel 2]', '[regep 3]' in land '[land aanduiding]'
- is (op) [datum] geboren in gemeente '[gemeente aanduiding]'
- is (op) [datum] geboren in plaats '[plaats aanduiding]' in land '[land aanduiding]'

Met deze extensie stap definities kan bijv. de bovengenoemde 'aangeven van een geboorte' scenario worden uitgebreid tot het volgende scenario:

```
Scenario: aangeven van een geboorte
  Als de aangifte van geboorte van 'Jan' is verwerkt
  * is op 1-9-2025 geboren in Amsterdam
  Dan is een 'ingeschreven.geboorte' gebeurtenis gepubliceerd
```

om het gekoppelde script de volgende JSON bericht te laten genereren

```json
{
    "type": "geboorteaangifte",
    "geboorte": {
        "datum": "2025-09-01",
        "plaats": {
            "code": "0599"
        }
    },
    "gemeenteVanInschrijving": {
        "code": "vier cijferig waarde ongelijk aan 1999"
    },
    "verblijfplaats": {
      // verplichte adres of locatie velden om resp. een adres of locatie uniek te kunnen identificeren 
    }
}
```

Verder is er voor de BRP command stap definities ook een verwerkte variant. Een voorbeelden van een verwerkte BRP command stap definitie is: `Gegeven de verwerkte aangifte van geboorte van '[persoon aanduiding]'`. Hiermee kunnen wijzigingen op een specifieke persoon worden gespecificeerd die alleen maar kunnen plaatsvinden nadat de persoon is geregistreerd in de BRP. Bijv. de scenario 'aangeven van een binnengemeentelijke verhuizing' kan als volgt worden gespecificeerd

```feature
Scenario: aangeven van een binnengemeentelijke verhuizing
    Gegeven de verwerkte aangifte van geboorte van 'Jan'
    * verblijft vanaf '14-4-2020' op een locatie in 'Amsterdam'
    Als de opgave van verhuizing van 'Jan' is verwerkt
    * verblijft vanaf '1-9-2025' op een ander adres in 'Amsterdam'
    Dan is een 'verhuisd.binnengemeentelijk' gebeurtenis het laatst gepubliceerd
```

Om de volgorde van de gepubliceerde gebeurtenissen te specificeren kan gebruik worden gemaakt van de stap definitie `Dan zijn de volgende gebeurtenissen in de opgegeven volgorde gepubliceerd`. Het bovengenoemde scenario ziet er dan als volgt uit:

```feature
Scenario: aangeven van een binnengemeentelijke verhuizing
    Gegeven de verwerkte aangifte van geboorte van 'Jan'
    * verblijft vanaf '14-4-2020' op een locatie in 'Amsterdam'
    Als de opgave van verhuizing van 'Jan' is verwerkt
    * verblijft vanaf '1-9-2025' op een ander adres in 'Amsterdam'
    Dan zijn de volgende gebeurtenissen in de opgegeven volgorde gepubliceerd
    | gebeurtenis type              |
    | ingeschreven.geboorte         |
    | verhuisd.binnengemeentelijk   |
```

Om de attack surface van BRP API Gebeurtenissen te minimaliseren worden er geen/zo min mogelijk (gerelateerde) persoonsgegevens opgenomen in de opgeslagen gebeurtenissen. In de huidige versie worden bij een gebeurtenis alleen de persoonslijst id en indien noodzakelijk de adres id of het buitenlands adres én datum aanvang adreshouding/adres buitenland opgeslagen.

De gebeurtenissen die door BRP API Gebeurtenissen worden opgeslagen en worden geleverd conformeren zich aan de [cloudevents](https://cloudevents.io) specificatie.

Voor het specificeren van de gepubliceerde gebeurtenissen en het valideren van de gepubliceerde gebeurtenissen bij het uitvoeren van de specificaties kunnen de volgende stap definities worden gebruikt:
- Dan is een '[gebeurtenis type]' gebeurtenis gepubliceerd 
- Dan is een '[gebeurtenis type]' gebeurtenis het laatst gepubliceerd 
- Dan zijn de volgende gebeurtenissen in de opgegeven volgorde gepubliceerd
- Dan heeft de volgende 'data' gegevens. Bij een cloudevents compliant gebeurtenis worden de niet-cloudevents specifieke velden opgenomen in het data veld. Deze stap definitie moet worden gebruikt om de velden in het data veld te specificeren

De aangepaste 'aangeven van een geboorte' scenario waarbij de `Dan heeft de volgende 'data' gegevens` stap definitie is gebruikt, ziet er dan als volgt uit:

```feature
Scenario: aangeven van een geboorte
  Als de aangifte van geboorte van '[persoon aanduiding]' is verwerkt
  Dan is een 'ingeschreven.geboorte' gebeurtenis gepubliceerd
  * heeft de volgende 'data' gegevens
  | pl_id                |
  | [persoon aanduiding] |
```
