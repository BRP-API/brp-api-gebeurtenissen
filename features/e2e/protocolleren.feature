# language: nl
Functionaliteit: Protocolleren van verstrekte gebeurtenissen
  Het verstrekken van gegevens van burgers worden "geprotocolleerd". 
  Met protocolleren wordt vastgelegd dat gegevens van een persoon verstrekt zijn aan een afnemer.
  De burger kan hiervan een rapport vragen.

  De gebeurtenissen API hoeft alleen de verstrekkingen vast te leggen. 
  Overige functies bij RvIG, zoals BRP-V en Protocollering Overzicht Module (POM) verwerken dit.

  Protocolleren gaat alleen over het verstrekken van gegevens, niet over het abonneren hierop.

  Er wordt geprotocolleerd dat een gebeurtenis van persoon is verstrekt aan een afnemer.
  Dit is het geval wanneer bij het vragen van gebeurtenissen door een abonnee daadwerkelijk gebeurtenissen zijn geleverd.

  We schrijven de protocollering in de tabel "haalcentraal_gebeurtenissen" in de haalcentraal database.

  In de protocollering wordt het elementnummer voor het gebeurtenistype opgenomen plus het elementnummer voor elk meeverstrekt gegeven.
  De elementnummers worden opgenomen zowel in kolommen "request_zoek_rubrieken" en  "request_gevraagde_rubrieken".

  Regel: Als een afnemer een gebeurtenis verstrekt krijgt, dan wordt dit geprotocolleerd
    
    Scenario: Een gebeurtenis is verstrekt
      Gegeven abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een gebeurtenis verstrekt gekregen van 'Jan'
      Dan is geprotocolleerd dat een gebeurtenis van 'Jan' is verstrekt aan afnemer 'Gemeente Amsterdam'

    Scenario: Een gebeurtenis is nog niet verstrekt
      Gegeven abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op 'Jan' voor 'nl.brp.verhuisd.intergemeentelijk' gebeurtenissen
      En er is een 'nl.brp.verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor persoon 'Jan'
      Dan is er geen protocollering van de gebeurtenis van 'Jan'

  Regel: Als een abonnee meerdere gebeurtenissen voor verschillende personen verstrekt krijgt, dan wordt voor elke persoon waarvoor een gebeurtenis is verstrekt geprotocolleerd

    Scenario: Er zijn meerdere gebeurtenissen verstrekt voor verschillende personen
      Gegeven abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een gebeurtenis verstrekt gekregen van 'Jan'
      En abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een gebeurtenis verstrekt gekregen van 'Piet'
      Dan is geprotocolleerd dat een gebeurtenis van 'Jan' is verstrekt aan afnemer 'Gemeente Amsterdam'
      En is geprotocolleerd dat een gebeurtenis van 'Piet' is verstrekt aan afnemer 'Gemeente Amsterdam'

  Regel: Als een abonnee in één request meerdere gebeurtenissen voor dezelfde persoon verstrekt krijgt, dan wordt elke geleverde gebeurtenis apart geprotocolleerd

    Scenario: Er zijn meerdere gebeurtenissen verstrekt van dezelfde persoon
      Gegeven abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft twee gebeurtenissen verstrekt gekregen van 'Jan'
      Dan is 2 keer geprotocolleerd dat een gebeurtenis van 'Jan' is verstrekt aan afnemer 'Gemeente Amsterdam'

  Regel: Als meerdere afnemers dezelfde gebeurtenis verstrekt krijgen, dan wordt elke verstrekking geprotocolleerd

    Scenario: Er zijn meerdere gebeurtenissen verstrekt aan abonnees van verschillende afnemers
      Gegeven abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een gebeurtenis verstrekt gekregen van 'Jan'
      En abonnee 'szw' van afnemer 'Gemeente Hengelo' heeft een gebeurtenis verstrekt gekregen van 'Jan'
      Dan is geprotocolleerd dat een gebeurtenis van 'Jan' is verstrekt aan afnemer 'Gemeente Amsterdam'
      En is geprotocolleerd dat een gebeurtenis van 'Jan' is verstrekt aan afnemer 'Gemeente Hengelo'

  Regel: Als meerdere abonnees van dezelfde afnemer dezelfde gebeurtenis verstrekt krijgen, dan wordt elke verstrekking geprotocolleerd

    Scenario: Er zijn meerdere gebeurtenissen verstrekt aan verschillende abonnees van dezelfde afnemer
      Gegeven abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een gebeurtenis verstrekt gekregen van 'Jan'
      En abonnee 'szw' van afnemer 'Gemeente Amsterdam' heeft een gebeurtenis verstrekt gekregen van 'Jan'
      Dan is 2 keer geprotocolleerd dat een gebeurtenis van 'Jan' is verstrekt aan afnemer 'Gemeente Amsterdam'

  Regel: Als een abonnee een gebeurtenis opnieuw verstrekt krijgt, wordt dit opnieuw geprotocolleerd

    Scenario: Een abonnee vraagt gebeurtenissen opnieuw en krijgt de gebeurtenis daardoor twee keer
      Gegeven abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een gebeurtenis verstrekt gekregen van 'Jan'
      En abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft de gebeurtenis van 'Jan' opnieuw verstrekt gekregen
      Dan is 2 keer geprotocolleerd dat een gebeurtenis van 'Jan' is verstrekt aan afnemer 'Gemeente Amsterdam'

  Regel: In de protocollering van een gebeurtenis wordt het Request-ID van het vraagrequest opgenomen
    De request header 'Request-ID' in het GET request om de gebeurtenissen te vragen 
    wordt gevuld in kolom request_id van de protocollering.

    Scenario: Een gebeurtenis is verstrekt en de Request-ID wordt opgenomen in de protocollering
      Gegeven abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een gebeurtenis verstrekt gekregen van 'Jan'
      Dan is 'request_id' in de protocollering van 'Jan' gelijk aan de waarde in request header Request-ID van de vraag om gebeurtenissen

  Regel: In de protocollering van een gebeurtenis wordt de afnemerID uit de claims van de afnemer opgenomen
    De afnemerID uit de claims in het token dat gestuurd is bij het GET request om de gebeurtenissen te vragen
    wordt gevuld in kolom afnemer_code van de protocollering.

    Scenario: Een gebeurtenis is verstrekt en de afnemerID wordt opgenomen in de protocollering
      Gegeven abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een gebeurtenis verstrekt gekregen van 'Jan'
      Dan is 'afnemer_code' in de protocollering van 'Jan' gelijk aan de waarde in afnemerID in de claims in de token bij de vraag om gebeurtenissen

  Regel: In de protocollering van een gebeurtenis wordt de pl_id uit de claims van de afnemer opgenomen
    De technische sleutel van de persoonslijst in de database 'pl_id' van de persoon waarvan de gebeurtenis is verstrekt
    wordt gevuld in kolom pl_id van de protocollering.

    Scenario: Een gebeurtenis is verstrekt en de pl_id wordt opgenomen in de protocollering
      Gegeven abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een gebeurtenis verstrekt gekregen van 'Jan'
      Dan is 'pl_id' in de protocollering van 'Jan' gelijk aan de waarde van de pl_id van 'Jan'

  Regel: In de protocollering van een gebeurtenis wordt verwerkt met waarde false opgenomen
    De vaste booleanwaarde false
    wordt gevuld in kolom verwerkt van de protocollering.

    Hiermee is zichtbaar dat de protocollering nog niet verwerkt is door de BRP-V. 
    Na overzetten van de protocollering naar BRP-V, wordt de waarde true. 
    Het overzetten naar de BRP-V, en daarmee het wijzigen naar waarde true, valt buiten de scope van de gebeurtenissen API (en dus van deze feature).

    Scenario: Een gebeurtenis is verstrekt en de protocollering krijgt initieel de aanduiding dat deze niet verwerkt is
      Gegeven abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een gebeurtenis verstrekt gekregen van 'Jan'
      Dan is 'verwerkt' in de protocollering van 'Jan' gelijk aan true

  Regel: In de protocollering van gebeurtenistype "nl.brp.verhuisd.naar-buitenland" wordt rubrieken "GX.VH.01, 010120, PAVP01" opgenomen
    Dit wordt opgenomen in kolommen "request_zoek_rubrieken" en  "request_gevraagde_rubrieken" van de protocollering.

    Uitleg van de opgenomen rubrieken:
    - GX.VH.01: gebeurtenistype verhuisd.naar-buitenland
    - 010120: burgerservicenummer
    - PAVP01: verblijfplaats datumVan

    Scenario: Een verhuisd naar buitenland gebeurtenis is verstrekt en de verstrekte rubrieken worden opgenomen in de protocollering
      Gegeven abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een 'verhuisd.naar-buitenland' gebeurtenis verstrekt gekregen van 'Jan'
      Dan is 'request_zoek_rubrieken' in de protocollering van 'Jan' gelijk aan 'GX.VH.01, 010120, PAVP01'
      En is 'request_gevraagde_rubrieken' in de protocollering van 'Jan' gelijk aan 'GX.VH.01, 010120, PAVP01'

  Regel: In de protocollering van gebeurtenistype "nl.brp.verhuisd.intergemeentelijk" wordt rubrieken "GX.VH.02, 010120, PAVP01" opgenomen
    Dit wordt opgenomen in kolommen "request_zoek_rubrieken" en "request_gevraagde_rubrieken" van de protocollering.

    Uitleg van de opgenomen rubrieken:
    - GX.VH.02: gebeurtenistype verhuisd.intergemeentelijk
    - 010120: burgerservicenummer
    - PAVP01: verblijfplaats datumVan

    Scenario: Een verhuisd intergemeentelijk gebeurtenis is verstrekt en de verstrekte rubrieken worden opgenomen in de protocollering
      Gegeven abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een 'verhuisd.intergemeentelijk' gebeurtenis verstrekt gekregen van 'Jan'
      Dan is 'request_zoek_rubrieken' in de protocollering van 'Jan' gelijk aan 'GX.VH.02, 010120, PAVP01'
      En is 'request_gevraagde_rubrieken' in de protocollering van 'Jan' gelijk aan 'GX.VH.02, 010120, PAVP01'

  Regel: In de protocollering van gebeurtenistype "nl.brp.overleden" wordt rubrieken "GX.OV.01, 010120, 060810" opgenomen
    Dit wordt opgenomen in kolommen "request_zoek_rubrieken" en "request_gevraagde_rubrieken" van de protocollering.

    Uitleg van de opgenomen rubrieken:
    - GX.OV.01: gebeurtenistype overleden
    - 010120: burgerservicenummer
    - 060810: datum overlijden

    Scenario: Een overleden gebeurtenis is verstrekt en de verstrekte rubrieken worden opgenomen in de protocollering
      Gegeven abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een 'overleden' gebeurtenis verstrekt gekregen van 'Jan'
      Dan is 'request_zoek_rubrieken' in de protocollering van 'Jan' gelijk aan 'GX.OV.01, 010120, PAVP01'
      En is 'request_gevraagde_rubrieken' in de protocollering van 'Jan' gelijk aan 'GX.OV.01, 010120, PAVP01'
