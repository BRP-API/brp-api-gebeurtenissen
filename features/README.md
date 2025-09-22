# BRP API Gebeurtenissen functionaliteit documentatie

Deze features map bevat de documentatie van de functionaliteit van BRP API Gebeurtenissen. De functionaliteit is gespecificeerd met behulp van scenario/voorbeelden geschreven in [Gherkin](https://cucumber.io/docs/#what-is-gherkin) syntax. Gherkin maakt het mogelijk om de functionaliteit van een systeem op een gestructureerde manier in natuurlijke taal te beschrijven, zodat het begrijpbaar is voor zowel technische als niet-technische lezers. Het structuur van een scenario/voorbeeld ziet er in grote lijnen als volgt uit

```feature
Gegeven het systeem heeft een huidige state
Als een opdracht in het systeem is uitgevoerd
Dan heeft het systeem een nieuwe state
```

BRP API Gebeurtenissen is een systeem geïmplementeerd conform de Event-Driven Architecture (EDA) design pattern. In een EDA systeem worden significante wijzigingen in het systeem gecommuniceerd door het publiceren van events (gebeurtenissen) en worden events geïnitieerd door commands (opdrachten).
BRP API Gebeurtenissen communiceert gebeurtenissen van personen die geregistreerd staan in de BRP als opgegeven aangiften/wijzigingen voor deze personen zijn verwerkt. BRP specifieke gebeurtenissen zijn bijvoorbeeld geëmigreerd, geïmmigreerd, geboren, verhuisd en overleden en BRP specifieke aangiften zijn bijvoorbeeld 'aangeven immigratie', 'aangeven geboorte', 'aangeven verhuizing', en 'aangeven overlijden'.

Voor het specificeren van de BRP API Gebeurtenissen functionaliteit zijn stappen gedefinieerd om in scenarios zoveel mogelijk aangiften/wijzigingen en bijbehorende gebeurtenissen van personen in het BRP domein te kunnen illustreren. Het verwerken van bijvoorbeeld een geboorteaangifte van een kind 'Jan' wordt dan als volgt gespecificeerd:

```feature
Scenario: aangeven van een geboorte
  Als de aangifte van geboorte van 'Jan' is verwerkt
  Dan is een 'ingeschreven.geboorte' gebeurtenis gepubliceerd
```

Voorbeelden van BRP command stap definities zijn:
- Als de opgave van verhuizing van '[persoon aanduiding]' is verwerkt
- Als de aangifte van overlijden van '[persoon aanduiding]' is verwerkt

Een bijkomend voordeel van Gherkin-voorbeelden en scenarios is dat ze met behulp van tooling (bijvoorbeeld [Cucumber](https://cucumber.io)) kunnen worden omgezet tot uitvoerbare specificaties. Hierdoor kunnen de voorbeelden en scenarios worden gebruikt om het gedrag van het systeem te valideren.

De stap definitie `Als de geboorteaangifte van 'Jan' is verwerkt` kan dan worden gekoppeld aan een script die een valide HTTP request genereert voor het initieren van de verwerking van een geboorteaangifte door (een sub-systeem van) de BRP of door een mock van de BRP zoals de Personen Mutatie service. Het gegenereerde JSON bericht bevat alle verplichte velden vooringevuld met valide waarden zodat de geboorteaangifte succesvol kan worden verwerkt door de (sub-systeem van) de BRP of de Personen Mutatie service.

Een voorbeeld van een valide geboorteaangifte request voor de Personen Mutatie service ziet er als volgt uit:

```http
POST https://personen-mutaties-service/geboorteaangifte
Content-Type: application/json

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

En een valide geboorte request voor (een sub-systeem van) de BRP ziet er als volgt uit:

```http
POST https://classificatie-service
Content-Type: application/json

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

Note. De request voorbeelden aanpassen als er is vastgesteld wat de verplichte velden zijn voor een geboorteaangifte en hoe het berichtstructuur van een geboorteaangifte eruit ziet van (het sub-systeem van) de BRP

Ook zijn er stap definities waarmee het voor een BRP command gegenereerde JSON bericht kan worden verrijkt. Met deze stap definities kunnen de standaard gegenereerde waarden worden vervangen door specifieke waarden óf er kunnen velden worden verwijderd/toegevoegd om bijvoorbeeld scenarios te schrijven voor edge cases. Voorbeelden van 'extensie' stap definities zijn:
- verblijft vanaf [datum] op adres '[adres aanduiding]'
- verblijft vanaf [datum] op buitenlands adres '[regel 1]', '[regel 2]', '[regep 3]' in land '[land aanduiding]'
- is (op) [datum] geboren in gemeente '[gemeente aanduiding]'
- is (op) [datum] geboren in plaats '[plaats aanduiding]' in land '[land aanduiding]'

Een verrijkte variant van de 'aangeven van een geboorte' scenario ziet er dan als volgt uit:

```
Scenario: aangeven van een geboorte
  Als de aangifte van geboorte van 'Jan' is verwerkt
  * is op 1-9-2025 geboren in Amsterdam
  Dan is een 'ingeschreven.geboorte' gebeurtenis gepubliceerd
```

Dit resulteert dan in de volgende gegenereerde geboorteaangifte request voor de Personen Mutaties service

```http
POST https://personen-mutaties-service/geboorteaangifte
Content-Type: application/json

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

In de BRP zijn er aangiftes die alleen kunnen worden gedaan als er vooraf andere aangiftes zijn gedaan en de bijbehorende gebeurtenissen hebben plaatsgevonden. Het is bijvoorbeeld niet mogelijk om aangifte van een verhuizing van een persoon te verwerken als de persoon niet staat ingeschreven in de BRP door bijvoorbeeld immigratie of geboorte.
Om deze scenarios te kunnen beschrijven en na te spelen, bestaat er 'verwerkte' varianten van de BRP command stap definities. De 'verwerkte' variant van bijvoorbeeld de `Gegeven de aangifte van geboorte van '[persoon aanduiding]' is verwerkt` stap definitie is de `Gegeven de verwerkte aangifte van geboorte van '[persoon aanduiding]'` stap definitie. De scenario waarbij een kind op de dag van geboorte verhuisd naar een ander adres kan dan als volgt worden geschreven:

```feature
Scenario: kind verhuist op de dag van geboorte
    Gegeven de verwerkte aangifte van geboorte van 'Jan'
    * is op '14-4-2020' geboren in 'Amsterdam'
    Als de opgave van verhuizing van 'Jan' is verwerkt
    * verblijft vanaf '14-4-2020' op een ander adres in 'Amsterdam'
    Dan is een 'verhuisd.binnengemeentelijk' gebeurtenis het laatst gepubliceerd
```

Om de volgorde van de gepubliceerde gebeurtenissen te specificeren kan gebruik worden gemaakt van de stap definitie `Dan zijn de volgende gebeurtenissen in de opgegeven volgorde gepubliceerd`. Het bovengenoemde scenario ziet er dan als volgt uit:

```feature
Scenario: aangeven van een binnengemeentelijke verhuizing
    Gegeven de verwerkte aangifte van geboorte van 'Jan'
    * verblijft vanaf '14-4-2020' op een locatie in 'Amsterdam'
    Als de aangifte van verhuizing van 'Jan' is verwerkt
    * verblijft vanaf '1-9-2025' op een ander adres in 'Amsterdam'
    Dan zijn de volgende gebeurtenissen in de opgegeven volgorde gepubliceerd
    | gebeurtenis type              |
    | ingeschreven.geboorte         |
    | verhuisd.binnengemeentelijk   |
```

In de BRP komt het voor dat gegevens van een gebeurtenis in onderzoek wordt gezet of moet worden gecorrigeerd. Het komt ook voor dat zo'n gebeurtenis dat in onderzoek wordt gezet of moet worden gecorrigeerd niet de meest recente gebeurtenis is. Om in een scenario aan te kunnen geven welke gebeurtenis in onderzoek moet worden gezet of moet worden gecorrigeerd, moet er gebruik worden gemaakt van een verwerkte aangifte variant waar er een aanduiding kan worden opgegeven voor de aangifte. Onderstaand scenario beschrijft een persoon van wie de één na laatste verhuizing in onderzoek moet worden gezet:

```feature
Scenario: een niet-recente aangifte wordt in onderzoek gezet
    Gegeven de verwerkte aangifte van geboorte van 'Jan'
    En de verwerkte aangifte van verhuizing van 'Jan'
    En de verwerkte aangifte van verhuizing 'verhuizing1' van 'Jan'
    En de verwerkte aangifte van verhuizing van 'Jan'
    Als de aangifte van in onderzoek van 'verhuizing1' is verwerkt
    Dan is een 'verblijfplaats.in-onderzoek' gebeurtenis gepubliceerd
```

Om de attack surface van BRP API Gebeurtenissen te minimaliseren worden er geen/zo min mogelijk (gerelateerde) persoonsgegevens opgenomen in de opgeslagen gebeurtenissen. In de huidige versie worden bij een gebeurtenis alleen de persoonslijst id en indien noodzakelijk de adres id of het buitenlands adres én datum aanvang adreshouding/adres buitenland opgeslagen. Hiermee wordt ook voldaan aan de eis om data eenmalig op te slaan en meervoudig te gebruiken.

De gebeurtenissen die door BRP API Gebeurtenissen worden conform [cloudevents](https://cloudevents.io) specificatie opgeslagen en geleverd. De scripts gekoppeld aan de volgende dan-stap definities valideren dat gepubliceerde gebeurtenissen zich aan de [cloudevents](https://cloudevents.io) specificatie conformeren:
- Dan is een '[gebeurtenis type]' gebeurtenis gepubliceerd 
- Dan is een '[gebeurtenis type]' gebeurtenis het laatst gepubliceerd 
- Dan zijn de volgende gebeurtenissen in de opgegeven volgorde gepubliceerd

Om in een scenario expliciet aan te geven dat een gepubliceerde gebeurtenis zich conformeert aan de cloudevents specificatie moet de `Dan is cloudevent 1.0.2 compliant` stap definitie worden gebruikt. De 'aangeven van een geboorte' scenario waarbij expliciet is aangegeven dat de gepubliceerde gebeurtenis cloudevent compliant is ziet er dan als volgt uit:

```feature
Scenario: aangeven van een geboorte
  Als de aangifte van geboorte van '[persoon aanduiding]' is verwerkt
  Dan is een 'ingeschreven.geboorte' gebeurtenis gepubliceerd
  * is cloudevent 1.0.2 compliant
```

Bij een cloudevents compliant gebeurtenis worden de niet-cloudevents specifieke velden opgenomen in het data veld. Om in een scenario aan te geven welke gegevens in het data veld staan, moet de `Dan heeft de volgende 'data' gegevens` stap definitie worden gebruikt. De verrijkte 'aangeven van een geboorte' scenario ziet er dan als volgt uit:

```feature
Scenario: aangeven van een geboorte
  Als de aangifte van geboorte van '[persoon aanduiding]' is verwerkt
  Dan is een 'ingeschreven.geboorte' gebeurtenis gepubliceerd
  * heeft de volgende 'data' gegevens
  | pl_id                |
  | [persoon aanduiding] |
```
