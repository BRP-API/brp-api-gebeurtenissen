# language: nl
Functionaliteit: Beëindig het abonnement van een persoon op een groep

  Achtergrond:
    Gegeven de persoon 'Jan' is geregistreerd in de BRP
    En de persoon 'Piet' is geregistreerd in de BRP

  Regel: Een abonnee kan een abonnement op een persoon voor een groep opzeggen
    Voor het opzeggen van een abonnement wordt in type de waarde 'ZegOpAbonnementVanPersoonOpGroep' opgegeven

    Scenario: Een abonnee abonneert een persoon voor een groep
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'client'
      Als de abonnee 'jz' van afnemer 'Gemeente Amsterdam' zijn abonnement op de persoon 'Jan' voor de groep 'client' opzegt
      Dan is de response '204 No Content'

  Regel: Een 'AbonnementOpPersoonOpgezegd' gebeurtenis wordt gepubliceerd wanneer een abonnement van een persoon voor een groep is opgezegd

    @skip-verify
    Scenario: Een abonnee zegt een abonnement van een persoon voor een groep op
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'client'
      Als de abonnee 'jz' van afnemer 'Gemeente Amsterdam' zijn abonnement op de persoon 'Jan' voor de groep 'client' opzegt
      Dan is een 'AbonnementOpPersoonOpgezegd' gebeurtenis gepubliceerd met de volgende velden
        | afnemerId          | abonneeNaam | groepNaam | anummer |
        | Gemeente Amsterdam | jz          | client    | Jan     |
      # Deze Dan stap kan niet worden ge-automate. Met de API van Axon Server kan geen gebeurtenissen worden bevraagd die zijn gepubliceerd conform Dynamic Boundary Context

  Regel: Alleen een als abonnee geregistreerde afnemer kan een abonnement opzeggen

    Scenario: Een gebruiker probeert een abonnement op te zeggen met een niet geregistreerde abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'client'
      Als de abonnee 'bestaat-niet' van afnemer 'Gemeente Amsterdam' zijn abonnement op de persoon 'Jan' voor de groep 'client' opzegt
      Dan is de response '404 Not Found' met de volgende velden
      * 'title' met tekst 'Abonnee bestaat niet'

    Scenario: Een gebruiker probeert een abonnement op te zeggen met een gederegistreerde abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'client'
      En de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' gederegistreerd
      Als de abonnee 'jz' van afnemer 'Gemeente Amsterdam' zijn abonnement op de persoon 'Jan' voor de groep 'client' opzegt
      Dan is de response '404 Not Found' met de volgende velden
      * 'title' met tekst 'Abonnee bestaat niet'

  Regel: Alleen een abonnement dat eerder is toegevoegd kan worden opgezegd

    Scenario: De abonnee zegt een abonnement op dat niet is toegevoegd en heeft wel een abonnement voor deze persoon voor een andere groep
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'relatie' toegevoegd
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'client'
      Als de abonnee 'jz' van afnemer 'Gemeente Amsterdam' zijn abonnement op de persoon 'Jan' voor de groep 'relatie' opzegt
      Dan is de response '404 Not Found' met de volgende velden
      * 'title' met tekst 'Abonnement bestaat niet'

    Scenario: De abonnee zegt een abonnement op dat niet is toegevoegd en heeft wel een abonnement voor deze groep voor een andere persoon
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'client'
      Als de abonnee 'jz' van afnemer 'Gemeente Amsterdam' zijn abonnement op de persoon 'Piet' voor de groep 'client' opzegt
      Dan is de response '404 Not Found' met de volgende velden
      * 'title' met tekst 'Abonnement bestaat niet'

    Scenario: De abonnee zegt een abonnement op dat niet is toegevoegd en een andere abonnee heeft wel een abonnement voor deze persoon voor deze groep
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      En de afnemer 'Gemeente Amsterdam' heeft de abonnee 'szw' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'szw' de groep 'client' toegevoegd
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'client'
      Als de abonnee 'szw' van afnemer 'Gemeente Amsterdam' zijn abonnement op de persoon 'Jan' voor de groep 'client' opzegt
      Dan is de response '404 Not Found' met de volgende velden
      * 'title' met tekst 'Abonnement bestaat niet'

    Scenario: De abonnee zegt een abonnement op met een groepnaam die niet bestaat
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      Als de abonnee 'jz' van afnemer 'Gemeente Amsterdam' zijn abonnement op de persoon 'Jan' voor de groep 'bestaat-niet' opzegt
      Dan is de response '404 Not Found' met de volgende velden
      * 'title' met tekst 'Abonnement bestaat niet'

  Regel: Er wordt geen 'AbonnementOpPersoonOpgezegd' gebeurtenis gepubliceerd wanneer een reeds opgezegd abonnement opnieuw wordt verwijderd

    Scenario: De abonnee zegt een abonnement op dat eerder al is opgezegd
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'client'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft het abonnement op de persoon 'Jan' voor de groep 'client' opgezegd
      Als de abonnee 'jz' van afnemer 'Gemeente Amsterdam' zijn abonnement op de persoon 'Jan' voor de groep 'client' opzegt
      Dan is de response '404 Not Found' met de volgende velden
      * 'title' met tekst 'Abonnement bestaat niet'

  Regel: Burgerservicenummer is verplicht en moet een 9-cijferig nummer zijn

    Scenario: De abonnee geeft geen burgerservicenummer op
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      Als de abonnee 'jz' van afnemer 'Gemeente Amsterdam' een abonnement voor de groep 'client' opzegt zonder een burgerservicenummer op te geven
      Dan is de response '400 Bad Request' met de volgende velden
      * 'title' met tekst 'Burgerservicenummer is verplicht'

    Scenario: De abonnee geeft een burgerservicenummer op van 8 cijfers (laat de voorloopnul weg)
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      Als de abonnee 'jz' van afnemer 'Gemeente Amsterdam' zijn abonnement op de persoon met burgerservicenummer '10755561' voor de groep 'client' opzegt
      Dan is de response '400 Bad Request' met de volgende velden
      * 'title' met tekst 'Burgerservicenummer is ongeldig'

  Regel: Groep is verplicht en een geldige groepnaam voldoet aan de volgende criteria:
    - bevat alleen kleine letters (a-z), cijfers (0-9) en koppeltekens (-)
    - bevat geen dubbele koppeltekens achter elkaar (--)
    - bevat minimaal 2 en maximaal 64 tekens
    - begint en eindigt niet met een koppelteken (-)

    Scenario: De abonnee geeft geen groepnaam op
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      Als de abonnee 'jz' van afnemer 'Gemeente Amsterdam' zijn abonnement op de persoon 'Jan' opzegt zonder een groep op te geven
      Dan is de response '400 Bad Request' met de volgende velden
      * 'title' met tekst 'Groepnaam is verplicht'

    Scenario: De abonnee geeft een groepnaam met ongeldige
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      Als de abonnee 'jz' van afnemer 'Gemeente Amsterdam' zijn abonnement op de persoon 'Jan' voor de groep '!@#$%^&*=' opzegt
      Dan is de response '400 Bad Request' met de volgende velden
      * 'title' met tekst 'Groepnaam is ongeldig'
