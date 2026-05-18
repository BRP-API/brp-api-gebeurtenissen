# language: nl
Functionaliteit: Deregistreer abonnee
  Als afnemer van BRP API Gebeurtenissen
  wil ik een abonnee kunnen deregistreren

  Regel: Alleen een bestaande abonnee kan worden gederegistreerd

    Scenario: Een afnemer deregistreert een bestaande abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      Als de afnemer 'Gemeente Amsterdam' de abonnee 'jz' deregistreert
      Dan is de response '204 No Content'

  Regel: Een 'AbonneeGederegistreerd' gebeurtenis wordt gepubliceerd wanneer een abonnee succesvol is gederegistreerd

    Scenario: Een afnemer deregistreert een bestaande abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      Als de afnemer 'Gemeente Amsterdam' de abonnee 'jz' deregistreert
      Dan is een 'AbonneeGederegistreerd' gebeurtenis gepubliceerd met de volgende velden
        | afnemerId          | abonneeNaam |
        | Gemeente Amsterdam | jz          |

  Regel: Een reeds gederegistreerde abonnee kan niet opnieuw worden gederegistreerd

    Scenario: Een afnemer deregistreert een reeds gederegistreerde abonnee
      Gegeven er is een 'AbonneeGeregistreerd' gebeurtenis gepubliceerd met de volgende velden
        | afnemerId          | abonneeNaam |
        | Gemeente Amsterdam | jz          |
      En er is een 'AbonneeGederegistreerd' gebeurtenis gepubliceerd met de volgende velden
        | afnemerId          | abonneeNaam |
        | Gemeente Amsterdam | jz          |
      Als de afnemer 'Gemeente Amsterdam' de abonnee 'jz' deregistreert
      Dan is de response '404 Not Found'

  Regel: Een niet-bestaande abonnee kan niet worden gederegistreerd

    Scenario: Een afnemer deregistreert een niet-bestaande abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      Als de afnemer 'Gemeente Amsterdam' de abonnee 'dbz' deregistreert
      Dan is de response '409 Conflict' met de volgende velden
      * 'title' met tekst 'Abonnee bestaat niet'

    Scenario: Een afnemer deregistreert een reeds gederegistreerde abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' gederegistreerd
      Als de afnemer 'Gemeente Amsterdam' de abonnee 'jz' deregistreert
      Dan is de response '404 Not Found'
