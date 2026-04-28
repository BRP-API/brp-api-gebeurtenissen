# language: nl
Functionaliteit: Registreer en beheer abonnees
  Als afnemer van BRP API Gebeurtenissen
  wil ik mijn interne afnemers (applicaties, processen) als abonnee kunnen registreren
  zodat ik de voor hen relevante gebeurtenissen niet zelf hoef te distribueren
  zodat mijn interne afnemers zelf abonnementen kunnen beheren

  Regel: Opgeven van het type operatie is verplicht

    Scenario: Afnemer probeert een abonnee verzoek te sturen zonder het type op te geven
      Als de afnemer 'Gemeente Amsterdam' een abonnee verzoek stuurt zonder het type op te geven
      Dan is de response '400 Bad Request' met de volgende velden
      * 'title' met tekst 'Type ontbreekt'

    Scenario: Afnemer probeert een abonnee verzoek te sturen met een onbekend type
      Als de afnemer 'Gemeente Amsterdam' een abonnee verzoek stuurt met het type 'BestaatNiet'
      Dan is de response '400 Bad Request' met de volgende velden
      * 'title' met tekst 'Type is onjuist'

  Regel: Opgeven van een abonneeNaam is verplicht

    Scenario: Afnemer probeert een abonnee te registreren zonder een abonnee op te geven
      Als de afnemer 'Gemeente Amsterdam' een abonnee registreert zonder abonneeNaam
      * met groep 'relatie' met abonnementen op gebeurtenistypes 'nl.brp.overleden'
      Dan is de response '400 Bad Request'

  Regel: Een geldige abonneenaam voldoet aan de volgende criteria:
    - bevat alleen kleine letters (a-z), cijfers (0-9) en een koppelteken (-)
    - bevat geen dubbele koppeltekens achter elkaar (--)
    - bevat minimaal 2 en maximaal 100 tekens
    - begint en eindigt niet met een koppelteken (-)

    Abstract Scenario: <titel>
      Als de afnemer 'Gemeente Amsterdam' de abonnee '<abonneeNaam>' registreert
      Dan is de response '400 Bad Request' met de volgende velden
      * 'title' met tekst 'Abonneenaam ongeldig'

      Voorbeelden:
        | titel                                              | abonneeNaam                                                                                           |
        | De abonneenaam is te kort                          | a                                                                                                     |
        | De abonneenaam is te lang                          | abcdefghijklmnopqrstuvwxyz-abcdefghijklmnopqrstuvwxyz-abcdefghijklmnopqrstuvwxyz-abcdefghijklmnopqrst |
        | De abonneenaam bevat hoofdletters                  | JZ                                                                                                    |
        | De abonneenaam bevat een koppelteken aan het begin | -jz                                                                                                   |
        | De abonneenaam bevat een koppelteken aan het einde | jz-                                                                                                   |
        | De abonneenaam bevat dubbele koppeltekens          | j--z                                                                                                  |
        | De abonneenaam bevat een ongeldig teken            | j_z                                                                                                   |
        | De abonneenaam is leeg                             |                                                                                                       |

  Regel: De abonneenaam is uniek binnen de context van een afnemer

    Scenario: De abonneeNaam bestaat al bij de afnemer
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      Als de afnemer 'Gemeente Amsterdam' de abonnee 'jz' registreert
      * met groep 'relatie' met abonnementen op gebeurtenistypes 'nl.brp.overleden'
      Dan is de response '409 Conflict' met de volgende velden
      * 'title' met tekst 'Abonnee bestaat al'
      * 'detail' met tekst 'Uw verzoek kan niet worden uitgevoerd omdat u al een abonnee met de opgegeven naam hebt geregistreerd.'

    Scenario: De opgegeven abonneenaam is al geregistreerd als abonnee door een andere afnemer
      Gegeven de afnemer 'Gemeente Rotterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      Als de afnemer 'Gemeente Amsterdam' de abonnee 'jz' registreert
      * met groep 'relatie' met abonnementen op gebeurtenistypes 'nl.brp.overleden'
      Dan is een 'AbonneeGeregistreerd' gebeurtenis gepubliceerd voor afnemer 'Gemeente Amsterdam' en abonnee 'jz'

  Regel: Alleen een geregistreerde abonnee kan worden gewijzigd

    Scenario: Afnemer voegt een groep toe aan een niet geregistreerde abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'bestaat-niet' de groep 'relatie' toevoegt
      * met abonnementen op gebeurtenistypes 'nl.brp.overleden'
      Dan is de response '404 Not Found'

    Scenario: Afnemer verwijdert een groep van een niet geregistreerde abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'bestaat-niet' de groep 'client' verwijdert
      Dan is de response '404 Not Found'

    Scenario: Afnemer voegt een gebeurtenistype toe bij een niet geregistreerde abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'bestaat-niet' gebeurtenistype 'nl.brp.verhuisd.naar-buitenland' toevoegt aan de groep 'client'
      Dan is de response '404 Not Found'

    Scenario: Afnemer verwijdert een gebeurtenistype bij een niet geregistreerde abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk' en 'nl.brp.overleden'
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'bestaat-niet' gebeurtenistype 'nl.brp.verhuisd.naar-buitenland' verwijdert van de groep 'client'
      Dan is de response '404 Not Found'

    Scenario: Afnemer deregistreert een niet geregistreerde abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk' en 'nl.brp.overleden'
      Als de afnemer 'Gemeente Amsterdam' de abonnee 'bestaat-niet deregistreert
      Dan is de response '404 Not Found'

  Regel: Een abonnee heeft ten minste één groep

    Scenario: De opgegeven abonnee heeft geen groep
      Als de afnemer 'Gemeente Amsterdam' de abonnee 'jz' registreert
      Dan is de response '400 Bad Request' met de volgende velden
      * 'title' met tekst 'Groep ontbreekt'

    Scenario: De afnemer probeert de enige groep te verwijderen
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' de groep 'client' verwijdert
      Dan is de response '409 Conflict' met de volgende velden
      * 'title' met tekst 'Minimaal 1 groep is verplicht'

  Regel: Een geldige groepnaam voldoet aan de volgende criteria:
    - bevat alleen kleine letters (a-z), cijfers (0-9) en een koppelteken (-)
    - bevat geen dubbele koppeltekens achter elkaar (--)
    - bevat minimaal 2 en maximaal 100 tekens
    - begint en eindigt niet met een koppelteken (-)

    Abstract Scenario: <titel>
      Als de afnemer 'Gemeente Amsterdam' de abonnee 'jz' registreert
      * met groep '<naam van de groep>' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      Dan is de response '400 Bad Request' met de volgende velden
      * 'title' met tekst 'Naam ongeldig'

      Voorbeelden:
        | titel                                              | naam van de groep                                                                                     |
        | De abonneenaam is te kort                          | a                                                                                                     |
        | De abonneenaam is te lang                          | abcdefghijklmnopqrstuvwxyz-abcdefghijklmnopqrstuvwxyz-abcdefghijklmnopqrstuvwxyz-abcdefghijklmnopqrst |
        | De abonneenaam bevat hoofdletters                  | JZ                                                                                                    |
        | De abonneenaam bevat een koppelteken aan het begin | -jz                                                                                                   |
        | De abonneenaam bevat een koppelteken aan het einde | jz-                                                                                                   |
        | De abonneenaam bevat dubbele koppeltekens          | j--z                                                                                                  |
        | De abonneenaam bevat een ongeldig teken            | j_z                                                                                                   |
        | De abonneenaam is leeg                             |                                                                                                       |

  Regel: De naam van de groep is uniek binnen de context van een abonnee

    Scenario: De te registreren abonnee bevat dezelfde groep twee keer
      Als de afnemer 'Gemeente Amsterdam' de abonnee 'jz' registreert
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.overleden'
      Dan is de response '400 Bad Request' met de volgende velden
      * 'title' met tekst 'Groep[1] is niet uniek'

    Scenario: De groep bestaat al bij de abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' de groep 'client' toevoegt
      * met abonnementen op gebeurtenistypes 'nl.brp.overleden'
      Dan is de response '409 Conflict' met de volgende velden
      * 'title' met tekst 'Groep bestaat al'
      * 'detail' met tekst 'Uw verzoek kan niet worden uitgevoerd omdat u al een groep met de opgegeven naam hebt geregistreerd bij deze abonnee.'

    Scenario: De opgegeven groep is al geregistreerd bij een andere abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      Als de afnemer 'Gemeente Amsterdam' de abonnee 'szw' registreert
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.overleden'
      Dan is een 'GroepToegevoegd' gebeurtenis gepubliceerd voor afnemer 'Gemeente Amsterdam' en abonnee 'szw'

    Scenario: De opgegeven groep is al geregistreerd bij een andere afnemer met dezelfde abonneeNaam
      Gegeven de afnemer 'Gemeente Rotterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      Als de afnemer 'Gemeente Amsterdam' de abonnee 'jz' registreert
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.overleden'
      Dan is een 'GroepToegevoegd' gebeurtenis gepubliceerd voor afnemer 'Gemeente Amsterdam' en abonnee 'jz'

  Regel: Alleen een geregistreerde groep kan worden gewijzigd

    Scenario: Afnemer verwijdert niet geregistreerde groep
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' de groep 'bestaat-niet' verwijdert
      Dan is de response '404 Not Found'

    Scenario: Afnemer voegt een gebeurtenistype toe aan een niet geregistreerde groep
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' gebeurtenistype 'nl.brp.verhuisd.naar-buitenland' toevoegt aan de groep 'bestaat-niet'
      Dan is de response '404 Not Found'

    Scenario: Afnemer verwijdert een gebeurtenistype bij een niet geregistreerde groep
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk' en 'nl.brp.overleden'
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk' verwijdert van de groep 'bestaat-niet'
      Dan is de response '404 Not Found'

  Regel: Een groep kan alleen bekende gebeurtenistypes hebben

    Scenario: Het opgegeven gebeurtenistype bestaat niet
      Als de afnemer 'Gemeente Amsterdam' de abonnee 'jz' registreert
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.bestaat-niet'
      Dan is de response '400 Bad Request' met de volgende velden
      * 'title' met tekst 'GebeurtenisType is onjuist'

    Scenario: Het gebeurtenistype bij de toe te voegen groep bestaat niet
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' de groep 'relatie' toevoegt
      * met abonnementen op gebeurtenistypes 'nl.brp.bestaat-niet'
      Dan is de response '400 Bad Request' met de volgende velden
      * 'title' met tekst 'GebeurtenisType is onjuist'

    Scenario: Het toe te voegen gebeurtenistype bestaat niet
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' gebeurtenistype 'nl.brp.verhuisd.bestaat-niet' toevoegt aan de groep 'client'
      Dan is de response '400 Bad Request' met de volgende velden
      * 'title' met tekst 'GebeurtenisType is onjuist'

  Regel: Een gebeurtenistype is uniek binnen de context van de groep

    Scenario: De te registreren abonnee bevat dezelfde groep twee keer
      Als de afnemer 'Gemeente Amsterdam' de abonnee 'jz' registreert
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk', 'nl.brp.overleden' en 'nl.brp.verhuisd.intergemeentelijk'
      Dan is de response '400 Bad Request' met de volgende velden
      * 'title' met tekst 'GebeurtenisType[2] is dubbelop'

    Scenario: Het toe te voegen gebeurtenistype bestaat al in de groep
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk' en 'nl.brp.overleden'
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk' toevoegt aan de groep 'client'
      Dan is de response '409 Conflict' met de volgende velden
      * 'title' met tekst 'GebeurtenisType bestaat al'

    Scenario: Het toe te voegen gebeurtenistype bestaat al in een andere groep
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk' en 'nl.brp.overleden'
      * met groep 'relatie' met abonnementen op gebeurtenistypes 'nl.brp.overleden'
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk' toevoegt aan de groep 'relatie'
      Dan is een 'GebeurtenisTypeToegevoegd' gebeurtenis gepubliceerd voor afnemer 'Gemeente Amsterdam' en abonnee 'jz' en groep 'relatie'

  Regel: Alleen een geregistreerde gebeurtenistype kan worden verwijderd

    Scenario: Het te verwijderen gebeurtenistype bestaat niet in de groep
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk' en 'nl.brp.overleden'
      * met groep 'relatie' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.naar-buitenland en 'nl.brp.overleden'
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk' verwijdert van de groep 'relatie'
      Dan is een 'GebeurtenisTypeToegevoegd' gebeurtenis gepubliceerd voor afnemer 'Gemeente Amsterdam' en abonnee 'jz' en groep 'relatie'
      Dan is de response '409 Conflict' met de volgende velden
      * 'title' met tekst 'GebeurtenisType bestaat niet'
