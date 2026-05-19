# language: nl
Functionaliteit: Voeg groep toe aan abonnee
  Als abonnee 
  wil ik verschillende soorten relaties volgen op verschillende set gebeurtenistypen
  zodat ik een uitgebreide set gebeurtenissen kan ontvangen op cliënten en een minder uitgebreide set gebeurtenissen kan ontvangen op relaties van cliënten

  Regel: Een afnemer kan een groep toevoegen aan een bestaande abonnee

    Scenario: Een afnemer voegt een groep toe aan een geregistreerde abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' de 'GebeurtenissenOpPersoon' groep 'client' toevoegt
      Dan is de response '201 Created'

  Regel: Een 'GroepToegevoegd' gebeurtenis wordt gepubliceerd wanneer een groep succesvol is toegevoegd aan een abonnee

    Scenario: Een afnemer voegt een groep toe aan een geregistreerde abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' de 'GebeurtenissenOpPersoon' groep 'client' toevoegt
      Dan is een 'GroepToegevoegd' gebeurtenis gepubliceerd met de volgende velden
        | afnemerId          | abonneeNaam | groepNaam | groepType               |
        | Gemeente Amsterdam | jz          | client    | GebeurtenissenOpPersoon |

  Regel: Type is verplicht en moet een ondersteund type zijn

    Scenario: Een afnemer voegt een groep toe zonder het type groep op te geven
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      Als de afnemer een groep toevoegt zonder type op te geven
      Dan is de response '400 Bad Request' met de volgende velden
      * 'title' met tekst 'Type is verplicht'

    Scenario: Een afnemer voegt een groep toe en type is niet ondersteund
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' de 'BestaatNiet' groep 'client' toevoegt
      Dan is de response '400 Bad Request' met de volgende velden
      * 'title' met tekst 'Type is ongeldig'

  Regel: Een geldige groepnaam voldoet aan de volgende criteria:
    - bevat alleen kleine letters (a-z), cijfers (0-9) en koppeltekens (-)
    - bevat geen dubbele koppeltekens achter elkaar (--)
    - bevat minimaal 2 en maximaal 64 tekens
    - begint en eindigt niet met een koppelteken (-)

    Abstract Scenario: <titel>
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' de 'GebeurtenissenOpPersoon' groep '<naam van de groep>' toevoegt
      Dan is de response '400 Bad Request' met de volgende velden
      * 'title' met tekst 'Naam ongeldig'

      Voorbeelden:
        | titel                                            | naam van de groep                                                 |
        | De groepnaam is te kort                          | a                                                                 |
        | De groepnaam is te lang (65 tekens)              | abcdefghijklmnopqrstuvwxyz-abcdefghijklmnopqrstuvwxyz-abcdefghijk |
        | De groepnaam bevat hoofdletters                  | JZ                                                                |
        | De groepnaam bevat een koppelteken aan het begin | -jz                                                               |
        | De groepnaam bevat een koppelteken aan het einde | jz-                                                               |
        | De groepnaam bevat dubbele koppeltekens          | j--z                                                              |
        | De groepnaam bevat een ongeldig teken            | j_z                                                               |
        | De groepnaam is leeg                             |                                                                   |
        | De groepnaam bevat ongeldige tekens              | <script>alert("hello world");</script>                            |

  Regel: De naam van de 'GebeurtenissenOpPersoon' groep is uniek binnen de context van een abonnee

    Scenario: de 'GebeurtenissenOpPersoon' groep bestaat al bij de abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de 'GebeurtenissenOpPersoon' groep 'client' toegevoegd
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' de 'GebeurtenissenOpPersoon' groep 'client' toevoegt
      Dan is de response '409 Conflict' met de volgende velden
      * 'title' met tekst 'Groep bestaat al'

    Scenario: De opgegeven groep is al geregistreerd bij een andere abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de 'GebeurtenissenOpPersoon' groep 'client' toegevoegd
      En de afnemer 'Gemeente Amsterdam' heeft de abonnee 'szw' geregistreerd
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'szw' de 'GebeurtenissenOpPersoon' groep 'client' toevoegt
      Dan is een 'GroepToegevoegd' gebeurtenis gepubliceerd met de volgende velden
        | afnemerId          | abonneeNaam | groepNaam | type                    |
        | Gemeente Amsterdam | szw         | client    | GebeurtenissenOpPersoon |

    Scenario: De opgegeven groep is al geregistreerd bij een andere afnemer met dezelfde abonneeNaam
      Gegeven de afnemer 'Gemeente Rotterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Rotterdam' heeft bij de abonnee 'jz' de 'GebeurtenissenOpPersoon' groep 'client' toegevoegd
      En de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' de 'GebeurtenissenOpPersoon' groep 'client' toevoegt
      Dan is een 'GroepToegevoegd' gebeurtenis gepubliceerd met de volgende velden
        | afnemerId          | abonneeNaam | groepNaam | type                    |
        | Gemeente Amsterdam | szw         | client    | GebeurtenissenOpPersoon |

  Regel: Een groep kan alleen worden toegevoegd aan een geregistreerde abonnee

    Scenario: Een afnemer voegt een groep toe aan een niet geregistreerde abonnee
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' de 'GebeurtenissenOpPersoon' groep 'client' toevoegt
      Dan is de response '404 Not Found' met de volgende velden
      * 'title' met tekst 'Abonnee bestaat niet'

    Scenario: Een afnemer voegt een groep toe aan een gederegistreerde abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' gederegistreerd
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' de 'GebeurtenissenOpPersoon' groep 'client' toevoegt
      Dan is de response '404 Not Found' met de volgende velden
      * 'title' met tekst 'Abonnee bestaat niet'
