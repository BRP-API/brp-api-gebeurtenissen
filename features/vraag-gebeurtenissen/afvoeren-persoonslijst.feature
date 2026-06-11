# language: nl
Functionaliteit: Bepaal gebeurtenissen bij wijzigingen identificatienummers en afvoeren van een persoonslijst
  Een persoonslijst wordt afgevoerd in de volgende situaties:
  1. Dubbelinschrijving: er zijn voor één persoon meerdere persoonslijsten 
     a. De persoonslijsten hebben hetzelfde A-nummer: één van beide persoonslijsten wordt afgevoerd
     b. De persoonslijsten hebben een verschillend A-nummer: één van beide persoonslijsten wordt afgevoerd 
        én er wordt verwezen naar de overgebleven persoonslijst met Volgend A-nummer
  2. Onterecht opgevoerde persoonslijst, bijvoorbeeld a.g.v. identiteitsfraude: de persoonslijst wordt afgevoerd

  Voor abonnees van de gebeurtenissen API zijn twee soorten gebeurtenissen die uit het afvoeren van een persoonslijst volgen relevant:
  - het burgerservicenummer van een persoon is gewijzigd (als gevolg van oplossen dubbelinschrijving)
  - er is geen persoonslijst meer van een persoon (omdat deze is afgevoerd)

  Burgerservicenummer is gewijzigd
    Dit is het geval wanneer de persoonslijst wordt afgevoerd en een andere persoonslijst met hetzelfde A-nummer 
    heeft een ander burgerservicenummer.
    Dit kan ook het geval zijn wanneer bij de afgevoerde persoonslijst Volgend A-nummer is gevuld en de persoonslijst 
    met dat A-nummer heeft een ander burgerservicenummer. Zie hiervoor wijzigen-identificatienummers.feature.

  Persoonslijst is afgevoerd
    Dit gaat over de situatie van onterecht opgevoerde persoonslijst (situatie 3. hierboven).
    Dit is het geval wanneer:
    - opschorting bijhouding met reden 'F' (fout) is gevuld
    - EN er bestaat geen andere persoonslijst met hetzelfde A-nummer
    - EN Volgend A-nummer (01.20.20) is leeg
    - EN er bestaat geen andere persoonslijst met hetzelfde burgerservicenummer

    Is er wel een andere persoonslijst met hetzelfde A-nummer, of een andere persoonslijst met hetzelfde burgerservicenummer of er is een verwijzing 
    naar een andere persoonslijst (Volgend-A-nummer), dan is sprake van een dubbelinschrijving die is opgelost. Zie daarvoor wijzigen-identificatienummers.feature. 
    De persoon bestaat dan nog wel en er is nog een persoonslijst voor de persoon.

  Achtergrond:
    Gegeven de persoon 'Jan' is geregistreerd in de BRP
    * met 'burgerservicenummer' is '000000012'
    * met 'A-nummer' is '9000000001'
    En de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
    En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
    En groep 'client' bij abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk en nl.brp.verhuisd.naar-buitenland'
    En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'client'

  Regel: Als de persoonslijst wordt afgevoerd en er is een andere persoonslijst met hetzelfde A-nummer en een ander burgerservicenummer, dan heeft de gebeurtenis 'burgerservicenummer.gewijzigd' plaatsgevonden

    Scenario: Dubbelinschrijving met zelfde A-nummer en verschillend burgerservicenummer wordt opgelost door afvoeren van de overbodige persoonslijst
      Gegeven de persoon 'tweede persoonslijst van Jan' is geregistreerd in de BRP
      * met 'burgerservicenummer' is '000000024'
      * met 'A-nummer' is '9000000001'
      En de dubbelinschrijving met hetzelfde A-nummer is opgelost met 'Jan' als overbodige persoonslijst
      * met 'Reden opschorting bijhouding' is gevuld met 'F'
      Als gebeurtenissen worden gevraagd door abonnee 'jz' van afnemer 'Gemeente Amsterdam'
      Dan worden de volgende gebeurtenissen geleverd
        | gebeurtenistype                      | burgerservicenummer | nieuwBurgerservicenummer |
        | nl.brp.burgerservicenummer.gewijzigd |           000000012 |                000000024 |

  Regel: Als de persoonslijst wordt afgevoerd en er is geen andere persoonslijst voor dezelfde persoon, dan heeft de gebeurtenis 'persoonslijst.afgevoerd' plaatsgevonden
    Dit is het geval wanneer aan elk van de volgende condities wordt voldaan:
    - opschorting bijhouding met reden 'F' (fout) is gevuld
    - En er bestaat geen andere persoonslijst met hetzelfde A-nummer
    - En er bestaat geen andere persoonslijst met hetzelfde burgerservicenummer
    - En volgend A-nummer (01.20.20) is leeg

    Scenario: De persoonslijst is afgevoerd
      Gegeven de ten onrechte opgenomen persoonslijst voor 'Jan' is afgevoerd
      * met 'Reden opschorting bijhouding' is gevuld met 'F'
      Als gebeurtenissen worden gevraagd door abonnee 'jz' van afnemer 'Gemeente Amsterdam'
      Dan worden de volgende gebeurtenissen geleverd
        | gebeurtenistype                | burgerservicenummer |
        | nl.brp.persoonslijst.afgevoerd |           000000012 |

    Scenario: Een opgeschorte persoonslijst is afgevoerd
      Gegeven 'Jan' is 2 jaar geleden geëmigreerd naar Duitsland
      En de ten onrechte opgenomen persoonslijst voor 'Jan' is afgevoerd
      * met 'Reden opschorting bijhouding' is gewijzigd van 'E' naar 'F'
      Als gebeurtenissen worden gevraagd door abonnee 'jz' van afnemer 'Gemeente Amsterdam'
      Dan worden de volgende gebeurtenissen geleverd
        | gebeurtenistype                | burgerservicenummer |
        | nl.brp.persoonslijst.afgevoerd |           000000012 |
