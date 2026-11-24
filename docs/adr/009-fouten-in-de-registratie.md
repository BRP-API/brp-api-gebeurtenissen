# ADR 009: Omgaan met fouten in de BRP bij het publiceren van gebeurtenissen

## Status

Voorstel. Beslissing moet worden genomen door het team in samenspraak met het team van de classificatieservice en Informatiebeheer.

## Context

Tijdens het uitwerken van de requirements voor de oplossing beschreven in [ADR 007](./007-persoonsidentificatie-in-gebeurtenissen.md) zijn er conflicterende requirements benoemd. Enerzijds mogen abonnees zich niet kunnen abonneren op een persoon als:

- het burgerservicenummer van de persoon meerdere keren is uitgegeven aan verschillende personen
- de persoonslijst van de persoon is opgeschort met reden 'F' of 'W'

Anderzijds moeten de gebeurtenissen die voor deze personen worden gepubliceerd wel worden geaccepteerd. Hierdoor komen er gebeurtenissen in de event store die niet kunnen worden gewijzigd of verwijderd.
Verder is het valideren van de gegevens van een gebeurtenis niet als requirement benoemd. Dit heeft als consequentie dat er gebeurtenissen kunnen worden gepubliceerd die niet kunnen worden herleid naar een wijziging in de BRP.

### Fouten die kunnen worden gedetecteerd

Tijdens het verwerken van een te publiceren gebeurtenis kunnen de volgende fouten worden gedetecteerd:

1. het burgerservicenummer van de persoon bij de te publiceren gebeurtenis komt voor op meerdere persoonslijsten. Mogelijke oorzaken zijn:
   - de persoonslijsten horen bij één en dezelfde persoon (dubbele inschrijving)
   - het burgerservicenummer is meerdere keren uitgegeven, aan verschillende personen
2. de te publiceren gebeurtenis betreft een persoon van wie de persoonslijst is opgeschort met reden 'F' (fout) of 'W' (wissen). Een persoonslijst wordt bijvoorbeeld opgeschort met reden 'F' als deze ten onrechte is opgenomen, zoals bij een dubbele inschrijving of identiteitsfraude. Zo'n afgevoerde persoonslijst blijft onderdeel van de BRP, maar wordt uitgezonderd van alle procedures waarbij naar een persoon wordt gezocht. Er horen dus geen wijzigingen meer te worden geregistreerd en geen gebeurtenissen meer te worden gepubliceerd voor deze persoon. Is de persoonslijst ten onrechte afgevoerd, dan moet deze eerst [opnieuw worden opgenomen](https://www.rvig.nl/hup/afvoeren-van-een-ten-onrechte-opgenomen-persoonslijst) (paragraaf 'Opnieuw opnemen van een afgevoerde persoonslijst'). Daarbij worden de datum opschorting bijhouding (07.67.10) en de reden opschorting bijhouding (07.67.20) verwijderd. Pas daarna kunnen er weer wijzigingen worden geregistreerd en gebeurtenissen worden gepubliceerd.
3. de wijziging in de BRP die hoort bij de te publiceren gebeurtenis kan niet worden herleid. Bijvoorbeeld: de te publiceren gebeurtenis is 'overleden', maar in de BRP is er voor de betreffende persoon geen overlijden geregistreerd.
4. het type van de te publiceren gebeurtenis komt niet overeen met de wijzigingen in de BRP. Bijvoorbeeld: de te publiceren gebeurtenis is 'verhuisd intergemeentelijk', maar in de BRP is de gemeentecode van de verblijfplaats gelijk aan de gemeentecode van de vorige verblijfplaats.

De fouten kunnen verschillende oorzaken hebben:

- **Vertraagde synchronisatie.** BRP API Gebeurtenissen raadpleegt een gesynchroniseerde, read-only kopie van de BRP-database waarin de wijzigingen worden doorgevoerd. Wordt een gebeurtenis gepubliceerd voordat de synchronisatie heeft plaatsgevonden, dan lijkt de gebeurtenis fout (bijvoorbeeld fout 3), terwijl dat na de synchronisatie niet meer zo is. Zo'n fout is dus tijdelijk. De gebeurtenis meteen doorsturen naar abonnees heeft weinig zin, omdat zij de gewijzigde gegevens nog niet kunnen opvragen met de andere BRP API's.
- **Classificatiefouten.** Een bug in de classificatieservice of een verkeerde interpretatie van de requirements kan leiden tot een gebeurtenis van het verkeerde type (fout 4) of een gebeurtenis zonder bijbehorende wijziging (fout 3). Zulke fouten horen tijdens het testen te worden gevonden. Komt zo'n fout toch in productie terecht, dan is de impact groot: er moeten herstelwerkzaamheden plaatsvinden in zowel de classificatieservice als BRP API Gebeurtenissen.

