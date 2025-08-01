# language: nl
Functionaliteit: Notificatie bij toevoegen van kindgegevens

De procedure 'Toevoegen kindgegevens' wordt uitgevoerd zodra geconstateerd is dat een kind nog niet is opgenomen op de persoonslijst van een ingezetene.
Dit kan bijvoorbeeld zijn:
- het toevoegen van ontbrekende kindgegevens op de persoonslijst van de ouder, bijvoorbeeld na een intergemeentelijke adreswijziging
- het toevoegen van kindgegevens op basis van een Nederlandse akte
- het toevoegen van kindgegevens op basis van een brondocument

Zie https://www.rvig.nl/hup/toevoegen-kindgegevens

  Scenario: Notificatie bij toevoegen van ontbrekende kindgegevens:
    Gegeven afnemer '000008' wilt worden genotificeerd over 'KindgegevensToegevoegd' gebeurtenissen
    En persoon 'Jan' heeft de volgende gegevens
      | voornamen | geslachtsnaam | geboortedatum | geboorteplaats | geboorteland |
      | Jan       | Janssen       |    1980-01-01 | 's-Gravenhage  | Nederland    |
    En 'Jan' is ingeschreven in de BRP
    En persoon 'Piet' heeft de volgende gegevens
      | voornamen | geslachtsnaam | geboortedatum | geboorteplaats | geboorteland |
      | Piet      | Janssen       |    2010-01-01 | 's-Gravenhage  | Nederland    |
    En 'Piet' is ingeschreven in de BRP
    Wanneer 'Piet' wordt toegevoegd als kind van 'Jan' op basis van de persoonslijst van het kind
    Dan ontvangt afnemer '000008' een notificatie over de gebeurtenis 'KindgegevensToegevoegd' met de volgende gegevens
      | specversion | type                   | id | source                          |
      |         1.0 | KindgegevensToegevoegd |  1 | brp-gebeurtenissen-notificaties |

  Scenario: Notificatie bij toevoegen van kindgegevens op basis van een Nederlandse akte:
    Gegeven afnemer '000008' wilt worden genotificeerd over 'KindgegevensToegevoegd' gebeurtenissen
    En persoon 'Jan' heeft de volgende gegevens
      | voornamen | geslachtsnaam | geboortedatum | geboorteplaats | geboorteland |
      | Jan       | Janssen       |    1980-01-01 | 's-Gravenhage  | Nederland    |
    En 'Jan' is ingeschreven in de BRP
    En persoon 'Piet' heeft de volgende gegevens
      | voornamen | geslachtsnaam | geboortedatum | geboorteplaats | geboorteland |
      | Piet      | Janssen       |    2010-01-01 | 's-Gravenhage  | Nederland    |
    En 'Piet' is ingeschreven in de BRP
    Wanneer 'Piet' wordt toegevoegd als kind van 'Jan' op basis van een Nederlandse akte met de volgende gegevens
      | aktenummer | ingangsdatum geldigheid |
      |    1AA0789 |              2010-01-01 |
    Dan ontvangt afnemer '000008' een notificatie over de gebeurtenis 'KindgegevensToegevoegd' met de volgende gegevens
      | specversion | type                   | id | source                          |
      |         1.0 | KindgegevensToegevoegd |  1 | brp-gebeurtenissen-notificaties |

  Scenario: Notificatie bij toevoegen van kindgegevens op basis van brondocument:
    Gegeven afnemer '000008' wilt worden genotificeerd over 'KindgegevensToegevoegd' gebeurtenissen
    En persoon 'Jan' heeft de volgende gegevens
      | voornamen | geslachtsnaam | geboortedatum | geboorteplaats | geboorteland |
      | Jan       | Janssen       |    1980-01-01 | 's-Gravenhage  | Nederland    |
    En 'Jan' is ingeschreven in de BRP
    En persoon 'Piet' heeft de volgende gegevens
      | voornamen | geslachtsnaam | geboortedatum | geboorteplaats | geboorteland |
      | Piet      | Janssen       |    2010-01-01 | Brugge         | België       |
    En 'Piet' is ingeschreven in de BRP
    Wanneer 'Piet' wordt toegevoegd als kind van 'Jan' op basis van een brondocument met de volgende gegevens
      | beschrijving document | ingangsdatum geldigheid |
      | ga 5010               |              2010-01-01 |
    Dan ontvangt afnemer '000008' een notificatie over de gebeurtenis 'KindgegevensToegevoegd' met de volgende gegevens
      | specversion | type                   | id | source                          |
      |         1.0 | KindgegevensToegevoegd |  1 | brp-gebeurtenissen-notificaties |
