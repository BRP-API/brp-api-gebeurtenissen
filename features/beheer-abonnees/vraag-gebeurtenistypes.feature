# language: nl
Functionaliteit: Vraag welke gebeurtenistypes er zitten in een groep
  Als afnemer van BRP API Gebeurtenissen
  wil ik zien welke gebeurtenistypes er zitten in een groep van een abonnee
  zodat ik de groepen van mijn abonnees goed kan beheren

  Regel: Een afnemer ontvangt de gebeurtenistypes in de opgegeven groep

    Scenario: De abonnee heeft meerdere groepen
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client'
      En groep 'client' bij abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk en nl.brp.verhuisd.naar-buitenland'
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'relatie'
      En groep 'relatie' bij abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft gebeurtenistype 'nl.brp.overleden'
      Als de afnemer 'Gemeente Amsterdam' de gebeurtenistypes van groep 'client' van abonnee 'jz' opvraagt
      Dan worden volgende gebeurtenistypes geleverd
        | gebeurtenistype                   |
        | nl.brp.verhuisd.intergemeentelijk |
        | nl.brp.verhuisd.naar-buitenland   |

  Regel: Een afnemer ontvangt de gebeurtenistypes van de opgegeven abonnee

    Scenario: De afnemer heeft meerdere abonnees met een groep met dezelfde naam
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client'
      En groep 'client' bij abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk en nl.brp.verhuisd.naar-buitenland'
      En de afnemer 'Gemeente Amsterdam' heeft de abonnee 'szw' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'szw' de groep 'client'
      En groep 'client' bij abonnee 'szw' van afnemer 'Gemeente Amsterdam' heeft gebeurtenistype 'nl.brp.overleden'
      Als de afnemer 'Gemeente Amsterdam' de gebeurtenistypes van groep 'client' van abonnee 'jz' opvraagt
      Dan worden volgende gebeurtenistypes geleverd
        | gebeurtenistype                   |
        | nl.brp.verhuisd.intergemeentelijk |
        | nl.brp.verhuisd.naar-buitenland   |

  Regel: Een afnemer ontvangt de gebeurtenistypes van de eigen abonnee en groep

    Scenario: De afnemer en een andere afnemer hebben een abonnee met dezelfde naam en daarin een groep met dezelfde naam
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client'
      En groep 'client' bij abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk en nl.brp.verhuisd.naar-buitenland'
      En de afnemer 'Gemeente Rotterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Rotterdam' heeft bij de abonnee 'jz' de groep 'client'
      En groep 'client' bij abonnee 'jz' van afnemer 'Gemeente Rotterdam' heeft gebeurtenistype 'nl.brp.overleden'
      Als de afnemer 'Gemeente Amsterdam' de gebeurtenistypes van groep 'client' van abonnee 'jz' opvraagt
      Dan worden volgende gebeurtenistypes geleverd
        | gebeurtenistype                   |
        | nl.brp.verhuisd.intergemeentelijk |
        | nl.brp.verhuisd.naar-buitenland   |

  Regel: De gebeurtenistypes kunnen alleen worden gevraagd van een groep van de abonnee

    Scenario: Een afnemer vraagt gebeurtenistypes van een nog niet toegevoegde groep
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      Als de afnemer 'Gemeente Amsterdam' de gebeurtenistypes van groep 'client' van abonnee 'jz' opvraagt
      Dan is de response '404 Not Found' met de volgende velden
      * 'title' met tekst 'Groep bestaat niet'

    Scenario: Een afnemer vraagt gebeurtenistypes van een groep die alleen bestaat bij een andere abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft de abonnee 'szw' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'szw' de groep 'client' toegevoegd
      Als de afnemer 'Gemeente Amsterdam' de gebeurtenistypes van groep 'client' van abonnee 'jz' opvraagt
      Dan is de response '404 Not Found' met de volgende velden
      * 'title' met tekst 'Groep bestaat niet'

    Scenario: Een afnemer vraagt gebeurtenistypes van een groep die alleen bestaat bij een andere afnemer
      Gegeven de afnemer 'Gemeente Rotterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Rotterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      En de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      Als de afnemer 'Gemeente Amsterdam' de gebeurtenistypes van groep 'client' van abonnee 'jz' opvraagt
      Dan is de response '404 Not Found' met de volgende velden
      * 'title' met tekst 'Groep bestaat niet'

    Scenario: Een afnemer vraagt gebeurtenistypes van een verwijderde groep
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      En groep 'client' bij abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk'
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' verwijderd
      Als de afnemer 'Gemeente Amsterdam' de gebeurtenistypes van groep 'client' van abonnee 'jz' opvraagt
      Dan is de response '404 Not Found' met de volgende velden
      * 'title' met tekst 'Groep bestaat niet'

  Regel: De gebeurtenistypes kunnen alleen worden gevraagd van een groep van een geregistreerde abonnee

     Scenario: Een afnemer vraagt gebeurtenistypes van een nog niet geregistreerde abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      Als de afnemer 'Gemeente Amsterdam' de gebeurtenistypes van groep 'client' van abonnee 'szw' opvraagt
      Dan is de response '404 Not Found' met de volgende velden
      * 'title' met tekst 'Abonnee bestaat niet'

     Scenario: Een afnemer vraagt gebeurtenistypes van een gederegistreerde abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      En groep 'client' bij abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk'
      En de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' gederegistreerd
      Als de afnemer 'Gemeente Amsterdam' de gebeurtenistypes van groep 'client' van abonnee 'jz' opvraagt
      Dan is de response '404 Not Found' met de volgende velden
      * 'title' met tekst 'Abonnee bestaat niet'
