# language: nl
Functionaliteit: Voeg gebeurtenistype toe aan groep
  Als afnemer van BRP API Gebeurtenissen
  wil ik kunnen bepalen voor welke (set) gebeurtenistypen elke taakapplicatie zich mag abonneren, 
  zodat ik geen applicatie hoef te maken die controleert dat taakapplicaties alleen abonnementen zetten waar ze geautoriseerd voor zijn.

  Regel: Een afnemer kan een gebeurtenistype toevoegen aan een bestaande groep

    Scenario: Een afnemer voegt een gebeurtenistype toe aan een toegevoegde groep van een geregistreerde abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' het gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk' aan de groep 'client' toevoegt
      Dan is de response '201 Created'

  Regel: Een 'GebeurtenistypeToegevoegd' gebeurtenis wordt gepubliceerd wanneer een gebeurtenistype succesvol is toegevoegd aan een groep

    @skip-verify
    Scenario: Een afnemer voegt een gebeurtenistype toe aan een groep
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' het gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk' aan de groep 'client' toevoegt
      Dan is een 'GebeurtenistypeToegevoegd' gebeurtenis gepubliceerd met de volgende velden
        | afnemerId          | abonneeNaam | groepNaam | gebeurtenisType                   |
        | Gemeente Amsterdam | jz          | client    | nl.brp.verhuisd.intergemeentelijk |
      # Deze Dan stap kan niet worden ge-automate. Met de API van Axon Server kan geen gebeurtenissen worden bevraagd die zijn gepubliceerd conform Dynamic Boundary Context

  Regel: Alleen een geldig gebeurtenistype kan worden toegevoegd aan een groep

    Scenario: Een afnemer voegt een onbekend gebeurtenistype toe aan een groep
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' het gebeurtenistype 'nl.brp.bestaat-niet' aan de groep 'client' toevoegt
      Dan is de response '400 Bad Request' met de volgende velden
      * 'title' met tekst 'gebeurtenistype is ongeldig'
      * heeft de response invalidParams met de volgende gegevens
        | code            | name            | reason                                   |
        | Gebeurtenistype | gebeurtenistype | gebeurtenistype is geen Gebeurtenistype. |

    Abstract Scenario: Een afnemer voegt geldig gebeurtenistype '<gebeurtenistype>' toe
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' het gebeurtenistype '<gebeurtenistype>' aan de groep 'client' toevoegt
      Dan is de response '201 Created'

      Voorbeelden:
        | gebeurtenistype                   |
        | nl.brp.verhuisd.intergemeentelijk |
        | nl.brp.verhuisd.naar-buitenland   |
        | nl.brp.overleden                  |

  Regel: Een gebeurtenistype is uniek binnen de context van een groep

    Scenario: Het gebeurtenistype is al toegevoegd aan de groep
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' het gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk' aan de groep 'client' toegevoegd
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' het gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk' aan de groep 'client' toevoegt
      Dan is de response '409 Conflict' met de volgende velden
      * 'title' met tekst 'Gebeurtenistype bestaat al'

    Scenario: Het opgegeven gebeurtenistype is al geregistreerd bij een andere groep van dezelfde abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'relatie' toegevoegd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' het gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk' aan de groep 'client' toegevoegd
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' het gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk' aan de groep 'relatie' toevoegt
      Dan is de response '201 Created'
      # Dan is een 'GebeurtenistypeToegevoegd' gebeurtenis gepubliceerd met de volgende velden
      #   | afnemerId          | abonneeNaam | groepNaam | gebeurtenisType                   |
      #   | Gemeente Amsterdam | jz          | relatie   | nl.brp.verhuisd.intergemeentelijk |

    Scenario: Het opgegeven gebeurtenistype is al toegevoegd bij een andere abonnee op dezelfde groepnaam
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      En de afnemer 'Gemeente Amsterdam' heeft de abonnee 'szw' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'szw' de groep 'client' toegevoegd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'szw' het gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk' aan de groep 'client' toegevoegd
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' het gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk' aan de groep 'client' toevoegt
      Dan is de response '201 Created'
      # Dan is een 'GebeurtenistypeToegevoegd' gebeurtenis gepubliceerd met de volgende velden
      #   | afnemerId          | abonneeNaam | groepNaam | gebeurtenisType                   |
      #   | Gemeente Amsterdam | jz          | client    | nl.brp.verhuisd.intergemeentelijk |

    Scenario: Het opgegeven gebeurtenistype is al toegevoegd bij een andere afnemer op dezelfde abonneenaam en dezelfde groepnaam
      Gegeven de afnemer 'Gemeente Rotterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Rotterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      En de afnemer 'Gemeente Rotterdam' heeft bij de abonnee 'jz' het gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk' aan de groep 'client' toegevoegd
      En de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' het gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk' aan de groep 'client' toevoegt
      Dan is de response '201 Created'
      # Dan is een 'GebeurtenistypeToegevoegd' gebeurtenis gepubliceerd met de volgende velden
      #   | afnemerId          | abonneeNaam | groepNaam | gebeurtenisType                   |
      #   | Gemeente Amsterdam | jz          | client    | nl.brp.verhuisd.intergemeentelijk |

  Regel: Een gebeurtenistype kan alleen worden toegevoegd aan een groep van de abonnee

    Scenario: Een afnemer voegt een gebeurtenistype toe aan een nog niet toegevoegde groep
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' het gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk' aan de groep 'client' toevoegt
      Dan is de response '404 Not Found' met de volgende velden
      * 'title' met tekst 'Groep bestaat niet'

    Scenario: Een afnemer voegt een gebeurtenistype toe aan een groep die alleen bestaat bij een andere abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      En de afnemer 'Gemeente Amsterdam' heeft de abonnee 'szw' geregistreerd
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'szw' het gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk' aan de groep 'client' toevoegt
      Dan is de response '404 Not Found' met de volgende velden
      * 'title' met tekst 'Groep bestaat niet'

    Scenario: Een afnemer voegt een gebeurtenistype toe aan een groep die alleen bestaat bij een andere afnemer
      Gegeven de afnemer 'Gemeente Rotterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Rotterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      En de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' het gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk' aan de groep 'client' toevoegt
      Dan is de response '404 Not Found' met de volgende velden
      * 'title' met tekst 'Groep bestaat niet'

    Scenario: Een afnemer voegt een gebeurtenistype toe aan een verwijderde groep
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' verwijderd
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' het gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk' aan de groep 'client' toevoegt
      Dan is de response '404 Not Found' met de volgende velden
      * 'title' met tekst 'Groep bestaat niet'

  Regel: Een gebeurtenistype kan alleen worden toegevoegd aan een groep van een geregistreerde abonnee

    Scenario: Een afnemer voegt een gebeurtenistype toe aan een nog niet geregistreerde abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'szw' het gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk' aan de groep 'client' toevoegt
      Dan is de response '404 Not Found' met de volgende velden
      * 'title' met tekst 'Abonnee bestaat niet'

    Scenario: Een afnemer voegt een gebeurtenistype toe aan een gederegistreerde abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      En de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' gederegistreerd
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' het gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk' aan de groep 'client' toevoegt
      Dan is de response '404 Not Found' met de volgende velden
      * 'title' met tekst 'Abonnee bestaat niet'
