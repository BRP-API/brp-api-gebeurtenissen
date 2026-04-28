# language: nl
Functionaliteit: Registreer abonneegroepen
  Als gemeente wil ik kunnen bepalen voor welke (set) gebeurtenistypen mijn abonnees zich (mogen) abonneren, 
    zodat ik geen applicatie hoef te maken die controleert dat abonnees alleen abonnementen zetten waar ze geautoriseerd voor zijn

  Als abonnee wil ik me kunnen abonneren op meerdere abonnementen voor dezelfde persoon in één request, 
    zodat ik niet voor elke persoon meerdere requests hoef te sturen

  Als abonnee wil ik verschillende soorten relaties volgen op verschillende set gebeurtenistypen, 
    zodat ik een uitgebreide set gebeurtenissen kan ontvangen op cliënten en een minder typen gebeurtenissen kan ontvangen op relaties van cliënten

  Een abonnee abonneert op een vaste set gebeurtenistypes afhankelijk van de groep die deze personen hebben in het proces dat de abonnee uitvoert.
  Bij een abonnee kunnen er meerdere groepen personen zijn die op dezelfde set gebeurtenistypes worden gevolgd.
  De afnemer voert bij het registreren van een abonnee op welke groepen er zijn en welke gebeurtenistypes gevolgd worden bij elke groep.

  De afnemer kan na het registreren van een abonnee groepen toevoegen of verwijderen.
  De afnemer kan na het registreren van een abonnee gebeurtenistypes toevoegen of verwijderen aan groepen.
  De afnemer kan een abonnee deregistreren.
  De afnemer kan na het registreren van een abonnee de abonneenaam niet meer wijzigen.
  De afnemer kan na het registreren van een abonnee een groepsnaam niet meer wijzigen.

  Regel: Een afnemer kan een abonnee registreren met één of meer groepen met elk één of meer gebeurtenistypes

    Scenario: Een afnemer registreert een abonnee met één groep en één gebeurtenistype
      Als de afnemer 'Gemeente Amsterdam' de abonnee 'jz' registreert
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.overleden'
      Dan is abonnee 'jz' geregistreerd voor de afnemer 'Gemeente Amsterdam' met de volgende groepen
        | groep  | gebeurtenistypes |
        | client | nl.brp.overleden |

    Scenario: Een afnemer registreert een abonnee met meerdere groepen en meerdere gebeurtenistypes
      Als de afnemer 'Gemeente Amsterdam' de abonnee 'jz' registreert
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk', 'nl.brp.verhuisd.naar-buitenland' en 'nl.brp.overleden'
      * met groep 'relatie' met abonnementen op gebeurtenistypes 'nl.brp.overleden'
      Dan is abonnee 'jz' geregistreerd voor de afnemer 'Gemeente Amsterdam' met de volgende groepen
        | groep   | gebeurtenistypes                                                                     |
        | client  | nl.brp.verhuisd.intergemeentelijk, nl.brp.verhuisd.naar-buitenland, nl.brp.overleden |
        | relatie | nl.brp.overleden                                                                     |

  Regel: Een afnemer kan gebeurtenistypes toevoegen aan een groep van een abonnee

    Scenario: Een afnemer voegt een gebeurtenistype toe aan een groep van aan een geregistreerde abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      * met groep 'relatie' met abonnementen op gebeurtenistypes 'nl.brp.overleden'
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' gebeurtenistype 'nl.brp.verhuisd.naar-buitenland' toevoegt aan de groep 'client'
      Dan is abonnee 'jz' geregistreerd voor de afnemer 'Gemeente Amsterdam' met de volgende groepen
        | groep   | gebeurtenistypes                                                   |
        | client  | nl.brp.verhuisd.intergemeentelijk, nl.brp.verhuisd.naar-buitenland |
        | relatie | nl.brp.overleden                                                   |

  Regel: Een afnemer kan gebeurtenistypes verwijderen aan een groep van een abonnee

    Scenario: Een afnemer verwijdert een gebeurtenistype van een groep van een geregistreerde abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk', 'nl.brp.verhuisd.naar-buitenland' en 'nl.brp.overleden'
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' gebeurtenistype 'nl.brp.verhuisd.naar-buitenland' verwijdert van de groep 'client'
      Dan is abonnee 'jz' geregistreerd voor de afnemer 'Gemeente Amsterdam' met de volgende groepen
        | groep  | gebeurtenistypes                                    |
        | client | nl.brp.verhuisd.intergemeentelijk, nl.brp.overleden |

  Regel: Een afnemer kan een groep toevoegen aan een abonnee

    Scenario: Een afnemer voegt een groep toe aan een geregistreerde abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' de groep 'relatie' toevoegt
      * met abonnementen op gebeurtenistypes 'nl.brp.overleden'
      Dan is abonnee 'jz' geregistreerd voor de afnemer 'Gemeente Amsterdam' met de volgende groepen
        | groep   | gebeurtenistypes                  |
        | client  | nl.brp.verhuisd.intergemeentelijk |
        | relatie | nl.brp.overleden                  |

  Regel: Een afnemer kan een groep verwijderen van een abonnee

    Scenario: Een afnemer verwijdert een groep van een geregistreerde abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      * met groep 'relatie' met abonnementen op gebeurtenistypes 'nl.brp.overleden'
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' de groep 'relatie' verwijdert
      Dan is abonnee 'jz' geregistreerd voor de afnemer 'Gemeente Amsterdam' met de volgende groepen
        | groep  | gebeurtenistypes                  |
        | client | nl.brp.verhuisd.intergemeentelijk |

  Regel: Een abonnee moet ten minste één groep hebben

    Scenario: Een afnemer probeert een abonnee te registreren zonder een groep op te geven
      Als de afnemer 'Gemeente Amsterdam' de abonnee 'jz' registreert zonder groep
      Dan is de response '400 Bad Request'

    Scenario: Een afnemer probeert de enige groep van een geregistreerde abonnee te verwijderen
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' de groep 'client' verwijdert
      Dan is de response '400 Bad Request'

  Regel: Een afnemer kan een abonnee deregistreren

    Scenario: Een afnemer deregistreert een abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk'
      Als de afnemer 'Gemeente Amsterdam' de abonnee 'jz' deregistreert
      Dan is abonnee 'jz' gederegistreerd voor de afnemer 'Gemeente Amsterdam'

  Regel: Een groep van een abonnee moet ten minste één gebeurtenistype hebben

    Scenario: Een afnemer probeert een abonnee te registreren met een groep zonder gebeurtenistype
      Als de afnemer 'Gemeente Amsterdam' de abonnee 'jz' registreert
      * met groep 'client' zonder abonnementen op gebeurtenistypes
      Dan is de response '400 Bad Request'

    Scenario: Een afnemer probeert alle gebeurtenistypes op een groep te verwijderen
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      * met groep 'client' met abonnementen op gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk' en 'nl.brp.verhuisd.intergemeentelijk'
      * met groep 'relatie' met abonnementen op gebeurtenistypes 'nl.brp.overleden'
      Als de afnemer 'Gemeente Amsterdam' bij de abonnee 'jz' gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk' en 'nl.brp.verhuisd.intergemeentelijk' verwijdert van de groep 'client'
      Dan is de response '400 Bad Request'
