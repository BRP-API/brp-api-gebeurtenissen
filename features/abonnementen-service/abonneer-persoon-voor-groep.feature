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
    Gegeven de persoon 'Jan'

  Regel: Een abonnee kan een persoon abonneren op de gebeurtenistypes bij een registreerde groep

    Scenario: Een abonnee abonneert een persoon voor een groep
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk' en 'nl.brp.verhuisd.naar-buitenland'
      * met groep 'relatie' met abonnementen op gebeurtenistypes 'nl.brp.overleden'
      Als de abonnee 'jz' van afnemer 'Gemeente Amsterdam' zich abonneert op de persoon 'Jan' voor de groep 'client'
      Dan ontvangt de abonnee 'jz' van afnemer 'Gemeente Amsterdam' gebeurtenissen van de gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk' en 'nl.brp.verhuisd.naar-buitenland' voor de persoon 'Jan'

  Regel: Alleen een als abonnee geregistreerde afnemer kan zich abonneren

    Scenario: Een gebruiker probeert zich te abonneren op gebeurtenissen van een persoon met een niet geregistreerde abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      Als de abonnee 'bestaat-niet' van afnemer 'Gemeente Amsterdam' zich abonneert op de persoon 'Jan' voor de groep 'client'
      Dan is de response '404 Not Found'

  Regel: Een abonnee kan alleen een geregistreerde groep gebruiken

    Scenario: Een abonnee probeert zich te abonneren voor een groep die deze niet geregistreerd heeft
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      Als de abonnee 'jz' van afnemer 'Gemeente Amsterdam' zich abonneert op de persoon 'Jan' voor de groep 'bestaat-niet'
      Dan is de response '400 Bad Request'

    Scenario: Een abonnee probeert zich te abonneren voor een groep die alleen bij een andere abonnee geregistreerd is
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      En de afnemer 'Gemeente Amsterdam' heeft de abonnee 'szw' geregistreerd
      * met groep 'andere' met abonnementen op gebeurtenistypes 'nl.brp.overleden'
      Als de abonnee 'jz' van afnemer 'Gemeente Amsterdam' zich abonneert op de persoon 'Jan' voor de groep 'andere'
      Dan is de response '400 Bad Request'

  Regel: Een abonnee mag niet twee keer hetzelfde abonnement nemen

    Scenario: Een abonnee abonneert een persoon voor een groep waarop deze abonnee al een abonnement heeft
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'client'
      Als de abonnee 'jz' van afnemer 'Gemeente Amsterdam' zich abonneert op de persoon 'Jan' voor de groep 'client'
      Dan is de response '409 Conflict'

  Regel: Een abonnee mag dezelfde persoon abonneren voor meerdere groepen en volgt dan de gebeurtenistypes van beide groepen

    Scenario: Een abonnee abonneert een persoon voor een groep en heeft al een abonnement op dezelfde persoon met een andere groep
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk' en 'nl.brp.verhuisd.naar-buitenland'
      * met groep 'relatie' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk' en 'nl.brp.overleden'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'relatie'
      Als de abonnee 'jz' van afnemer 'Gemeente Amsterdam' zich abonneert op de persoon 'Jan' voor de groep 'client'
      Dan ontvangt de abonnee 'jz' van afnemer 'Gemeente Amsterdam' gebeurtenissen van de gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk', 'nl.brp.verhuisd.naar-buitenland' en 'nl.brp.overleden' voor de persoon 'Jan'

  Regel: Een abonnee mag dezelfde naam voor een groep gebruiken als een andere abonnee
    En krijgt dan alleen gebeurtenissen van gebeurtenistypes die bij de eigen groep staan

    Scenario: Een abonnee abonneert een persoon voor een groep
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'szw' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      En de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.overleden'
      Als de abonnee 'jz' van afnemer 'Gemeente Amsterdam' zich abonneert op de persoon 'Jan' voor de groep 'client'
      Dan ontvangt de abonnee 'jz' van afnemer 'Gemeente Amsterdam' gebeurtenissen van de gebeurtenistypes 'nl.brp.overleden' voor de persoon 'Jan'

  Regel: Een abonnee kan het abonnement van een persoon op een groep opzeggen

    Scenario: Een abonnee zegt een abonnement op een persoon op
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk' en 'nl.brp.verhuisd.naar-buitenland'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'client'
      Als de abonnee 'jz' van afnemer 'Gemeente Amsterdam' het abonnement opzegt op de persoon 'Jan' voor de groep 'client'
      Dan ontvangt de abonnee 'jz' van afnemer 'Gemeente Amsterdam' geen gebeurtenissen meer voor de persoon 'Jan'

    Scenario: Een abonnee is geabonneerd op twee groepen voor dezelfde persoon en zegt één van deze abonnementen op
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk' en 'nl.brp.verhuisd.naar-buitenland'
      * met groep 'relatie' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk' en 'nl.brp.overleden'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'client'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'relatie'
      Als de abonnee 'jz' van afnemer 'Gemeente Amsterdam' het abonnement opzegt op de persoon 'Jan' voor de groep 'client'
      Dan ontvangt de abonnee 'jz' van afnemer 'Gemeente Amsterdam' gebeurtenissen van de gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk' en 'nl.brp.overleden' voor de persoon 'Jan'
      En ontvangt de abonnee 'jz' van afnemer 'Gemeente Amsterdam' geen gebeurtenissen meer van de gebeurtenistypes 'nl.brp.verhuisd.naar-buitenland' voor de persoon 'Jan'

  Regel: Een abonnee kan alle abonnementen van een persoon opzeggen

    Scenario: Een abonnee is geabonneerd op twee groepen voor dezelfde persoon en zegt alle abonnementen op deze persoon op
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk' en 'nl.brp.verhuisd.naar-buitenland'
      * met groep 'relatie' met abonnementen op gebeurtenistypes 'nl.brp.overleden'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'client'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'relatie'
      Als de abonnee 'jz' van afnemer 'Gemeente Amsterdam' alle abonnement van de persoon 'Jan' opzegt
      Dan ontvangt de abonnee 'jz' van afnemer 'Gemeente Amsterdam' geen gebeurtenissen meer voor de persoon 'Jan'

  Regel: Wanneer een gebeurtenistype wordt toegevoegd aan een geregistreerde groep, dan worden alle bestaande abonnementen op die groep uitgebreid met het toegevoegde gebeurtenistype

    Scenario: Een afnemer voegt een gebeurtenistype toe aan een groep waar al een abonnement op bestaat
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'client'
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' gebeurtenistype 'nl.brp.verhuisd.naar-buitenland' toevoegt aan de groep 'client'
      Dan ontvangt de abonnee 'jz' van afnemer 'Gemeente Amsterdam' gebeurtenissen van de gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk' en 'nl.brp.verhuisd.naar-buitenland' voor de persoon 'Jan'

  Regel: Wanneer een gebeurtenistype wordt verwijderd van een geregistreerde groep, dan wordt dat gebeurtenistype verwijderd van alle bestaande abonnementen op die groep

    Scenario: Een afnemer verwijdert een gebeurtenistype van een groep waar al een abonnement op bestaat
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk' en 'nl.brp.verhuisd.naar-buitenland'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'client'
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' gebeurtenistype 'nl.brp.verhuisd.naar-buitenland' verwijdert uit de groep 'client'
      Dan ontvangt de abonnee 'jz' van afnemer 'Gemeente Amsterdam' gebeurtenissen van de gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk' voor de persoon 'Jan'
      En ontvangt de abonnee 'jz' van afnemer 'Gemeente Amsterdam' geen gebeurtenissen meer van de gebeurtenistypes 'nl.brp.verhuisd.naar-buitenland' voor de persoon 'Jan'

  Regel: Wanneer een groep wordt verwijderd van een geregistreerde abonnee, dan worden ook alle bestaande abonnementen op deze groep opgezegd

    Scenario: Een afnemer verwijdert een groep van een geregistreerde abonnee waar al een abonnement op bestaat
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk' en 'nl.brp.verhuisd.naar-buitenland'
      * met groep 'relatie' met abonnementen op gebeurtenistypes 'nl.brp.overleden'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'relatie'
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' de groep 'relatie' verwijdert
      Dan ontvangt de abonnee 'jz' van afnemer 'Gemeente Amsterdam' geen gebeurtenissen meer voor de persoon 'Jan'

    Scenario: Een afnemer verwijdert een groep van een geregistreerde abonnee waar al een abonnement op bestaat en de abonnee heeft ook een abonnement voor dezelfde persoon met een andere groep
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk' en 'nl.brp.verhuisd.naar-buitenland'
      * met groep 'relatie' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk' en 'nl.brp.overleden'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'client'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'relatie'
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' de groep 'relatie' verwijdert
      Dan ontvangt de abonnee 'jz' van afnemer 'Gemeente Amsterdam' gebeurtenissen van de gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk' en 'nl.brp.verhuisd.naar-buitenland' voor de persoon 'Jan'
      En ontvangt de abonnee 'jz' van afnemer 'Gemeente Amsterdam' geen gebeurtenissen meer van de gebeurtenistypes 'nl.brp.overleden' voor de persoon 'Jan'
