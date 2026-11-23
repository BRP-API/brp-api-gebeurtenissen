# ADR 009: Omgaan met fouten in de BRP bij het publiceren van gebeurtenissen

## Status

Voorstel. Beslissing moet worden genomen door het team in samenspraak met het Classificatie Service team en Informatie Beheer.

## Context

Tijdens het uitwerken van de requirements voor de oplossing beschreven in ADR 006 zijn er conflicterende requirements benoemd. Enerzijds mogen abonnees zich niet kunnen abonneren op een persoon als:
- het burgerservicenummer van de persoon bij meerdere personen is geregistreerd
- de persoonslijst van de persoon is opgeschort met reden 'F' of 'W'
Anderzijds moeten de gebeurtenissen die voor deze personen worden gepubliceerd wel worden geaccepteerd. Hierdoor komen er gebeurtenissen in de event store die niet kunnen worden gewijzigd of verwijderd.
Verder is het valideren van de gegevens van een gebeurtenis niet als requirement benoemd. Dit heeft als consequentie dat er gebeurtenissen kunnen worden gepubliceerd die niet kunnen worden herleid naar een wijziging in de BRP.

### Fouten die kunnen worden gedetecteerd

De fouten die tijdens het verwerken van een te publiceren gebeurtenis kunnen worden gedetecteerd:

1. het burgerservicenummer van de persoon bij de te publiceren gebeurtenis is meerdere keren uitgegeven, aan verschillende personen. Of de persoonslijsten van de twee personen horen bij één persoon of een persoon is geregistreerd met het burgerservicenummer van een ander persoon.
2. de te publiceren gebeurtenis hoort bij een persoon van wie de persoonslijst is opgeschort met 'F' (fout) of 'W' (wissen). Voordat er gebeurtenissen kan worden gepubliceerd/wijzigingen worden geregistreerd voor een persoon die is opgeschort met reden 'F' of 'W' moet de persoonslijst van de persoon eerst [opnieuw worden opgenomen](https://www.rvig.nl/hup/afvoeren-van-een-ten-onrechte-opgenomen-persoonslijst).
3. de wijziging in de BRP die hoort bij de te publiceren gebeurtenis kan niet worden herleid. Bijv. de te publiceren gebeurtenis is overleden, maar in de BRP is er voor de betreffende persoon geen overlijden geregistreerd.
4. het type van de te publiceren gebeurtenis komt niet overeen met de wijzigingen in de BRP. Bijv. de te publiceren gebeurtenis is verhuisd intergemeentelijk, maar in de BRP is de gemeentecode van de verblijfplaats gelijk aan de gemeentecode van de vorige verblijfplaats.  

## Opties hoe met de fouten om te gaan

### Optie 1: Accepteren zonder validatie/verificatie

Uitgangspunt van deze optie is dat de te publiceren gebeurtenissen correct zijn. De gemeente geeft de wijzigingen van een persoon door en de classificatie service publiceert de classificatie van de wijzigingen als gebeurtenis. Foute classificaties (bug) moeten door de classificatie service worden hersteld.

Voordelen:
- Er hoeft geen validatie van de gebeurtenissen te worden geïmplementeerd in BRP API Gebeurtenissen.
- Een abonnee kan in principe geen gebeurtenissen missen.

Nadelen:
- Fouten zijn lastig te herstellen. Gebeurtenissen in de Event Store kunnen niet worden gewist.
- Er worden foute gebeurtenissen geleverd aan abonnees. Dit kan consequenties hebben voor de personen over wie de foute gebeurtenissen zijn gepubliceerd, zoals onterecht overleden worden verklaard of identiteitsfraude.
- Fouten gemaakt door een gemeente of in de BRP (de bron) worden gecorrigeerd door correctie procedures en deze worden als correctie gebeurtenissen gepubliceerd, maar deze gebeurteniseen kunnen (mogelijk) niet worden gebruikt om fouten ontstaan door bugs te corrigeren, omdat deze niet kunnen worden herleid naar correcties in de BRP. Er zullen dus andere typen correctie gebeurtenissen moeten worden geïmplementeerd en op een andere manier worden gepubliceerd omdat dit (waarschijnlijk) niet via de classificatie service kan.
- Het ecosysteem waar de classificatie service en gebeurtenissen wordt gehost moet kunnen garanderen dat er geen fouten kunnen ontstaan door bijvoorbeeld een cyberaanval. Het moet dan niet mogelijk zijn dat een ander proces gebruik kan maken van de publicatie API dan het classificatie systeem.
- Alle afnemers, zowel intern als extern, moeten logica implementeren om rekening te houden met bijv. het meerdere keren uitgeven van een burgerservicenummer aan verschillende personen.

### Optie 2: Weigeren bij het publiceren

Een foute gebeurtenis wordt bij de publicatie aanvraag geweigerd met de reden van weigering.

Voordelen:
- Er komen weinig tot geen foute gebeurtenissen in de Event Store.
- Er worden weinig tot geen foute gebeurtenissen geleverd aan abonnees.
- Fouten veroorzaakt door een gemeente en die niet eerder zijn ontdekt in het proces vóór de classificatie service worden gemeld.

Nadelen:
De classificatie service moet een foutresponse afhandelen. Dit kan leiden tot een grotere complexiteit in de implementatie van de classificatie service. Wanneer de publicatie van een gebeurtenis wordt geweigerd, dan moet de classificatie service alle gebeurtenissen voor de persoon van de foute gebeurtenis niet publiceren totdat de foute gebeurtenis is gecorrigeerd en gepubliceerd om ervoor te zorgen dat de gebeurtenissen voor de betreffende persoon in de juiste volgorde wordt gepubliceerd.

### Optie 3: Accepteren en binnen Gebeurtenissen ervoor zorgen dat er geen foute gebeurtenissen wordt gepubliceerd in de Event Store

Een mogelijke oplossing hiervoor is om de gebeurtenissen die worden gepubliceerd door de classificatie service tijdelijk op te slaan in queues. Pas als een gebeurtenis correct is gevonden wordt het gepubliceerd in de Event Store.

Voordelen:
De voordelen van optie 2 gelden ook hier. Dit is mogelijk ook een oplossing voor de issue [Methode toevoegen om te garanderen dat de event store nooit een bericht mist uit de classificatie service](https://github.com/BRP-API/brp-api-gebeurtenissen/issues/53)

Nadelen:
- De nadelen van optie 2 gelden ook hier. In dit geval heeft het gebeurtenissen team zelf de controle hoe met fouten in de BRP moet worden omgegaan. Foute gebeurtenissen kunnen bijvoorbeeld in een Dead-Letter Queue worden gezet, zodat ze handmatig kunnen worden gevalideerd en gecorrigeerd.
- Er moet een proces komen waarmee meldingen kan worden gedaan over fouten die niet zijn ontstaan door bugs.

## Beslissing

Bepalen na bespreken van de opties

## Gerelateerde ADRs

- [ADR 004: Event-Driven Architecture voor de BRP API](./004-event-driven-architecture.md)
- [ADR 006: Gebruik (interne) persoonsidentificatie voor personen in gebeurtenissen](./006-persoonsidentificatie-in-gebeurtenissen.md)

## Voorbeelden van implementatie fouten die nu nog in de BRP API zitten

In de Personen Bevragen API wordt bij het raadplegen met burgerservicenummer geen personen geleverd als het opgegeven burgerservicenummer meerdere keren is uitgegeven, maar dezelfde controle is gemist/niet geïmplementeerd bij bijvoorbeeld zoeken met geslachtsnaam en geboortedatum

```gherkin
  Scenario: Twee personen met dezelfde burgerservicenummer, geslachtsnaam en geboortedatum worden gezocht op geslachtsnaam en geboortedatum
    Gegeven de persoon met burgerservicenummer '000000028' heeft de volgende gegevens
    | geboortedatum (03.10) | geslachtsnaam (02.40) | voornamen (02.10) |
    | 19830526              | Jansen                | Jan               |
    En de persoon met burgerservicenummer '000000028' heeft de volgende gegevens
    | geboortedatum (03.10) | geslachtsnaam (02.40) | voornamen (02.10) |
    | 19830526              | Jansen                | Piet              |
    Als personen wordt gezocht met de volgende parameters
    | naam                       | waarde                              |
    | type                       | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam              | Jansen                              |
    | inclusiefOverledenPersonen | true                                |
    | geboortedatum              | 1983-05-26                          |
    | fields                     | burgerservicenummer,naam            |
    Dan heeft de response 2 personen
    En heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000028 |
    En heeft de persoon de volgende 'naam' gegevens
    | voornamen | geslachtsnaam |
    | Jan       | Jansen        |
    En heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000028 |
    En heeft de persoon de volgende 'naam' gegevens
    | voornamen | geslachtsnaam |
    | Piet      | Jansen        |
```

Dit is ook het geval bij de Bewoning API

```gherkin
    Scenario: Twee personen met dezelfde burgerservicenummer staan beide ingeschreven op hetzelfde adres
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0800                 | 0800010000000001                         |
    En de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
    | geslachtsnaam (02.40) |
    | Maassen               |
    En de persoon is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
    | geslachtsnaam (02.40) |
    | Rafi                  |
    En de persoon is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100819                           |
    Als bewoningen wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                         | 2010-08-20          |
    | adresseerbaarObjectIdentificatie | 0800010000000001     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2010-08-20 tot 2010-08-21 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer | naam.geslachtsnaam |
    | 000000024           | Maassen            |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer | naam.geslachtsnaam |
    | 000000024           | Rafi               |

```