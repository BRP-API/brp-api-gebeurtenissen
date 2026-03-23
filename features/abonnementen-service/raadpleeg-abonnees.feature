# language: nl
Functionaliteit: Raadpleeg abonnees
  Als afnemer van BRP API Gebeurtenissen
  wil ik de door mij geregistreerde abonnees kunnen raadplegen
  zodat ik een overzicht heb van mijn abonnees

  Regel: Een afnemer kan alleen zijn eigen abonnees raadplegen

    Scenario: Een afnemer raadpleegt zijn eigen abonnees
      Gegeven de volgende 'AbonneeGeregistreerd' gebeurtenissen zijn gepubliceerd
        | afnemerId          | abonneeNaam |
        | Gemeente Amsterdam | jz          |
        | Gemeente Rotterdam | dbz         |
        | Gemeente Amsterdam | szw         |
      Als de afnemer 'Gemeente Amsterdam' zijn abonnees raadpleegt
      Dan heeft de response abonees met de volgende velden
        | naam |
        | jz   |
        | szw  |
