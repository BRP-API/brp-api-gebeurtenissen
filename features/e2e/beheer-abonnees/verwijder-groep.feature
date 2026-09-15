# language: nl
Functionaliteit: Verwijder groep van abonnee

  Regel: Een afnemer kan een groep verwijderen van een abonnee

    Scenario: Een afnemer verwijdert een groep van een abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' de groep 'client' verwijdert
      Dan is de response '204 No Content'

  Regel: Een 'GroepVerwijderd' gebeurtenis wordt gepubliceerd wanneer een groep succesvol is verwijderd van een abonnee

    @skip-verify
    Scenario: Een afnemer verwijdert een groep van een abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' de groep 'client' verwijdert
      Dan is een 'GroepVerwijderd' gebeurtenis gepubliceerd met de volgende velden
        | afnemerId          | abonneeNaam | groepNaam |
        | Gemeente Amsterdam | jz          | client    |
      # Deze Dan stap kan niet worden ge-automate. Met de API van Axon Server kan geen gebeurtenissen worden bevraagd die zijn gepubliceerd conform Dynamic Boundary Context

  Regel: Er wordt een foutmelding gegeven wanneer de groep niet bestaat

    Scenario: Een afnemer verwijdert een groep die niet bestaat omdat er nooit een groep met deze naam is toegevoegd
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' de groep 'relatie' verwijdert
      Dan is de response '404 Not Found' met de volgende velden
      * 'title' met tekst 'Groep bestaat niet'

    Scenario: Een afnemer verwijdert een groep die alleen bestaat bij een andere abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      En de afnemer 'Gemeente Amsterdam' heeft de abonnee 'szw' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'szw' de groep 'relatie' toegevoegd
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' de groep 'relatie' verwijdert
      Dan is de response '404 Not Found' met de volgende velden
      * 'title' met tekst 'Groep bestaat niet'

    Scenario: Een afnemer verwijdert een groep die alleen bestaat bij een abonnee met dezelfde naam bij een andere abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      En de afnemer 'Gemeente Rotterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Rotterdam' heeft bij de abonnee 'jz' de groep 'relatie' toegevoegd
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' de groep 'relatie' verwijdert
      Dan is de response '404 Not Found' met de volgende velden
      * 'title' met tekst 'Groep bestaat niet'

    Scenario: Een afnemer verwijdert een reeds verwijderde groep
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' verwijderd
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' de groep 'client' verwijdert
      Dan is de response '404 Not Found' met de volgende velden
      * 'title' met tekst 'Groep bestaat niet'

  Regel: Alleen een groep van een geregistreerde abonnee kan worden verwijderd

    Scenario: Een afnemer verwijdert een groep met een abonneenaam die niet is geregistreerd
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'szw' de groep 'client' verwijdert
      Dan is de response '404 Not Found' met de volgende velden
      * 'title' met tekst 'Abonnee bestaat niet'

    Scenario: Een afnemer verwijdert een groep van een gederegistreerde abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      En de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' gederegistreerd
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' de groep 'client' verwijdert
      Dan is de response '404 Not Found' met de volgende velden
      * 'title' met tekst 'Abonnee bestaat niet'

  Regel: Een 'GroepVerwijderd' gebeurtenis wordt gepubliceerd voor elke groep van de abonnee wanneer de abonnee succesvol is gederegistreerd

    @skip-verify
    Scenario: Een afnemer deregistreert een abonnee met twee groepen
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'relatie' toegevoegd
      Als de afnemer 'Gemeente Amsterdam' de abonnee 'jz' deregistreert
      Dan zijn de volgende gebeurtenissen gepubliceerd
        | type            | afnemerId          | abonneeNaam | groepNaam |
        | GroepVerwijderd | Gemeente Amsterdam | jz          | client    |
        | GroepVerwijderd | Gemeente Amsterdam | jz          | relatie   |
      # Deze Dan stap kan niet worden ge-automate. Met de API van Axon Server kan geen gebeurtenissen worden bevraagd die zijn gepubliceerd conform Dynamic Boundary Context
