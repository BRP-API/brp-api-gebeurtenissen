# language: nl
Functionaliteit: Protocolleren van verstrekte gebeurtenissen
  Het verstrekken van gegevens van burgers worden "geprotocolleerd" (formeel gelogd met als doel de burger te informeren 
  over welke instantie voor welke taak welke gegevens heeft geraadpleegd).

  Er wordt geprotocolleerd dat een gebeurtenis van persoon is verstrekt aan een afnemer.
  Dit wordt aangegeven door rubrieknummer 'PA.GB.01' op te nemen in 'request_zoek_rubrieken' en in 'request_gevraagde_rubrieken'.
  Dit betekent dat
  - er geen onderscheid gemaakt wordt in gebeurtenistype
  - er niet vastgelegd wordt welke gegevens meegeleverd zijn (burgerservicenummer en bijv. datum aanvang adreshouding of overlijdensdatum)

  Er wordt geprotocolleerd per verstrekking wat betekent dat:
  - als dezelfde gebeurtenis in twee responses wordt geleverd aan dezelfde afnemer (en zelfs dezelfde abonnee), dit twee keer wordt geprotocolleerd
  - als verschillende gebeurtenissen van dezelfde persoon in één response worden geleverd, dit als één verstrekking wordt geprotocolleerd

  Achtergrond:
    Gegeven de persoon 'Jan' is geregistreerd in de BRP
    En de persoon 'Piet' is geregistreerd in de BRP

  Regel: Als een afnemer een gebeurtenis verstrekt krijgt, dan wordt dit geprotocolleerd
    Dus NIET geprotocollerd wordt:
    - dat een (abonnee van een) afnemer een abonnement heeft op een persoon
    - dat er een gebeurtenis heeft plaatsgevonden waar een (abonnee van een) afnemer op geabonneerd is

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
      Gegeven abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op gebeurtenissen van 'Jan'
      En abonnee 'szw' van afnemer 'Gemeente Hengelo' heeft een abonnement op gebeurtenissen van 'Jan'
      En er is een gebeurtenis gepubliceerd van 'Jan'
      En abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft de gebeurtenis verstrekt gekregen
      En abonnee 'szw' van afnemer 'Gemeente Hengelo' heeft de gebeurtenis verstrekt gekregen
      Dan is geprotocolleerd dat een gebeurtenis van 'Jan' is verstrekt aan afnemer 'Gemeente Amsterdam'
      En is geprotocolleerd dat een gebeurtenis van 'Jan' is verstrekt aan afnemer 'Gemeente Hengelo'

  Regel: Als meerdere abonnees van dezelfde afnemer dezelfde gebeurtenis verstrekt krijgen, dan wordt elke verstrekking geprotocolleerd

    Scenario: Er zijn meerdere gebeurtenissen verstrekt aan verschillende abonnees van dezelfde afnemer
      Gegeven abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op gebeurtenissen van 'Jan'
      En abonnee 'szw' van afnemer 'Gemeente Amsterdam' heeft een abonnement op gebeurtenissen van 'Jan'
      En er is een gebeurtenis gepubliceerd van 'Jan'
      En abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft de gebeurtenis verstrekt gekregen
      En abonnee 'szw' van afnemer 'Gemeente Amsterdam' heeft de gebeurtenis verstrekt gekregen
      Dan is 2 keer geprotocolleerd dat een gebeurtenis van 'Jan' is verstrekt aan afnemer 'Gemeente Amsterdam'

  Regel: Als een abonnee een gebeurtenis opnieuw verstrekt krijgt, wordt dit opnieuw geprotocolleerd

    Scenario: Een abonnee vraagt gebeurtenissen opnieuw en krijgt de gebeurtenis daardoor twee keer
      Gegeven abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een gebeurtenis verstrekt gekregen van 'Jan'
      En abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft de gebeurtenis opnieuw verstrekt gekregen
      Dan is 2 keer geprotocolleerd dat een gebeurtenis van 'Jan' is verstrekt aan afnemer 'Gemeente Amsterdam'
