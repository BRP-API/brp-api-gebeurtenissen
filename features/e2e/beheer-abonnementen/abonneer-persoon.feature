# language: nl
Functionaliteit: Abonneer persoon voor een groep
  Als abonnee wil ik me kunnen abonneren op meerdere abonnementen voor dezelfde persoon in één request, 
    zodat ik niet voor elke persoon meerdere requests hoef te sturen

  Als abonnee wil ik verschillende soorten relaties volgen op verschillende set gebeurtenistypen, 
    zodat ik een uitgebreide set gebeurtenissen kan ontvangen op cliënten en een minder typen gebeurtenissen kan ontvangen op relaties van cliënten

  De afnemer voert bij het registreren van een abonnee op welke groepen er zijn en welke gebeurtenistypes gevolgd worden bij elke groep.
  Een abonnee abonneert een persoon voor de groep die deze persoon heeft in het proces dat de abonnee uitvoert.
  Daarmee krijgt de abonnee gebeurtenissen op de persoon voor alle gebeurtenistypes bij die groep horen.

  Achtergrond:
    Gegeven de persoon 'Jan' is geregistreerd in de BRP

  Regel: Een abonnee kan een abonnement toevoegen op een persoon voor een groep

    Scenario: Een abonnee abonneert een persoon voor een groep
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' het gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk' aan de groep 'client' toegevoegd
      Als de abonnee 'jz' van afnemer 'Gemeente Amsterdam' zich abonneert op de persoon 'Jan' voor de groep 'client'
      Dan is de response '201 Created'

  Regel: Een 'AbonnementOpPersoonGeregistreerd' gebeurtenis wordt gepubliceerd wanneer een gebeurtenistype succesvol is toegevoegd aan een groep

    @skip-verify
    Scenario: Een abonnee abonneert een persoon voor een groep
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' het gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk' aan de groep 'client' toegevoegd
      Als de abonnee 'jz' van afnemer 'Gemeente Amsterdam' zich abonneert op de persoon 'Jan' voor de groep 'client'
      Dan is een 'AbonnementOpPersoonGeregistreerd' gebeurtenis gepubliceerd met de volgende velden
        | afnemerId          | abonneeNaam | groepNaam | anummer |
        | Gemeente Amsterdam | jz          | client    | Jan     |
      # Deze Dan stap kan niet worden ge-automate. Met de API van Axon Server kan geen gebeurtenissen worden bevraagd die zijn gepubliceerd conform Dynamic Boundary Context

  Regel: Alleen een als abonnee geregistreerde afnemer kan zich abonneren

    Scenario: Een gebruiker probeert zich te abonneren op gebeurtenissen van een persoon met een niet geregistreerde abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      Als de abonnee 'bestaat-niet' van afnemer 'Gemeente Amsterdam' zich abonneert op de persoon 'Jan' voor de groep 'client'
      Dan is de response '404 Not Found' met de volgende velden
      * 'title' met tekst 'Abonnee bestaat niet'

    Scenario: Een gebruiker probeert zich te abonneren op gebeurtenissen van een persoon met een gederegistreerde abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      En de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' gederegistreerd
      Als de abonnee 'jz' van afnemer 'Gemeente Amsterdam' zich abonneert op de persoon 'Jan' voor de groep 'client'
      Dan is de response '404 Not Found' met de volgende velden
      * 'title' met tekst 'Abonnee bestaat niet'

  Regel: Een abonnee kan een persoon alleen voor een bij de abonnee geregistreerde groep abonneren

    Scenario: Een abonnee probeert zich te abonneren voor een groep die deze niet toegevoegd heeft
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      Als de abonnee 'jz' van afnemer 'Gemeente Amsterdam' zich abonneert op de persoon 'Jan' voor de groep 'bestaat-niet'
      Dan is de response '404 Not Found' met de volgende velden
      * 'title' met tekst 'Groep bestaat niet'

    Scenario: Een abonnee probeert zich te abonneren voor een groep die alleen bij een andere abonnee toegevoegd is
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      En de afnemer 'Gemeente Amsterdam' heeft de abonnee 'szw' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'szw' de groep 'andere' toegevoegd
      Als de abonnee 'jz' van afnemer 'Gemeente Amsterdam' zich abonneert op de persoon 'Jan' voor de groep 'andere'
      Dan is de response '404 Not Found' met de volgende velden
      * 'title' met tekst 'Groep bestaat niet'

    Scenario: Een abonnee probeert zich te abonneren voor een groep die verwijderd is
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' het gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk' aan de groep 'client' toegevoegd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' verwijderd
      Als de abonnee 'jz' van afnemer 'Gemeente Amsterdam' zich abonneert op de persoon 'Jan' voor de groep 'andere'
      Dan is de response '404 Not Found' met de volgende velden
      * 'title' met tekst 'Groep bestaat niet'

  Regel: Type is verplicht en moet een ondersteund type zijn
    Voor het toevoegen van een abonnement op een persoon is het type  'AbonneerPersoonOpGroep'

    Scenario: Een afnemer voegt een abonnement toe zonder het type groep op te geven
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      Als de abonnee 'jz' van afnemer 'Gemeente Amsterdam' zich abonneert voor persoon 'Jan' en groep 'client' zonder type op te geven
      Dan is de response '400 Bad Request' met de volgende velden
      * 'title' met tekst 'Type is verplicht'

    Abstract Scenario: Een afnemer abonneert zich en <omschrijving>
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      Als de abonnee 'jz' van afnemer 'Gemeente Amsterdam' zich abonneert voor persoon 'Jan' en groep 'client' met type '<type>'
      Dan is de response '400 Bad Request' met de volgende velden
      * 'title' met tekst 'Type is ongeldig'

      Voorbeelden:
        | omschrijving               | type                                   |
        | type is niet bekend        | BestaatNiet                            |
        | type is groep-type         | GebeurtenissenOpPersoon                |
        | type is oude abonneer-type | AbonneerOpGebeurtenisTypeVanPersoon    |
        | type is gebeurtenistype    | nl.brp.verhuisd.intergemeentelijk      |
        | type bevat script          | <script>alert("hello world");</script> |

  Regel: Burgerservicenummer is verplicht en moet een 9-cijferig nummer zijn dat gekoppeld is aan een persoon in de BRP

    Scenario: De abonnee geeft geen burgerservicenummer op
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      Als de abonnee 'jz' van afnemer 'Gemeente Amsterdam' zich abonneert voor de groep 'client' zonder een burgerservicenummer op te geven
      Dan is de response '400 Bad Request' met de volgende velden
      * 'title' met tekst 'Burgerservicenummer is verplicht'

    Scenario: De abonnee geeft een burgerservicenummer op van 8 cijfers (laat de voorloopnul weg)
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      Als de abonnee 'jz' van afnemer 'Gemeente Amsterdam' zich abonneert op de persoon met burgerservicenummer '10755561' voor de groep 'client'
      Dan is de response '400 Bad Request' met de volgende velden
      * 'title' met tekst 'Burgerservicenummer is ongeldig'

    Scenario: De abonnee geeft een burgerservicenummer op dat niet in de BRP voorkomt
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      Als de abonnee 'jz' van afnemer 'Gemeente Amsterdam' zich abonneert op de persoon met burgerservicenummer '000009829' voor de groep 'client'
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
      Als de abonnee 'jz' van afnemer 'Gemeente Amsterdam' zich abonneert op de persoon 'Jan' zonder een groep op te geven
      Dan is de response '400 Bad Request' met de volgende velden
      * 'title' met tekst 'Groepnaam is verplicht'

    Scenario: De abonnee geeft een groepnaam met ongeldige tekens
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      Als de abonnee 'jz' van afnemer 'Gemeente Amsterdam' zich abonneert op de persoon 'Jan' voor de groep '!@#$%^&*='
      Dan is de response '400 Bad Request' met de volgende velden
      * 'title' met tekst 'Groepnaam is ongeldig'

  Regel: Een abonnee mag niet twee keer hetzelfde abonnement nemen

    Scenario: Een abonnee abonneert een persoon voor een groep waarop deze abonnee al een abonnement heeft
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' het gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk' aan de groep 'client' toegevoegd
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'client'
      Als de abonnee 'jz' van afnemer 'Gemeente Amsterdam' zich abonneert op de persoon 'Jan' voor de groep 'client'
      Dan is de response '409 Conflict' met de volgende velden
      * 'title' met tekst 'Abonnement bestaat al'

  Regel: Een abonnee mag dezelfde persoon abonneren voor meerdere groepen

    Scenario: Een abonnee abonneert een persoon voor een groep en heeft al een abonnement op dezelfde persoon met een andere groep
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'relatie' toegevoegd
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'client'
      Als de abonnee 'jz' van afnemer 'Gemeente Amsterdam' zich abonneert op de persoon 'Jan' voor de groep 'relatie'
      Dan is de response '201 Created'
      # Dan is een 'AbonnementOpPersoonGeregistreerd' gebeurtenis gepubliceerd met de volgende velden
      #   | afnemerId          | abonneeNaam | groepNaam | anummer |
      #   | Gemeente Amsterdam | jz          | relatie   | Jan     |
      # Deze Dan stap kan niet worden ge-automate. Met de API van Axon Server kan geen gebeurtenissen worden bevraagd die zijn gepubliceerd conform Dynamic Boundary Context
