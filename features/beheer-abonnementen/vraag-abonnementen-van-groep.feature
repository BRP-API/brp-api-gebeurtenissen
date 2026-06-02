# language: nl
Functionaliteit: Abonneer persoon voor een groep
  Als abonnee wil ik kunnen raadplegen welke actieve abonnementen ik heb op een bepaalde groep
  zodat ik mijn abonnementen kan beheren

  Als afnemer wil ik kunnen raadplegen welke actieve abonnementen een abonnee heeft op een bepaalde groep
  zodat ik kan zien of de abonnee de groep goed gebruikt

  Achtergrond:
    Gegeven de persoon 'Jan' is geregistreerd in de BRP
    En de persoon 'Piet' is geregistreerd in de BRP
    En de persoon 'Karin' is geregistreerd in de BRP
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

  Regel: Een abonnee kan de abonnementen op een bepaalde groep opgeven
    Hiervoor gebruikt de abonnee optionele parameter 'groepnaam'.

    Scenario: Een abonnee heeft abonnementen voor verschillende personen en groepen
      Gegeven de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'client'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Piet' voor de groep 'relatie'
      En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Karin' voor de groep 'client'
      Als abonnee 'jz' van afnemer 'Gemeente Amsterdam' de abonnementen opvraagt voor groep 'client'
      Dan worden volgende abonnementen geleverd
        | burgerservicenummer | groepnaam |
        | Jan                 | client    |
        | Karin               | client    |

  Regel: Een geldige groepnaam voldoet aan de volgende criteria:
    - bevat alleen kleine letters (a-z), cijfers (0-9) en koppeltekens (-)
    - bevat geen dubbele koppeltekens achter elkaar (--)
    - bevat minimaal 2 en maximaal 64 tekens
    - begint en eindigt niet met een koppelteken (-)

    Scenario: De abonnee geeft een groepnaam met ongeldige tekens
      Als abonnee 'jz' van afnemer 'Gemeente Amsterdam' de abonnementen opvraagt voor groep '!@#$%^&*='
      Dan is de response '400 Bad Request' met de volgende velden
      * 'title' met tekst 'Groepnaam ongeldig'

  Regel: Een abonnee kan een persoon alleen abonnementen voor een bij de abonnee toegevoegde groep vragen

    Scenario: Een abonnee vraagt abonnementen voor een groep die deze niet toegevoegd heeft
      Als abonnee 'jz' van afnemer 'Gemeente Amsterdam' de abonnementen opvraagt voor groep 'andere'
      Dan is de response '409 Conflict' met de volgende velden
      * 'title' met tekst 'Groep bestaat niet'

    Scenario: Een abonnee vraagt abonnementen voor een groep die alleen bij een andere abonnee toegevoegd is
      Gegeven de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'szw' de groep 'andere'
      Als abonnee 'jz' van afnemer 'Gemeente Amsterdam' de abonnementen opvraagt voor groep 'andere'
      Dan is de response '409 Conflict' met de volgende velden
      * 'title' met tekst 'Groep bestaat niet'

    Scenario: Een abonnee vraagt abonnementen voor een groep die alleen bij een andere afnemer toegevoegd is
      Gegeven de afnemer 'Gemeente Rotterdam' heeft bij de abonnee 'jz' de groep 'andere'
      Als abonnee 'jz' van afnemer 'Gemeente Amsterdam' de abonnementen opvraagt voor groep 'andere'
      Dan is de response '409 Conflict' met de volgende velden
      * 'title' met tekst 'Groep bestaat niet'

    Scenario: Een abonnee vraagt abonnementen voor een groep die verwijderd is
      Gegeven de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' verwijderd
      Als abonnee 'jz' van afnemer 'Gemeente Amsterdam' de abonnementen opvraagt voor groep 'client'
      Dan is de response '409 Conflict' met de volgende velden
      * 'title' met tekst 'Groep bestaat niet'