### Buiten scope

Menselijke fouten bij het registreren van wijzigingen vallen buiten deze ADR. Voorbeelden zijn het ten onrechte doorgeven van een wijziging, of het opnemen van onjuiste gegevens zoals een verkeerd adres of een typfout in de verhuisdatum. Zulke fouten zijn bij het publiceren niet te herkennen. Ook als een wijziging niet volledig volgens de HUP is doorgevoerd, hoeft de gebeurtenis die eruit volgt niet onjuist te zijn. Deze fouten worden in de BRP hersteld via de reguliere correctieprocedures. De correcties worden vervolgens als correctiegebeurtenissen gepubliceerd.

Het meerdere keren uitgeven van hetzelfde burgerservicenummer (fout 1) valt wel binnen de scope. Deze fout wordt weliswaar door een gemeente gemaakt, maar had moeten worden gedetecteerd door het systeem dat de wijzigingen valideert. Omdat dat niet is gebeurd, is de fout wel herkenbaar bij het publiceren.

## Opties voor het omgaan met de fouten

### Optie 1: Accepteren zonder validatie/verificatie

Uitgangspunt van deze optie is dat de te publiceren gebeurtenissen correct zijn. De gemeente geeft de wijzigingen van een persoon door en de classificatieservice publiceert de classificatie van de wijzigingen als gebeurtenis. Foute classificaties door een bug moeten door de classificatieservice worden hersteld.

Voordelen:
- Er hoeft geen validatie van de gebeurtenissen te worden geïmplementeerd in BRP API Gebeurtenissen.
- Een abonnee kan in principe geen gebeurtenissen missen.

