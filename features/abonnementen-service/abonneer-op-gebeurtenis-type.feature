# language: nl
Functionaliteit: Abonneer op een gebeurtenis van een persoon
  Als abonnee van BRP API Gebeurtenissen
  wil ik mij kunnen abonneren op specifieke gebeurtenissen van personen aan wie ik diensten verleen
  zodat ik alleen die gebeurtenissen krijg die noodzakelijk zijn voor het starten van een proces binnen mijn wettelijke taak

  Regel: Een abonnement op een gebeurtenis van een persoon kan alleen worden genomen door een abonnee
  
    Scenario: Een afnemer heeft geen abonnee geregistreerd en probeert een abonnement te nemen op een gebeurtenis van een persoon
      Als een afnemer zonder abonnees een abonnement op een gebeurtenis van een persoon wil nemen
      Dan is de response '404 Not Found'

    Scenario: Een afnemer geeft een niet-geregistreerde abonnee op bij het nemen van een abonnement op een gebeurtenis van een persoon
      Als een afnemer met een niet-geregistreerde abonnee een abonnement op een gebeurtenis van een persoon wil nemen
      Dan is de response '404 Not Found'

  Regel: Bij het nemen van een abonnement op een gebeurtenis van een persoon moet een geldig gebeurtenistype worden opgegeven. Geldige gebeurtenistypes zijn:
         - verhuisd.intergemeentelijk

    Scenario: De opgegeven gebeurtenistype bestaat niet
      Als een abonnee zich abonneert op een ongeldige gebeurtenis van een persoon
      Dan is de response '400 Bad Request' met de volgende velden
      * 'detail' met tekst 'Het opgegeven gebeurtenistype is ongeldig.'

  Regel: Bij het nemen van een abonnement op een gebeurtenis van een persoon moet het burgerservicenummer van een in de BRP geregistreerde persoon worden opgegeven

    Scenario: Het opgegeven burgerservicenummer bestaat niet uit 9 cijfers
      Als een abonnee zich abonneert op een gebeurtenis van een persoon met een ongeldig burgerservicenummer
      Dan is de response '400 Bad Request' met de volgende velden
      * 'detail' met tekst 'Het opgegeven burgerservicenummer is ongeldig.'

    Scenario: Een onbekend burgerservicenummer is opgegeven
      Als een abonnee zich abonneert op een gebeurtenis van een onbekende persoon
      Dan is de response '400 Bad Request' met de volgende velden
      * 'detail' met tekst 'Er bestaat geen persoon met het opgegeven burgerservicenummer.'

  @wip @issue-107
  Regel: Bij het nemen van een abonnement op een gebeurtenis van een persoon mag de persoonslijst van de persoon niet zijn opgeschort

    @skip-verify
    Scenario: De opgegeven burgerservicenummer is van een persoon wiens persoonslijst is opgeschort
      Gegeven de persoon 'Jan' is geregistreerd in de BRP en zijn persoonslijst is opgeschort
      Als een abonnee zich abonneert op een gebeurtenis van 'Jan'
      Dan is de response '400 Bad Request' met de volgende velden
      * 'detail' met tekst 'Er kan geen abonnement worden genomen op gebeurtenissen van deze persoon omdat zijn persoonslijst is opgeschort.'

  Regel: Een 'AbonnementGeregistreerd' gebeurtenis wordt gepubliceerd wanneer een abonnement succesvol is geregistreerd

    Scenario: Een abonnee abonneert zich op een geldig gebeurtenistype van een persoon die in de BRP is geregistreerd
      Gegeven de persoon 'Jan' is geregistreerd in de BRP
      Als de abonnee 'szw' van afnemer 'Gemeente Den Haag' zich abonneert op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      Dan is de response '201 Created'
      En is een 'AbonnementGeregistreerd' gebeurtenis gepubliceerd met de volgende velden
        | afnemerId         | abonneeNaam | gebeurtenistype            | anummer |
        | Gemeente Den Haag | szw         | verhuisd.intergemeentelijk | Jan     |

  Regel: Een abonnee mag niet meerdere keren een abonnement nemen op dezelfde gebeurtenistype bij dezelfde persoon

    Scenario: De abonnee heeft al een abonnement genomen op de opgegeven gebeurtenistype en persoon
      Gegeven de persoon 'Jan' is geregistreerd in de BRP
      En de abonnee 'szw' van afnemer 'Gemeente Den Haag' heeft een abonnement op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      Als de abonnee 'szw' van afnemer 'Gemeente Den Haag' zich weer abonneert op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      Dan is de response '409 Conflict' met de volgende velden
      * 'detail' met tekst 'U heeft al een abonnement genomen op opgegeven gebeurtenistype en persoon.'

    Scenario: Een andere abonnee heeft een abonnement genomen op de opgegeven gebeurtenistype en persoon
      Gegeven de persoon 'Jan' is geregistreerd in de BRP
      En de abonnee 'szw' van afnemer 'Gemeente Den Haag' heeft een abonnement op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      Als de abonnee 'jz' van afnemer 'Gemeente Den Haag' zich abonneert op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      Dan is er een 'AbonnementGeregistreerd' gebeurtenis gepubliceerd
