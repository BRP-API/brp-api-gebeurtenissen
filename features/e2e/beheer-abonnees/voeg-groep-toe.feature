# language: nl
Functionaliteit: Voeg groep toe aan abonnee
Als abonnee
wil ik verschillende soorten relaties volgen op verschillende set gebeurtenistypen
zodat ik een uitgebreide set gebeurtenissen kan ontvangen op cliënten en een minder uitgebreide set gebeurtenissen kan ontvangen op relaties van cliënten

  Regel: Een afnemer kan een groep toevoegen aan een bestaande abonnee

    Scenario: Een afnemer voegt een groep toe aan een geregistreerde abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' de groep 'client' toevoegt
      Dan is de response '201 Created'

  Regel: Een 'GroepToegevoegd' gebeurtenis wordt gepubliceerd wanneer een groep succesvol is toegevoegd aan een abonnee

    @skip-verify
    Scenario: Een afnemer voegt een groep toe aan een geregistreerde abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' de groep 'client' toevoegt
      Dan is een 'GroepToegevoegd' gebeurtenis gepubliceerd met de volgende velden
        | afnemerId          | abonneeNaam | groepNaam |
        | Gemeente Amsterdam | jz          | client    |
      # Deze Dan stap kan niet worden ge-automate. Met de API van Axon Server kan geen gebeurtenissen worden bevraagd die zijn gepubliceerd conform Dynamic Boundary Context

  Regel: Een geldige groepnaam voldoet aan de volgende criteria:
    - bevat alleen kleine letters (a-z), cijfers (0-9) en koppeltekens (-)
    - bevat geen dubbele koppeltekens achter elkaar (--)
    - bevat minimaal 2 en maximaal 64 tekens
    - begint en eindigt niet met een koppelteken (-)

    Abstract Scenario: De groepnaam <titel>
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' de groep '<naam van de groep>' toevoegt
      Dan is de response '400 Bad Request' met de volgende velden
      * 'title' met tekst 'naam is ongeldig'
      * heeft de response invalidParams met de volgende gegevens
        | code    | name | reason                                                                                                                                                                                                        |
        | invalid | naam | Groepnaam voldoet niet aan de criteria: alleen kleine letters (a-z) en een koppelteken (-), geen dubbele koppeltekens (--), minimaal 2 en maximaal 64 tekens, begint en eindigt niet met een koppelteken (-). |


      Voorbeelden:
        | titel                               | naam van de groep                                                 |
        | is te kort                          | a                                                                 |
        | is te lang (65 tekens)              | abcdefghijklmnopqrstuvwxyz-abcdefghijklmnopqrstuvwxyz-abcdefghijk |
        | bevat hoofdletters                  | JZ                                                                |
        | bevat een koppelteken aan het begin | -jz                                                               |
        | bevat een koppelteken aan het einde | jz-                                                               |
        | bevat dubbele koppeltekens          | j--z                                                              |
        | bevat een ongeldig teken            | j_z                                                               |
        | bevat ongeldige tekens              | <script>alert("hello world");</script>                            |

    Scenario: De groepnaam is null
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' de groep '' toevoegt
      Dan is de response '400 Bad Request' met de volgende velden
      * 'title' met tekst 'naam is verplicht'
      * heeft de response invalidParams met de volgende gegevens
        | code     | name | reason            |
        | required | naam | naam is verplicht |

  Regel: De naam van de groep is uniek binnen de context van een abonnee

    Scenario: De groep bestaat al bij de abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' de groep 'client' toevoegt
      Dan is de response '409 Conflict' met de volgende velden
      * 'title' met tekst 'Groep bestaat al'

    Scenario: De opgegeven groep is al geregistreerd bij een andere abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      En de afnemer 'Gemeente Amsterdam' heeft de abonnee 'szw' geregistreerd
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'szw' de groep 'client' toevoegt
      Dan is de response '201 Created'
      # Dan is een 'GroepToegevoegd' gebeurtenis gepubliceerd met de volgende velden
      #   | afnemerId          | abonneeNaam | groepNaam |
      #   | Gemeente Amsterdam | szw         | client    |

    Scenario: De opgegeven groep is al geregistreerd bij een andere afnemer met dezelfde abonneeNaam
      Gegeven de afnemer 'Gemeente Rotterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Rotterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      En de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' de groep 'client' toevoegt
      Dan is de response '201 Created'
      # Dan is een 'GroepToegevoegd' gebeurtenis gepubliceerd met de volgende velden
      #   | afnemerId          | abonneeNaam | groepNaam |
      #   | Gemeente Amsterdam | szw         | client    |

  Regel: Een groep kan alleen worden toegevoegd aan een geregistreerde abonnee

    Scenario: Een afnemer voegt een groep toe aan een niet geregistreerde abonnee
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' de groep 'client' toevoegt
      Dan is de response '404 Not Found' met de volgende velden
      * 'title' met tekst 'Abonnee bestaat niet'

    Scenario: Een afnemer voegt een groep toe aan een gederegistreerde abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' gederegistreerd
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' de groep 'client' toevoegt
      Dan is de response '404 Not Found' met de volgende velden
      * 'title' met tekst 'Abonnee bestaat niet'
