# language: nl
Functionaliteit: Abonneer persoon voor een groep
  Als abonnee wil ik kunnen raadplegen welke actieve abonnementen ik heb
  zodat ik mijn abonnementen kan beheren

  Achtergrond:
    Gegeven de persoon 'Jan' is geregistreerd in de BRP
    En de persoon 'Piet' is geregistreerd in de BRP
    En de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
    En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client'
    En groep 'client' bij abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk en nl.brp.overleden'
    En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'relatie'
    En groep 'client' bij abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk'
    En de afnemer 'Gemeente Amsterdam' heeft de abonnee 'szw' geregistreerd
    En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'szw' de groep 'client'
    En groep 'client' bij abonnee 'szw' van afnemer 'Gemeente Amsterdam' heeft gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk'
    En de afnemer 'Gemeente Rotterdam' heeft de abonnee 'jz' geregistreerd
    En de afnemer 'Gemeente Rotterdam' heeft bij de abonnee 'jz' de groep 'client'
    En groep 'client' bij abonnee 'jz' van afnemer 'Gemeente Rotterdam' heeft gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk'

  Regel: Een abonnee ontvangt de eigen abonnementen in volgorde dat de abonnementen gezet zijn

    Scenario: Een abonnee heeft abonnementen voor verschillende personen en groepen
      Gegeven de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'client'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Piet' voor de groep 'relatie'
      Als abonnee 'jz' van afnemer 'Gemeente Amsterdam' de abonnementen opvraagt
      Dan worden volgende abonnementen geleverd
        | burgerservicenummer | groep   |
        | Jan                 | client  |
        | Piet                | relatie |

    Scenario: Een abonnee heeft abonnementen voor verschillende groepen op dezelfde persoon
      Gegeven de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'client'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'relatie'
      Als abonnee 'jz' van afnemer 'Gemeente Amsterdam' de abonnementen opvraagt
      Dan worden volgende abonnementen geleverd
        | burgerservicenummer | groep   |
        | Jan                 | client  |
        | Jan                 | relatie |

    Scenario: Een abonnee en een andere abonnee hebben abonnementen
      Gegeven de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'client'
      En de abonnee 'szw' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Piet' voor de groep 'relatie'
      Als abonnee 'jz' van afnemer 'Gemeente Amsterdam' de abonnementen opvraagt
      Dan worden volgende abonnementen geleverd
        | burgerservicenummer | groep  |
        | Jan                 | client |

    Scenario: Een andere afnemer heeft een abonnee met dezelfde naam
      Gegeven de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'client'
      En de abonnee 'jz' van afnemer 'Gemeente Rotterdam' heeft een abonnement op de persoon 'Piet' voor de groep 'relatie'
      Als abonnee 'jz' van afnemer 'Gemeente Amsterdam' de abonnementen opvraagt
      Dan worden volgende abonnementen geleverd
        | burgerservicenummer | groep  |
        | Jan                 | client |

  Regel: Een abonnee ontvangt alleen actieve abonnementen
    Een abonnement dat is opgezegd wordt niet geleverd

    Scenario: Een abonnement is opgezegd
      Gegeven de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'client'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Piet' voor de groep 'relatie'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft het abonnement van de persoon 'Piet' opgezegd voor de groep 'relatie'
      Als abonnee 'jz' van afnemer 'Gemeente Amsterdam' de abonnementen opvraagt
      Dan worden volgende abonnementen geleverd
        | burgerservicenummer | groep  |
        | Jan                 | client |

    Scenario: Een groep is verwijderd waar een abonnement op was
      Gegeven de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'client'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Piet' voor de groep 'relatie'
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'relatie' verwijderd
      Als abonnee 'jz' van afnemer 'Gemeente Amsterdam' de abonnementen opvraagt
      Dan worden volgende abonnementen geleverd
        | burgerservicenummer | groep  |
        | Jan                 | client |

  Regel: De abonnementen kunnen alleen worden gevraagd van een geregistreerde abonnee

    Scenario: Een afnemer vraagt abonnementen van een nog niet geregistreerde abonnee
      Als abonnee 'bestaat-niet' van afnemer 'Gemeente Amsterdam' de abonnementen opvraagt
      Dan is de response '404 Not Found' met de volgende velden
      * 'title' met tekst 'Abonnee bestaat niet'

    Scenario: Een afnemer vraagt abonnementen van een gederegistreerde abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' gederegistreerd
      Als abonnee 'jz' van afnemer 'Gemeente Amsterdam' de abonnementen opvraagt
      Dan is de response '404 Not Found' met de volgende velden
      * 'title' met tekst 'Abonnee bestaat niet'
