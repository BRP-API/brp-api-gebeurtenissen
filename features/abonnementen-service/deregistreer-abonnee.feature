# language: nl

Functionaliteit: Deregistreer abonnee
  Als afnemer van BRP API Gebeurtenissen
  wil ik een abonnee kunnen deregistreren

  Regel: Alleen een bestaand abonnee kan worden gederegistreerd

    Scenario: Een afnemer deregistreert een bestaande abonnee
      Gegeven er is een 'AbonneeGeregistreerd' gebeurtenis gepubliceerd met de volgende velden
        | afnemerId          | abonneeNaam |
        | Gemeente Amsterdam | jz          |
      Als de afnemer 'Gemeente Amsterdam' de abonnee 'jz' deregistreert
      Dan is de response '204 No Content'

  Regel: Een 'AbonneeGederegistreerd' gebeurtenis wordt gepubliceerd wanneer een abonnee succesvol is gederegistreerd
  
    Scenario: Een afnemer deregistreert een bestaande abonnee
      Gegeven er is een 'AbonneeGeregistreerd' gebeurtenis gepubliceerd met de volgende velden
        | afnemerId          | abonneeNaam |
        | Gemeente Amsterdam | jz          |
      Als de afnemer 'Gemeente Amsterdam' de abonnee 'jz' deregistreert
      Dan is een 'AbonneeGederegistreerd' gebeurtenis gepubliceerd met de volgende velden
        | afnemerId          | abonneeNaam |
        | Gemeente Amsterdam | jz          |

  Regel: Er wordt geen 'AbonneeGederegistreerd' gebeurtenis gepubliceerd wanneer een reeds gederegistreerde abonnee wordt gederegistreerd

    Scenario: Een afnemer deregistreert een reeds gederegistreerde abonnee
      Gegeven er is een 'AbonneeGeregistreerd' gebeurtenis gepubliceerd met de volgende velden
        | afnemerId          | abonneeNaam |
        | Gemeente Amsterdam | jz          |
      En er is een 'AbonneeGederegistreerd' gebeurtenis gepubliceerd met de volgende velden
        | afnemerId          | abonneeNaam |
        | Gemeente Amsterdam | jz          |
      Als de afnemer 'Gemeente Amsterdam' de abonnee 'jz' deregistreert
      Dan is de response '204 No Content'

  Regel: Een niet-bestaande abonnee kan niet worden gederegistreerd

    Scenario: Een afnemer deregistreert een niet-bestaande abonnee
      Gegeven er is een 'AbonneeGeregistreerd' gebeurtenis gepubliceerd met de volgende velden
        | afnemerId          | abonneeNaam |
        | Gemeente Amsterdam | jz          |
      Als de afnemer 'Gemeente Amsterdam' de abonnee 'dbz' deregistreert
      Dan is de response '404 Not Found'
