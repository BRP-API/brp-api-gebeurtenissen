# language: nl
Functionaliteit: Verwijder gebeurtenistype van een groep

  Regel: Een afnemer kan een eerder toegevoegd gebeurtenistype verwijderen uit een groep

    Scenario: Een afnemer verwijdert een gebeurtenistype uit een groep
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' het gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk' aan de groep 'client' toegevoegd
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' het gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk' uit de groep 'client' verwijdert
      Dan is de response '204 No Content'

  Regel: Een 'GebeurtenistypeVerwijderd' gebeurtenis wordt gepubliceerd wanneer een gebeurtenistype succesvol is verwijderd uit een groep

    Scenario: Een afnemer verwijdert een gebeurtenistype uit een groep
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' het gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk' aan de groep 'client' toegevoegd
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' het gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk' uit de groep 'client' verwijdert
      Dan is een 'GebeurtenistypeVerwijderd' gebeurtenis gepubliceerd met de volgende velden
        | afnemerId          | abonneeNaam | groepNaam | gebeurtenisType                   |
        | Gemeente Amsterdam | jz          | client    | nl.brp.verhuisd.intergemeentelijk |

  Regel: Alleen een gebeurtenistype dat in de groep zit kan worden verwijderd

    Scenario: Een afnemer verwijdert een gebeurtenistype die niet is toegevoegd
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' het gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk' aan de groep 'client' toegevoegd
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' het gebeurtenistype 'nl.brp.overleden' uit de groep 'client' verwijdert
      Dan is de response '404 Not Found' met de volgende velden
      * 'title' met tekst 'Gebeurtenistype bestaat niet'

    Scenario: Een afnemer verwijdert een reeds verwijderd gebeurtenistype
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' het gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk' aan de groep 'client' toegevoegd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' het gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk' uit de groep 'client' verwijderd
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' het gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk' uit de groep 'client' verwijdert
      Dan is de response '404 Not Found' met de volgende velden
      * 'title' met tekst 'Gebeurtenistype bestaat niet'

  Regel: Alleen een gebeurtenistype in een toegevoegde groep kan worden verwijderd

    Scenario: Een afnemer verwijdert een gebeurtenistype uit een groep die niet is toegevoegd
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' het gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk' uit de groep 'client' verwijdert
      Dan is de response '404 Not Found' met de volgende velden
      * 'title' met tekst 'Groep bestaat niet'

    Scenario: Een afnemer verwijdert een gebeurtenistype uit een al verwijderde groep
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' het gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk' aan de groep 'client' toegevoegd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' verwijderd
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' het gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk' uit de groep 'relatie' verwijdert
      Dan is de response '404 Not Found' met de volgende velden
      * 'title' met tekst 'Groep bestaat niet'

  Regel: Alleen een gebeurtenistype bij een geregistreerde abonnee kan worden verwijderd

    Scenario: Een afnemer verwijdert een gebeurtenistype met een groep die niet is toegevoegd
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'szw' het gebeurtenistype 'nl.brp.overleden' uit de groep 'client' verwijdert
      Dan is de response '409 Conflict' met de volgende velden
      * 'title' met tekst 'Abonnee bestaat niet'

    Scenario: Een afnemer verwijdert een gebeurtenistype uit groep van een gederegistreerde abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' het gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk' aan de groep 'client' toegevoegd
      En de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' gederegistreerd
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' het gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk' uit de groep 'client' verwijdert
      Dan is de response '404 Not Found' met de volgende velden
      * 'title' met tekst 'Abonnee bestaat niet'

  Regel: Een 'GebeurtenistypeVerwijderd' gebeurtenis wordt gepubliceerd voor elk gebeurtenistype van een groep die succesvol is verwijderd

    Scenario: Een afnemer deregistreert een abonnee met groepen met gebeurtenistypes
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' het gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk' aan de groep 'client' toegevoegd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' het gebeurtenistype 'nl.brp.overleden aan de groep 'client' toegevoegdgd
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' de groep 'client' verwijdert
      Dan zijn de volgende gebeurtenissen gepubliceerd
        | type                      | afnemerId          | abonneeNaam | groepNaam | gebeurtenisType                   |
        | GebeurtenistypeVerwijderd | Gemeente Amsterdam | jz          | client    | nl.brp.verhuisd.intergemeentelijk |
        | GebeurtenistypeVerwijderd | Gemeente Amsterdam | jz          | client    | nl.brp.overleden                  |

  Regel: Een 'GebeurtenistypeVerwijderd' gebeurtenis wordt gepubliceerd voor elk gebeurtenistype van elke groep van een abonnee die succesvol is gederegistreerd

    Scenario: Een afnemer deregistreert een abonnee met groepen met gebeurtenistypes
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' het gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk' aan de groep 'client' toegevoegd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' het gebeurtenistype 'nl.brp.overleden aan de groep 'client' toegevoegd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'relatie' toegevoegd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' het gebeurtenistype 'nl.brp.overleden' aan de groep 'relatie' toegevoegd
      Als de afnemer 'Gemeente Amsterdam' de abonnee 'jz' deregistreert
      Dan zijn de volgende gebeurtenissen gepubliceerd
        | type                      | afnemerId          | abonneeNaam | groepNaam | gebeurtenisType                   |
        | GebeurtenistypeVerwijderd | Gemeente Amsterdam | jz          | client    | nl.brp.verhuisd.intergemeentelijk |
        | GebeurtenistypeVerwijderd | Gemeente Amsterdam | jz          | client    | nl.brp.overleden                  |
        | GebeurtenistypeVerwijderd | Gemeente Amsterdam | jz          | relatie   | nl.brp.overleden                  |
