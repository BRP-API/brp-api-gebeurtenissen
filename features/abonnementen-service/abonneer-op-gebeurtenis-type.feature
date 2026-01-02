# language: nl
@integratie
Functionaliteit: Abonneer op gebeurtenistype
  Als abonnee van BRP API Gebeurtenissen
  wil ik mij kunnen abonneren op specifieke gebeurtenissen van personen aan wie ik diensten verleen
  zodat ik alleen die gebeurtenissen krijg die noodzakelijk zijn voor het starten van een proces binnen mijn wettelijke taak

  Achtergrond:
    Gegeven de persoon 'Jan'
    En de persoon 'Piet'

  Regel: een abonnee kan een abonnement nemen op een gebeurtenistype voor een persoon

    Scenario: Een abonnee abonneert zich op een specifiek gebeurtenistype
      Gegeven de afnemer 'Gemeente Den Haag'
      * is geregistreerd als abonnee 'szw' van BRP API Gebeurtenissen
      Als de abonnee 'szw' van afnemer 'Gemeente Den Haag' zich abonneert op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      Dan is de response '201 Created'

  Regel: Alleen een als abonnee geregistreerde afnemer kan zich abonneren op gebeurtenistypes

    Scenario: Een niet-geregistreerde abonnee probeert zich te abonneren op een specifiek gebeurtenistype
      Gegeven de afnemer 'Gemeente Den Haag'
      * is niet geregistreerd als abonnee van BRP API Gebeurtenissen
      Als de abonnee 'szw' van afnemer 'Gemeente Den Haag' zich abonneert op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      Dan is de response '404 Not Found' met de volgende velden
      * 'instance' met tekst '/abonnees/mijn/abonnementen'
      * 'title' met tekst 'Abonnee niet gevonden'
      * 'detail' met tekst 'Uw verzoek kan niet worden uitgevoerd omdat de opgegeven abonnee niet gevonden is.'

  Regel: Een abonnee mag niet twee keer hetzelfde abonnement nemen
    zodat de abonnee weet dat er echt een abonnement is toegevoegd
    en daarmee een bestaand abonnement niet gewijzigd of overschreven wordt

    Elk abonnement dat genomen wordt moet uniek zijn binnen de context van de abonnee.
    Een abonnement is een unieke combinatie van abonnee (=afnemer + abonneenaam) en gebeurtenistype en persoon(identificatie).

    Scenario: Een abonnee neemt twee keer hetzelfde abonnement
      Gegeven de afnemer 'Gemeente Den Haag'
      * is geregistreerd als abonnee 'szw' van BRP API Gebeurtenissen
      En abonnee 'szw' van afnemer 'Gemeente Den Haag' is geabonneerd op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      Als de abonnee 'szw' van afnemer 'Gemeente Den Haag' zich abonneert op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      Dan is de response '409 Conflict' met de volgende velden
      * 'instance' met tekst '/abonnees/mijn/abonnementen'
      * 'title' met tekst 'Abonnement bestaat al'
      * 'detail' met tekst 'Uw verzoek kan niet worden uitgevoerd omdat er al een abonnement bestaat voor deze gebeurtenis en persoon.'

    Scenario: Twee abonnees van dezelfde afnemer nemen hetzelfde abonnement
      Gegeven de afnemer 'Gemeente Den Haag'
      * is geregistreerd als abonnee 'szw' van BRP API Gebeurtenissen
      * is geregistreerd als abonnee 'JZ' van BRP API Gebeurtenissen
      En abonnee 'JZ' van afnemer 'Gemeente Den Haag' is geabonneerd op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      Als de abonnee 'szw' van afnemer 'Gemeente Den Haag' zich abonneert op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      Dan is de response '201 Created'

    Scenario: Een abonnee abonneert zich voor hetzelfde gebeurtenistype op meerdere personen
      Gegeven de afnemer 'Gemeente Den Haag'
      * is geregistreerd als abonnee 'szw' van BRP API Gebeurtenissen
      En abonnee 'szw' van afnemer 'Gemeente Den Haag' is geabonneerd op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Piet'
      Als de abonnee 'szw' van afnemer 'Gemeente Den Haag' zich abonneert op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      Dan is de response '201 Created'

    Scenario: Een abonnee abonneert zich voor één persoon op meerdere gebeurtenistypes
      Gegeven de afnemer 'Gemeente Den Haag'
      * is geregistreerd als abonnee 'szw' van BRP API Gebeurtenissen
      En abonnee 'szw' van afnemer 'Gemeente Den Haag' is geabonneerd op de 'verhuisd.naar-buitenland' gebeurtenissen van 'Jan'
      Als de abonnee 'szw' van afnemer 'Gemeente Den Haag' zich abonneert op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      Dan is de response '201 Created'
