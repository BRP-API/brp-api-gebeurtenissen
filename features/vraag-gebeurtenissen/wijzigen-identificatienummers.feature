# language: nl
Functionaliteit: Vraag gebeurtenissen wanneer een of de identificatienummer(s) van de persoon gewijzigd is/zijn
  Dit gaat over de volgende situaties:
  1. Dubbelinschrijving: er zijn voor één persoon meerdere persoonslijsten 
     a. De persoonslijsten hebben hetzelfde A-nummer: één van beide persoonslijsten wordt afgevoerd
     b. De persoonslijsten hebben een verschillend A-nummer: één van beide persoonslijsten wordt afgevoerd én volgend A-nummer wordt gevuld
  2. Verschillende personen hebben hetzelfde A-nummer: beide persoonslijsten wordt het A-nummer gewijzigd én vorig A-nummer wordt gevuld
  3. Verschillende personen hebben hetzelfde burgerservicenummer: beide persoonslijsten wordt het burgerservicenummer gewijzigd

  In tegenstelling tot de BRP bijhouding vanuit burgerzaken identificeren abonnees van gebeurtenissen personen alleen met een burgerservicenummer.
  Zij gebruiken het A-nummer niet.

  Dus is het voor de abonnee alleen relevant wanneer het burgerservicenummer van een persoon is gewijzigd.
  Voor de correcte werking van de gebeurtenissen API is het wijzigen van A-nummer wel relevant, om dit de identificatie is van de persoon in de BRP.

  Het wijzigen van een burgerservicenummer kan op verschillende manieren ontstaan en worden herkend:
    - het burgerservicenummer op de persoonslijst wordt gewijzigd
    - OF Volgend A-nummer wordt op de persoonslijst gevuld en de persoonslijst met dat volgende A-nummer heeft een ander burgerservicenummer
    - OF de persoonslijst wordt afgevoerd en een andere persoonslijst met hetzelfde A-nummer heeft een ander burgerservicenummer. Zie hiervoor afvoeren-persoonslijst.feature.

  Achtergrond:
    Gegeven de persoon 'Jan' is geregistreerd in de BRP
    * met 'burgerservicenummer' is '000000012'
    * met 'A-nummer' is '9000000001'
    En de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
    En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
    En groep 'client' bij abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk, nl.brp.verhuisd.naar-buitenland en nl.brp.burgerservicenummer.gewijzigd'
    En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'client'

  Regel: Als het burgerservicenummer van een persoon is gewijzigd, dan heeft de gebeurtenis 'burgerservicenummer.gewijzigd' plaatsgevonden

    Scenario: Het burgerservicenummer van de persoon is gewijzigd, omdat er meerdere personen met hetzelfde burgerservicenummer waren
      Gegeven de persoon 'Piet' is geregistreerd in de BRP
      * met 'burgerservicenummer' is '000000012'
      * met 'A-nummer' is '9000000002'
      En het burgerservicenummer van 'Jan' is gewijzigd van '000000012' naar '000000024'
      En het burgerservicenummer van 'Piet' is gewijzigd van '000000012' naar '000000036'
      Als gebeurtenissen worden gevraagd door abonnee 'jz' van afnemer 'Gemeente Amsterdam'
      Dan worden de volgende gebeurtenissen geleverd
        | gebeurtenistype                      | burgerservicenummer | nieuwBurgerservicenummer |
        | nl.brp.burgerservicenummer.gewijzigd |           000000012 |                000000024 |

  Regel: Als Volgend A-nummer op de persoonslijst wordt gevuld en de persoonslijst met dat volgende A-nummer heeft een ander burgerservicenummer, dan heeft de gebeurtenis 'burgerservicenummer.gewijzigd' plaatsgevonden

    Scenario: Bij het oplossen van dubbelinschrijving met verschillend A-nummer en verschillend burgerservicenummer wordt de A-nummer verwijzing opgenomen op de overbodige persoonslijst
      Gegeven de persoon 'tweede persoonslijst van Jan' is geregistreerd in de BRP
      * met 'burgerservicenummer' is '000000024'
      * met 'A-nummer' is '9000000002'
      En de dubbelinschrijving met verschillende A-nummers is opgelost met 'Jan' als overbodige persoonslijst
      * met 'Volgend A-nummer' is gevuld met '9000000002'
      Als gebeurtenissen worden gevraagd door abonnee 'jz' van afnemer 'Gemeente Amsterdam'
      Dan worden de volgende gebeurtenissen geleverd
        | gebeurtenistype                      | burgerservicenummer | nieuwBurgerservicenummer |
        | nl.brp.burgerservicenummer.gewijzigd |           000000012 |                000000024 |

    Scenario: Bij het oplossen van dubbelinschrijving met verschillend A-nummer en zelfde burgerservicenummer wordt de A-nummer verwijzing opgenomen op de overbodige persoonslijst en er is een abonnement op de overbodig geworden persoonslijst
      Gegeven de persoon 'tweede persoonslijst van Jan' is geregistreerd in de BRP
      * met 'burgerservicenummer' is '000000012'
      * met 'A-nummer' is '9000000002'
      En de dubbelinschrijving met verschillende A-nummers is opgelost met 'Jan' als overbodige persoonslijst
      * met 'Volgend A-nummer' is gevuld met '9000000002'
      Als gebeurtenissen worden gevraagd door abonnee 'jz' van afnemer 'Gemeente Amsterdam'
      Dan is er geen gebeurtenis gepubliceerd voor 'Jan'
      # Maar... voor het oplossen van de dubbelinschrijving kon de abonnee geen gegevens ophalen van wijzigingen, omdat bsn niet uniek was
      # Mogelijk zijn er daardoor gebeurtenissen geweest op de overgebleven persoonslijst die de abonnee gemist heeft
      # En zijn de correcties op de 
      # Moet de abonnee dan niet alsnog hiervan op de hoogte worden gesteld?

    Scenario: Bij het oplossen van dubbelinschrijving met verschillend A-nummer en zelfde burgerservicenummer wordt de A-nummer verwijzing opgenomen op de overbodige persoonslijst en er is een abonnement op de overblijvende persoonslijst
      Gegeven de persoon 'tweede persoonslijst van Jan' is geregistreerd in de BRP
      * met 'burgerservicenummer' is '000000012'
      * met 'A-nummer' is '9000000002'
      En de dubbelinschrijving met verschillende A-nummers is opgelost met 'tweede persoonslijst van Jan' als overbodige persoonslijst
      * met 'Volgend A-nummer' is gevuld met '9000000001'
      En de overgebleven persoonslijst is is gewijzigd
      * met 'Vorig A-nummer' is gevuld met '9000000002'
      Als gebeurtenissen worden gevraagd door abonnee 'jz' van afnemer 'Gemeente Amsterdam'
      Dan is er geen gebeurtenis gepubliceerd voor 'Jan'

    Scenario: Bij het oplossen van dubbelinschrijving met verschillend A-nummer en verschillend burgerservicenummer wordt de A-nummer verwijzing en afvoeren van de persoonslijst in één keer verwerkt
      Gegeven de persoon 'tweede persoonslijst van Jan' is geregistreerd in de BRP
      * met 'burgerservicenummer' is '000000024'
      * met 'A-nummer' is '9000000002'
      En de dubbelinschrijving met verschillende A-nummers is opgelost met 'Jan' als overbodige persoonslijst
      * met 'Volgend A-nummer' is gevuld met '9000000002'
      * met 'Reden opschorting bijhouding' is gevuld met 'F'
      Als gebeurtenissen worden gevraagd door abonnee 'jz' van afnemer 'Gemeente Amsterdam'
      Dan worden de volgende gebeurtenissen geleverd
        | gebeurtenistype                      | burgerservicenummer | nieuwBurgerservicenummer |
        | nl.brp.burgerservicenummer.gewijzigd |           000000012 |                000000024 |

  Regel: Na een burgerservicenummerwijziging behouden de abonnees hun abonnement op deze persoon
    Ze kunnen dan nog gebeurtenissen ontvangen van voor de burgerservicenummerwijziging, met daarin het oude burgerservicenummer.
    En ze kunnen gebeurtenissen ontvangen van na de burgerservicenummerwijziging, met daarin het nieuwe burgerservicenummer.

    Scenario: Er zijn gebeurtenissen voor en na het wijzigen van het burgerservicenummer
      Gegeven er is een 'nl.brp.verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor persoon 'Jan'
      En het burgerservicenummer van 'Jan' is gewijzigd van '000000012' naar '000000024'
      En er is een 'nl.brp.verhuisd.naar-buitenland' gebeurtenis gepubliceerd voor persoon 'Jan'
      Als gebeurtenissen worden gevraagd door abonnee 'jz' van afnemer 'Gemeente Amsterdam'
      Dan worden de volgende gebeurtenissen geleverd
        | gebeurtenistype                      | burgerservicenummer |
        | nl.brp.verhuisd.intergemeentelijk    |           000000012 |
        | nl.brp.burgerservicenummer.gewijzigd |           000000012 |
        | nl.brp.verhuisd.naar-buitenland      |           000000024 |
      # Maar... op het moment dat de abonnee deze gebeurtenissen opvraagt, kan in de BRP-API niet meer worden geraadpleegd op het oude burgerservicenummer.
      # Dus als ze van oud naar nieuw de gebeurtenissen verwerken - wat de juiste aanpak is -  dan kunnen ze verhuisd.intergemeentelijk niet meer verwerken wanneer ze daar raadplegen op burgerservicenummer bij nodig hebben.

    Scenario: Er zijn gebeurtenissen op de overbodige persoonslijst en na het overzetten naar de overgebleven persoonslijst met een ander burgerservicenummer
      Gegeven de persoon 'tweede persoonslijst van Jan' is geregistreerd in de BRP
      * met 'burgerservicenummer' is '000000024'
      * met 'A-nummer' is '9000000002'
      En er is een 'nl.brp.verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor persoon 'Jan'
      En de dubbelinschrijving met verschillende A-nummers is opgelost met 'Jan' als overbodige persoonslijst
      * met 'Volgend A-nummer' is gevuld met '9000000002'
      En er is een 'nl.brp.verhuisd.naar-buitenland' gebeurtenis gepubliceerd voor persoon 'tweede persoonslijst van Jan'
      Als gebeurtenissen worden gevraagd door abonnee 'jz' van afnemer 'Gemeente Amsterdam'
      Dan worden de volgende gebeurtenissen geleverd
        | gebeurtenistype                      | burgerservicenummer |
        | nl.brp.verhuisd.intergemeentelijk    |           000000012 |
        | nl.brp.burgerservicenummer.gewijzigd |           000000012 |
        | nl.brp.verhuisd.naar-buitenland      |           000000024 |
      # Maar... op het moment dat de abonnee deze gebeurtenissen opvraagt, kan in de BRP-API niet meer worden geraadpleegd op het oude burgerservicenummer.
      # Dus als ze van oud naar nieuw de gebeurtenissen verwerken - wat de juiste aanpak is -  dan kunnen ze verhuisd.intergemeentelijk niet meer verwerken wanneer ze daar raadplegen op burgerservicenummer bij nodig hebben.

  Regel: Na een A-nummerwijziging behouden de abonnees hun abonnement op deze persoon

    Scenario: Het A-nummer van een persoon is gewijzigd, omdat er meerdere personen zijn met hetzelfde A-nummer, en er zijn gebeurtenissen voor en na de A-nummerwijziging
      Gegeven de persoon 'Piet' is geregistreerd in de BRP
      * met 'burgerservicenummer' is '000000024'
      * met 'A-nummer' is '9000000001'
      En er is een 'nl.brp.verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor persoon 'Jan'
      En het A-nummer van 'Jan' is gewijzigd van '9000000001' naar '9000000002'
      * met 'Vorig A-nummer' is gevuld met '9000000001'
      En het A-nummer van 'Piet' is gewijzigd van '9000000001' naar '9000000003'
      * met 'Vorig A-nummer' is gevuld met '9000000001'
      En er is een 'nl.brp.verhuisd.naar-buitenland' gebeurtenis gepubliceerd voor persoon 'Jan'
      Als gebeurtenissen worden gevraagd door abonnee 'jz' van afnemer 'Gemeente Amsterdam'
      Dan worden de volgende gebeurtenissen geleverd
        | gebeurtenistype                   | burgerservicenummer |
        | nl.brp.verhuisd.intergemeentelijk |           000000012 |
        | nl.brp.verhuisd.naar-buitenland   |           000000012 |

    Scenario: Er zijn gebeurtenissen op de overbodig geworden persoonslijst en gebeurtenissen na het overzetten naar de overgebleven persoonslijst zonder burgerservicenummerwijziging
      Gegeven de persoon 'tweede persoonslijst van Jan' is geregistreerd in de BRP
      * met 'burgerservicenummer' is '000000012'
      * met 'A-nummer' is '9000000002'
      En er is een 'nl.brp.verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor persoon 'Jan'
      En de dubbelinschrijving met verschillende A-nummers is opgelost met 'Jan' als overbodige persoonslijst
      * met 'Volgend A-nummer' is gevuld met '9000000002'
      En er is een 'nl.brp.verhuisd.naar-buitenland' gebeurtenis gepubliceerd voor persoon 'tweede persoonslijst van Jan'
      Als gebeurtenissen worden gevraagd door abonnee 'jz' van afnemer 'Gemeente Amsterdam'
      Dan worden de volgende gebeurtenissen geleverd
        | gebeurtenistype                   | burgerservicenummer |
        | nl.brp.verhuisd.intergemeentelijk |           000000012 |
        | nl.brp.verhuisd.naar-buitenland   |           000000012 |
