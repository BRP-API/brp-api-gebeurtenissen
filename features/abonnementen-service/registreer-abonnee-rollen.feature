# language: nl
Functionaliteit: Registreer abonnee rollen
  Als gemeente wil ik kunnen bepalen voor welke (set) gebeurtenistypen mijn abonnees zich (mogen) abonneren, 
    zodat ik geen applicatie hoef te maken die controleert dat abonnees alleen abonnementen zetten waar ze geautoriseerd voor zijn

  Als abonnee wil ik me kunnen abonneren op meerdere abonnementen voor dezelfde persoon in één request, 
    zodat ik niet voor elke persoon meerdere requests hoef te sturen

  Als abonnee wil ik verschillende soorten relaties volgen op verschillende set gebeurtenistypen, 
    zodat ik een uitgebreide set gebeurtenissen kan ontvangen op cliënten en een minder typen gebeurtenissen kan ontvangen op relaties van cliënten

  Een abonnee abonneert op een vaste set gebeurtenistypes afhankelijk van de rol die deze persoon heeft in het proces dat de abonnee uitvoert.
  De afnemer voert bij het registreren van een abonnee op welke rollen er zijn en welke gebeurtenistypes gevolgd worden bij elke rol.

  De afnemer kan na het registreren van een abonnee rollen toevoegen of verwijderen.
  De afnemer kan na het registreren van een abonnee gebeurtenistypes toevoegen of verwijderen aan rollen.
  De afnemer kan na het registreren van een abonnee de abonneenaam niet meer wijzigen.
  De afnemer kan na het registreren van een abonnee een rolnaam niet meer wijzigen.

  Regel: Een afnemer kan een abonnee registreren met één of meer rollen met elk één of meer gebeurtenistypes

    Scenario: Een afnemer registreert een abonnee met één rol en één gebeurtenistype
      Als de afnemer 'Gemeente Amsterdam' de abonnee 'jz' registreert
      * met rol 'client' met abonnementen op gebeurtenistypes 'nl.brp.overleden'
      Dan is abonnee 'jz' geregistreerd voor de afnemer 'Gemeente Amsterdam' met de volgende rollen
        | rol    | gebeurtenistypes |
        | client | nl.brp.overleden |

    Scenario: Een afnemer registreert een abonnee met meerdere rollen en meerdere gebeurtenistypes
      Als de afnemer 'Gemeente Amsterdam' de abonnee 'jz' registreert
      * met rol 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk', 'nl.brp.verhuisd.naar-buitenland' en 'nl.brp.overleden'
      * met rol 'relatie' met abonnementen op gebeurtenistypes 'nl.brp.overleden'
      Dan is abonnee 'jz' geregistreerd voor de afnemer 'Gemeente Amsterdam' met de volgende rollen
        | rol     | gebeurtenistypes                                                                     |
        | client  | nl.brp.verhuisd.intergemeentelijk, nl.brp.verhuisd.naar-buitenland, nl.brp.overleden |
        | relatie | nl.brp.overleden                                                                     |

  Regel: Een afnemer kan de rollen van een geregistreerde abonnee wijzigen door deze te overschrijven

    Scenario: Een afnemer voegt een rol toe aan een geregistreerde abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met rol 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      Als de afnemer 'Gemeente Amsterdam' de abonnee 'jz' wijzigt
      * met rol 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      * met rol 'relatie' met abonnementen op gebeurtenistypes 'nl.brp.overleden'
      Dan is abonnee 'jz' geregistreerd voor de afnemer 'Gemeente Amsterdam' met de volgende rollen
        | rol     | gebeurtenistypes                  |
        | client  | nl.brp.verhuisd.intergemeentelijk |
        | relatie | nl.brp.overleden                  |

    Scenario: Een afnemer verwijdert een rol van een geregistreerde abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met rol 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      * met rol 'relatie' met abonnementen op gebeurtenistypes 'nl.brp.overleden'
      Als de afnemer 'Gemeente Amsterdam' de abonnee 'jz' wijzigt
      * met rol 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      Dan is abonnee 'jz' geregistreerd voor de afnemer 'Gemeente Amsterdam' met de volgende rollen
        | rol    | gebeurtenistypes                  |
        | client | nl.brp.verhuisd.intergemeentelijk |

    Scenario: Een afnemer voegt een gebeurtenistype toe aan een rol van aan een geregistreerde abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met rol 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      * met rol 'relatie' met abonnementen op gebeurtenistypes 'nl.brp.overleden'
      Als de afnemer 'Gemeente Amsterdam' de abonnee 'jz' wijzigt
      * met rol 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk' en 'nl.brp.verhuisd.naar-buitenland'
      * met rol 'relatie' met abonnementen op gebeurtenistypes 'nl.brp.overleden'
      Dan is abonnee 'jz' geregistreerd voor de afnemer 'Gemeente Amsterdam' met de volgende rollen
        | rol     | gebeurtenistypes                                                   |
        | client  | nl.brp.verhuisd.intergemeentelijk, nl.brp.verhuisd.naar-buitenland |
        | relatie | nl.brp.overleden                                                   |

    Scenario: Een afnemer verwijdert een gebeurtenistype van een rol van een geregistreerde abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met rol 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk', 'nl.brp.verhuisd.naar-buitenland' en 'nl.brp.overleden'
      Als de afnemer 'Gemeente Amsterdam' de abonnee 'jz' wijzigt
      * met rol 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk' en 'nl.brp.overleden'
      Dan is abonnee 'jz' geregistreerd voor de afnemer 'Gemeente Amsterdam' met de volgende rollen
        | rol    | gebeurtenistypes                                    |
        | client | nl.brp.verhuisd.intergemeentelijk, nl.brp.overleden |

  Regel: Een abonnee moet ten minste één rol hebben

    Scenario: Een afnemer probeert een abonnee te registreren zonder een rol op te geven
      Als de afnemer 'Gemeente Amsterdam' de abonnee 'jz' registreert zonder rol
      Dan is de response '400 Bad Request'

    Scenario: Een afnemer probeert de enige rol van een geregistreerde abonnee te verwijderen
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met rol 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      Als de afnemer 'Gemeente Amsterdam' de abonnee 'jz' wijzigt zonder rol
      Dan is de response '400 Bad Request'

  Regel: Een rol van een abonnee moet ten minste één gebeurtenistype hebben

    Scenario: Een afnemer probeert een abonnee te registreren met een rol zonder gebeurtenistype
      Als de afnemer 'Gemeente Amsterdam' de abonnee 'jz' registreert
      * met rol 'client' zonder abonnementen op gebeurtenistypes
      Dan is de response '400 Bad Request'

    Scenario: Een afnemer probeert de een rol te wijzigen zonder gebeurtenistype
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met rol 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      * met rol 'relatie' met abonnementen op gebeurtenistypes 'nl.brp.overleden'
      Als de afnemer 'Gemeente Amsterdam' de abonnee 'jz' wijzigt
      * met rol 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      * met rol 'relatie' zonder abonnementen op gebeurtenistypes
      Dan is de response '400 Bad Request'