Nadelen:
- Fouten zijn lastig te herstellen. Gebeurtenissen in de event store kunnen niet worden gewist. Een event store werkt volgens exact hetzelfde principe als een boekhoudkundig grootboek. Een event store is append-only (alleen toevoegen) en immutable (onveranderlijk). Als er een fout wordt gemaakt, moet die fout met een nieuw event worden rechtgezet. De consequenties hiervan zijn:
  - Een fout kan alleen worden hersteld met een compenserende gebeurtenis. Daarvoor moeten aparte gebeurtenistypen en een apart publicatieproces worden ingericht (zie hieronder).
  - Abonnees hebben de foute gebeurtenis op het moment van herstel al ontvangen en mogelijk verwerkt. Ze moeten de compenserende gebeurtenis kunnen herkennen en hun eigen verwerking kunnen terugdraaien.
  - Projecties en read models die op de foute gebeurtenis zijn gebaseerd, moeten worden gecorrigeerd of opnieuw worden opgebouwd.
  - Gegevens die ten onrechte aan een persoon zijn gekoppeld, bijvoorbeeld bij een meerdere keren uitgegeven burgerservicenummer, blijven blijvend in de event store staan. Dit is een privacyrisico en staat mogelijk op gespannen voet met het beginsel van juistheid ([AVG artikel 5](https://www.privacy-regulation.eu/nl/5.htm), lid 1, onder d) en de rechten op rectificatie en gegevenswissing ([AVG artikel 16](https://www.privacy-regulation.eu/nl/16.htm) en [AVG artikel 17](https://www.privacy-regulation.eu/nl/17.htm)). Hoe deze zich verhouden tot de Wet BRP moet worden afgestemd met Informatiebeheer en de juristen van RvIG.
- Er worden foute gebeurtenissen geleverd aan abonnees. Dit kan consequenties hebben voor de personen over wie de foute gebeurtenissen zijn gepubliceerd, zoals het onterecht overleden verklaren van een persoon. Daarnaast kunnen gebeurtenissen aan de verkeerde persoon worden gekoppeld. Een abonnement wordt vastgelegd op de persoonId (zie [ADR 007](./007-persoonsidentificatie-in-gebeurtenissen.md)), dus de levering aan abonnees gaat hier niet mis. Bij het opvragen van gebeurtenissen met een burgerservicenummer kan het wel misgaan. Is dat burgerservicenummer meerdere keren uitgegeven, dan worden ook de gebeurtenissen van een andere persoon gevonden. Dat dit gebeurtenissen van twee verschillende personen zijn, kan een afnemer alleen zien als het a-nummer expliciet ook wordt gevraagd. Anders worden persoonsgegevens aan de verkeerde persoon toegeschreven (verkeerde verstrekking):

  ```gherkin
  Voorbeeld: gebeurtenissen opvragen met een meerdere keren uitgegeven burgerservicenummer
    Gegeven de persoon 'Jan' is geregistreerd in de BRP
    En voor 'Jan' zijn één of meerdere gebeurtenissen gepubliceerd
    En de persoon 'Piet' is geregistreerd in de BRP met hetzelfde burgerservicenummer als 'Jan'
    En voor 'Piet' is een gebeurtenis gepubliceerd
    Als gebeurtenissen worden gezocht met het burgerservicenummer van 'Jan'
    Dan bevat de response de gebeurtenissen van 'Jan' en van 'Piet'
    En is alleen aan het a-nummer te zien dat de gebeurtenissen bij twee verschillende personen horen
  ```
- Fouten die door een gemeente of in de BRP (de bron) zijn gemaakt, worden gecorrigeerd via correctieprocedures en als correctiegebeurtenissen gepubliceerd. Deze correctiegebeurtenissen kunnen (mogelijk) niet worden gebruikt om fouten door bugs in de classificatieservice te corrigeren, omdat die fouten niet kunnen worden herleid naar correcties in de BRP. Er zullen dus andere typen correctiegebeurtenissen moeten worden geïmplementeerd, die op een andere manier worden gepubliceerd, omdat dit (waarschijnlijk) niet via de classificatieservice kan. Zie [Herstel van foute gebeurtenissen in de event store](#herstel-van-foute-gebeurtenissen-in-de-event-store).
- Het ecosysteem waarin de classificatieservice en BRP API Gebeurtenissen worden gehost, moet kunnen garanderen dat er geen fouten kunnen ontstaan door bijvoorbeeld een cyberaanval. Het mag dan niet mogelijk zijn dat een ander proces dan de classificatieservice gebruikmaakt van de publicatie-API.
- Alle afnemers, zowel intern als extern, zullen logica moeten implementeren om met de fouten om te kunnen gaan. In de Personen Bevragen API is bijvoorbeeld logica geïmplementeerd om bij elke bevraging 'raadpleeg persoon met burgerservicenummer' te controleren dat er exact één persoon wordt gevonden. Deze controle ontbreekt echter bij andere zoekvragen en in de Bewoning API (zie [Bijlage](#bijlage-ontbrekende-controles-op-een-meerdere-keren-uitgegeven-burgerservicenummer-in-bestaande-brp-apis)).

### Optie 2: Weigeren bij het publiceren

Een foute gebeurtenis wordt bij de publicatieaanvraag geweigerd met de reden van weigering.

Voordelen:
- Er komen weinig tot geen foute gebeurtenissen in de event store.
- Er worden weinig tot geen foute gebeurtenissen geleverd aan abonnees.
- Fouten die door een gemeente zijn gemaakt en die niet zijn gedetecteerd door het systeem dat de wijzigingen valideert, worden alsnog gemeld. Bijvoorbeeld het meerdere keren uitgeven van hetzelfde burgerservicenummer (fout 1).

Nadelen:
- De classificatieservice moet een foutresponse afhandelen. Dit kan leiden tot een grotere complexiteit in de implementatie van de classificatieservice.
- Een gebeurtenis die alleen fout lijkt door een vertraagde synchronisatie, wordt onterecht geweigerd. De classificatieservice moet zo'n gebeurtenis later opnieuw aanbieden en moet daarvoor een tijdelijke fout kunnen onderscheiden van een blijvende fout.
- Wanneer de publicatie van een gebeurtenis wordt geweigerd, dan moet de classificatieservice alle gebeurtenissen voor de persoon van de foute gebeurtenis tegenhouden totdat de foute gebeurtenis is gecorrigeerd en gepubliceerd. Zo worden de gebeurtenissen voor de betreffende persoon in de juiste volgorde gepubliceerd.
- Hierdoor komen gebeurtenissen niet of veel later bij abonnees terecht. Nadat een fout in de BRP is teruggemeld, kan het maanden duren voordat deze is opgelost. Al die tijd horen abonnees niets over de gebeurtenissen van deze persoon, en wijkt hun beeld van de persoon af van wat er in de BRP staat.

  Kanttekening: bij livegang levert BRP API Gebeurtenissen maar drie gebeurtenistypen. Abonnees missen dus sowieso veel wijzigingen en moeten de Personen Bevragen API blijven gebruiken om de voor hen relevante gegevens op te vragen. Ook als alle gebeurtenistypen worden geleverd, blijft dat nodig, omdat niet alle gegevens die bij een gebeurtenis horen worden meegeleverd. Het effect van een vertraagde of ontbrekende gebeurtenis moet daarom worden afgewogen tegen het effect van een onjuiste gebeurtenis.

### Optie 3: Accepteren en binnen Gebeurtenissen ervoor zorgen dat er geen foute gebeurtenissen worden gepubliceerd in de event store

Een mogelijke oplossing hiervoor is om de gebeurtenissen die worden gepubliceerd door de classificatieservice tijdelijk op te slaan in queues. Pas als een gebeurtenis correct is bevonden, wordt deze gepubliceerd in de event store.

Voordelen:
- De voordelen van optie 2 gelden ook hier.
- De classificatieservice hoeft geen foutresponse af te handelen en hoeft geen gebeurtenissen tegen te houden. Het publiceren van gebeurtenissen blijft voor de classificatieservice ongewijzigd.
- Tijdelijke fouten door een vertraagde synchronisatie kunnen binnen Gebeurtenissen worden opgevangen door de validatie na enige tijd opnieuw uit te voeren. De gebeurtenis wordt dan pas in de event store gepubliceerd als de gewijzigde gegevens ook via de andere BRP API's op te vragen zijn.
- Het gebeurtenissenteam heeft zelf de controle over hoe met fouten in de BRP wordt omgegaan. Foute gebeurtenissen kunnen bijvoorbeeld in een Dead-Letter Queue worden gezet, zodat ze handmatig kunnen worden gevalideerd en gecorrigeerd.
- Dit is mogelijk ook een oplossing voor issue [#53: Methode toevoegen om te garanderen dat de event store nooit een bericht mist uit de classificatie service](https://github.com/BRP-API/brp-api-gebeurtenissen/issues/53).

Nadelen:
- Net als bij optie 2 komen gebeurtenissen niet of veel later bij abonnees terecht. Een foute gebeurtenis blijft in de queue staan totdat de fout is gecorrigeerd, en de latere gebeurtenissen voor dezelfde persoon moeten daarop wachten om de juiste volgorde te behouden. De kanttekening bij optie 2 geldt ook hier.
- De complexiteit verschuift van de classificatieservice naar BRP API Gebeurtenissen. Gebeurtenissen moet zelf de queues, de volgorde per persoon en de Dead-Letter Queue beheren.
- Er moet een proces komen waarmee meldingen kunnen worden gedaan over fouten die niet zijn ontstaan door bugs.

## Herstel van foute gebeurtenissen in de event store

Bij elke optie kunnen er foute gebeurtenissen in de event store terechtkomen. Een validatie vangt niet alle fouten af, en bugs in de classificatieservice of in BRP API Gebeurtenissen kunnen ervoor zorgen dat een gebeurtenis ten onrechte wordt gepubliceerd. Omdat de event store append-only is, kan zo'n fout alleen worden hersteld met een nieuwe gebeurtenis.

Uitgangspunten:
- Een foute gebeurtenis die niet bij het publiceren is gedetecteerd, wordt gecorrigeerd met een interne correctiegebeurtenis in de event store. Zo blijven de gegevens in BRP API Gebeurtenissen consistent met de BRP.
- Het doel van deze ADR is om zoveel mogelijk fouten bij het publiceren te voorkomen. Een uitgebreide oplossing om achteraf te corrigeren is daarom geen doel op zich. Hoe minder foute gebeurtenissen er in de event store komen, hoe minder er achteraf hoeft te worden gecorrigeerd.

## Beslissing

Wordt bepaald na het bespreken van de opties.

## Gerelateerde ADRs

- [ADR 004: Event-Driven Architecture voor de BRP API](./004-event-driven-architecture.md)
- [ADR 007: Gebruik (interne) persoonsidentificatie voor personen in gebeurtenissen](./007-persoonsidentificatie-in-gebeurtenissen.md)

## Bijlage: ontbrekende controles op een meerdere keren uitgegeven burgerservicenummer in bestaande BRP API's

De volgende voorbeelden laten zien dat zelfs de bestaande BRP API's de controle op een meerdere keren uitgegeven burgerservicenummer niet consequent uitvoeren. Als dat al misgaat binnen de BRP API, is het niet realistisch om bij optie 1 te verwachten dat alle afnemers deze fouten zelf correct afvangen.

In de Personen Bevragen API worden bij het raadplegen met burgerservicenummer geen personen geleverd als het opgegeven burgerservicenummer meerdere keren is uitgegeven. Dezelfde controle is echter niet geïmplementeerd bij bijvoorbeeld zoeken met geslachtsnaam en geboortedatum:

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

Ook in de Bewoning API ontbreekt deze controle. Twee personen met hetzelfde burgerservicenummer worden als aparte bewoners op hetzelfde adres geleverd:

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