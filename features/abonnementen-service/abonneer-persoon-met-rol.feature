# language: nl
Functionaliteit: Abonneer persoon met een rol
  Als abonnee wil ik me kunnen abonneren op meerdere abonnementen voor dezelfde persoon in één request, 
    zodat ik niet voor elke persoon meerdere requests hoef te sturen

  Als abonnee wil ik verschillende soorten relaties volgen op verschillende set gebeurtenistypen, 
    zodat ik een uitgebreide set gebeurtenissen kan ontvangen op cliënten en een minder typen gebeurtenissen kan ontvangen op relaties van cliënten

  De afnemer voert bij het registreren van een abonnee op welke rollen er zijn en welke gebeurtenistypes gevolgd worden bij elke rol.
  Een abonnee abonneert een persoon voor de rol die deze persoon heeft in het proces dat de abonnee uitvoert.
  Daarmee ontstaan abonnementen van de persoon voor alle gebeurtenistypes bij die rol.

  Achtergrond:
    Gegeven de persoon 'Jan'
    En de persoon 'Piet'

  Regel: Een abonnee kan een persoon abonneren op alle gebeurtenistypes bij een registreerde rol

    Scenario: Een abonnee abonneert een persoon met een rol
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met rol 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk' en 'nl.brp.verhuisd.naar-buitenland'
      * met rol 'relatie' met abonnementen op gebeurtenistypes 'nl.brp.overleden'
      Als de abonnee 'jz' van afnemer 'Gemeente Amsterdam' zich abonneert op de persoon 'Jan' met de rol 'client'
      Dan is de abonnee 'jz' van afnemer 'Gemeente Amsterdam' geabonneerd op de gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk' en 'nl.brp.verhuisd.naar-buitenland' voor de persoon 'Jan'

  Regel: Alleen een als abonnee geregistreerde afnemer kan zich abonneren

    Scenario: Een gebruiker probeert zich te abonneren op gebeurtenissen van een persoon met een niet geregistreerde abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met rol 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      Als de abonnee 'bestaat-niet' van afnemer 'Gemeente Amsterdam' zich abonneert op de persoon 'Jan' met de rol 'client'
      Dan is de response '404 Not Found'

  Regel: Een abonnee kan alleen een geregistreerde rol gebruiken

    Scenario: Een abonnee probeert zich te abonneren met een rol die deze niet geregistreerd heeft
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met rol 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      Als de abonnee 'jz' van afnemer 'Gemeente Amsterdam' zich abonneert op de persoon 'Jan' met de rol 'bestaat-niet'
      Dan is de response '400 Bad Request'

  Regel: Een abonnee mag niet twee keer hetzelfde abonnement nemen

    Scenario: Een abonnee abonneert een persoon met een rol waarop deze abonnee al een abonnement heeft
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met rol 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' met de rol 'client'
      Als de abonnee 'jz' van afnemer 'Gemeente Amsterdam' zich abonneert op de persoon 'Jan' met de rol 'client'
      Dan is de response '409 Conflict'

  Regel: Een abonnee mag dezelfde persoon abonneren voor meerdere rollen en volgt dan de gebeurtenistypes van beide rollen

    Scenario: Een abonnee abonneert een persoon met een rol en heeft al een abonnement op dezelfde persoon met een andere rol
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met rol 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk' en 'nl.brp.verhuisd.naar-buitenland'
      * met rol 'relatie' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk' en 'nl.brp.overleden'
      Als de abonnee 'jz' van afnemer 'Gemeente Amsterdam' zich abonneert op de persoon 'Jan' met de rol 'client'
      Dan is de abonnee 'jz' van afnemer 'Gemeente Amsterdam' geabonneerd op de gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk', 'nl.brp.verhuisd.naar-buitenland' en 'nl.brp.overleden' voor de persoon 'Jan'

  Regel: Een abonnee kan het abonnement van een persoon op een rol opzeggen

    Scenario: Een abonnee zegt een abonnement op een persoon op
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met rol 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk' en 'nl.brp.verhuisd.naar-buitenland'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' met de rol 'client'
      Als de abonnee 'jz' van afnemer 'Gemeente Amsterdam' het abonnement opzegt op de persoon 'Jan' met de rol 'client'
      Dan heeft de abonnee 'jz' van afnemer 'Gemeente Amsterdam' geen abonnement op de persoon 'Jan'

    Scenario: Een abonnee is geabonneerd op twee rollen voor dezelfde persoon en zegt één van deze abonnementen op
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met rol 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk' en 'nl.brp.verhuisd.naar-buitenland'
      * met rol 'relatie' met abonnementen op gebeurtenistypes 'nl.brp.overleden'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' met de rol 'client'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' met de rol 'relatie'
      Als de abonnee 'jz' van afnemer 'Gemeente Amsterdam' het abonnement opzegt op de persoon 'Jan' met de rol 'client'
      Dan is de abonnee 'jz' van afnemer 'Gemeente Amsterdam' geabonneerd op de gebeurtenistypes 'nl.brp.overleden' voor de persoon 'Jan'

  Regel: Een abonnee kan alle abonnementen van een persoon opzeggen

    Scenario: Een abonnee is geabonneerd op twee rollen voor dezelfde persoon en zegt alle abonnementen op deze persoon op
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met rol 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk' en 'nl.brp.verhuisd.naar-buitenland'
      * met rol 'relatie' met abonnementen op gebeurtenistypes 'nl.brp.overleden'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' met de rol 'client'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' met de rol 'relatie'
      Als de abonnee 'jz' van afnemer 'Gemeente Amsterdam' alle abonnement van de persoon 'Jan' opzegt
      Dan heeft de abonnee 'jz' van afnemer 'Gemeente Amsterdam' geen abonnement op de persoon 'Jan'

  Regel: Wanneer een gebeurtenistype wordt toegevoegd aan een geregistreerde rol, dan worden alle bestaande abonnementen op die rol uitgebreid met het toegevoegde gebeurtenistype

    Scenario: Een afnemer voegt een gebeurtenistype toe aan een rol waar al een abonnement op bestaat
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met rol 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' met de rol 'client'
      Als de afnemer 'Gemeente Amsterdam' de abonnee 'jz' wijzigt
      * met rol 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk' en 'nl.brp.verhuisd.naar-buitenland'
      Dan is de abonnee 'jz' van afnemer 'Gemeente Amsterdam' geabonneerd op de gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk' en 'nl.brp.verhuisd.naar-buitenland' voor de persoon 'Jan'

  Regel: Wanneer een gebeurtenistype wordt verwijderd van een geregistreerde rol, dan wordt dat gebeurtenistype verwijderd van alle bestaande abonnementen op die rol

    Scenario: Een afnemer verwijdert een gebeurtenistype van een rol waar al een abonnement op bestaat
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met rol 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk' en 'nl.brp.verhuisd.naar-buitenland'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' met de rol 'client'
      Als de afnemer 'Gemeente Amsterdam' de abonnee 'jz' wijzigt
      * met rol 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      Dan is de abonnee 'jz' van afnemer 'Gemeente Amsterdam' geabonneerd op de gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk' voor de persoon 'Jan'

  Regel: Wanneer een rol wordt verwijderd van een geregistreerde abonnee, dan worden ook alle bestaande abonnementen op deze rol opgezegd

    Scenario: Een afnemer verwijdert een rol van een geregistreerde abonnee waar al een abonnement op bestaat
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met rol 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk' en 'nl.brp.verhuisd.naar-buitenland'
      * met rol 'relatie' met abonnementen op gebeurtenistypes 'nl.brp.overleden'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' met de rol 'relatie'
      Als de afnemer 'Gemeente Amsterdam' de abonnee 'jz' wijzigt
      * met rol 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk' en 'nl.brp.verhuisd.naar-buitenland'
      Dan heeft de abonnee 'jz' van afnemer 'Gemeente Amsterdam' geen abonnement op de persoon 'Jan'

    Scenario: Een afnemer verwijdert een rol van een geregistreerde abonnee waar al een abonnement op bestaat en de abonnee heeft ook een abonnement voor dezelfde persoon met een andere rol
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met rol 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk' en 'nl.brp.verhuisd.naar-buitenland'
      * met rol 'relatie' met abonnementen op gebeurtenistypes 'nl.brp.overleden'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' met de rol 'client'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' met de rol 'relatie'
      Als de afnemer 'Gemeente Amsterdam' de abonnee 'jz' wijzigt
      * met rol 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk' en 'nl.brp.verhuisd.naar-buitenland'
      Dan is de abonnee 'jz' van afnemer 'Gemeente Amsterdam' geabonneerd op de gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk' en 'nl.brp.verhuisd.naar-buitenland' voor de persoon 'Jan'
