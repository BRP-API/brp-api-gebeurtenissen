# language: nl
Functionaliteit: Bepaal gebeurtenissen bij wijzigingen identificatienummers en afvoeren van een persoonslijst
  Dit gaat over de volgende situaties:
  1. Dubbelinschrijving: er zijn voor één persoon meerdere persoonslijsten 
     a. De persoonslijsten hebben hetzelfde A-nummer: één van beide persoonslijsten wordt afgevoerd
     b. De persoonslijsten hebben een verschillend A-nummer: één van beide persoonslijsten wordt afgevoerd én volgend A-nummer wordt gevuld
  2. Verschillende personen hebben hetzelfde A-nummer: beide persoonslijsten wordt het A-nummer gewijzigd én vorig A-nummer wordt gevuld
  3. Onterecht opgevoerde persoonslijst, bijvoorbeeld a.g.v. identiteitsfraude: de persoonslijst wordt afgevoerd

  In tegenstelling tot de BRP bijhouding vanuit burgerzaken identificateren afnemers van gebeurtenissen personen alleen met een burgerservicenummer.
  Zij gebruiken het A-nummer niet.

  Op dit moment zijn voor abonnees van de gebeurtenissen API twee soorten gebeurtenissen relevant:
  A. het burgerservicenummer van een persoon is gewijzigd
  B. er is geen persoonslijst meer van een persoon (omdat deze is afgevoerd)

  Ad A. burgerservicenummer is gewijzigd
    Dit kan op verschillende manieren ontstaan en worden herkend:
    - het burgerservicenummer op de persoonslijst wordt gewijzigd
    - OF volgend A-nummer wordt op de persoonslijst gevuld en de persoonslijst met dat volgende A-nummer heeft een ander burgerservicenummer
    - OF de persoonslijst wordt afgevoerd en een andere persoonslijst met hetzelfde A-nummer heeft een ander burgerservicenummer

  Ad B. persoonslijst is afgevoerd
    Dit gaat over de situatie van onterecht opgevoerde persoonslijst (situatie 3. hierboven).
    Dit is het geval wanneer:
    - opschorting bijhouding met reden 'F' (fout) is gevuld
    - EN er bestaat geen andere persoonslijst met hetzelfde A-nummer
    - EN volgend A-nummer (01.20.20) is leeg
    - EN er bestaat geen andere persoonslijst met hetzelfde burgerservicenummer

  Andere soorten gebeurtenissen, zoals A-nummerwijziging of afvoeren van een dubbel opgenomen persoonslijst, zijn dus niet relevant voor abonnees.
  Deze soorten wijzigingen hoeven dus niet als gebeurtenis geclassificeerd en geleverd te worden.

  Regel: Als het burgerservicenummer van een persoon wijzigt, dan heeft de gebeurtenis 'burgerservicenummer.gewijzigd' plaatsgevonden

    Scenario: Het burgerservicenummer van de persoon wijzigt
      Gegeven de persoon 'Jan' is geregistreerd in de BRP
      * met 'burgerservicenummer' is '000000012'
      * met 'A-nummer' is '9000000001'
      Als besluit wijziging BSN voor 'Jan' is verwerkt
      * met 'burgerservicenummer' is gewijzigd van '000000012' naar '000000024'
      Dan worden de volgende gebeurtenissen geleverd
        | gebeurtenistype                      | burgerservicenummer | nieuwBurgerservicenummer |
        | nl.brp.burgerservicenummer.gewijzigd |           000000012 |                000000024 |

  Regel: Als volgend A-nummer op de persoonslijst wordt gevuld en de persoonslijst met dat volgende A-nummer heeft een ander burgerservicenummer, dan heeft de gebeurtenis 'burgerservicenummer.gewijzigd' plaatsgevonden

    Scenario: Bij het oplossen van dubbelinschrijving met verschillend A-nummer en verschillend burgerservicenummer wordt de A-nummer verwijzing opgenomen op de overbodige persoonslijst
      Gegeven de persoon 'Jan' is geregistreerd in de BRP
      * met 'burgerservicenummer' is '000000012'
      * met 'A-nummer' is '9000000001'
      En de persoon 'tweede persoonslijst van Jan' is geregistreerd in de BRP
      * met 'burgerservicenummer' is '000000024'
      * met 'A-nummer' is '9000000002'
      Als de dubbelinschrijving met verschillende A-nummers is opgelost met 'tweede persoonslijst van Jan' als overbodige persoonslijst
      * met 'Volgend A-nummer' is gevuld met '9000000001'
      Dan worden de volgende gebeurtenissen geleverd
        | gebeurtenistype                      | burgerservicenummer | nieuwBurgerservicenummer |
        | nl.brp.burgerservicenummer.gewijzigd |           000000024 |                000000012 |

    Scenario: Bij het oplossen van dubbelinschrijving met verschillend A-nummer en zelfde burgerservicenummer wordt de A-nummer verwijzing opgenomen op de overbodige persoonslijst
      Gegeven de persoon 'Jan' is geregistreerd in de BRP
      * met 'burgerservicenummer' is '000000012'
      * met 'A-nummer' is '9000000001'
      En de persoon 'tweede persoonslijst van Jan' is geregistreerd in de BRP
      * met 'burgerservicenummer' is '000000012'
      * met 'A-nummer' is '9000000002'
      Als de dubbelinschrijving met verschillende A-nummers is opgelost met 'tweede persoonslijst van Jan' als overbodige persoonslijst
      * met 'Volgend A-nummer' is gevuld met '9000000001'
      Dan is er geen gebeurtenis gepubliceerd voor 'Jan'

    Scenario: Bij het oplossen van dubbelinschrijving met verschillend A-nummer en verschillend burgerservicenummer wordt de A-nummer verwijzing en afvoeren van de persoonslijst in één keer verwerkt
      Gegeven de persoon 'Jan' is geregistreerd in de BRP
      * met 'burgerservicenummer' is '000000012'
      * met 'A-nummer' is '9000000001'
      En de persoon 'tweede persoonslijst van Jan' is geregistreerd in de BRP
      * met 'burgerservicenummer' is '000000024'
      * met 'A-nummer' is '9000000002'
      Als de dubbelinschrijving met verschillende A-nummers is opgelost met 'tweede persoonslijst van Jan' als overbodige persoonslijst
      * met 'Volgend A-nummer' is gevuld met '9000000001'
      * met 'Reden opschorting bijhouding' is gevuld met 'F'
      Dan worden de volgende gebeurtenissen geleverd
        | gebeurtenistype                      | burgerservicenummer | nieuwBurgerservicenummer |
        | nl.brp.burgerservicenummer.gewijzigd |           000000024 |                000000012 |

  Regel: Als de persoonslijst wordt afgevoerd en er is een andere persoonslijst met hetzelfde A-nummer en een ander burgerservicenummer, dan heeft de gebeurtenis 'burgerservicenummer.gewijzigd' plaatsgevonden

    Scenario: Dubbelinschrijving met zelfde A-nummer en verschillend burgerservicenummer wordt opgelost door afvoeren van de overbodige persoonslijst
      Gegeven de persoon 'Jan' is geregistreerd in de BRP
      * met 'burgerservicenummer' is '000000012'
      * met 'A-nummer' is '9000000001'
      En de persoon 'tweede persoonslijst van Jan' is geregistreerd in de BRP
      * met 'burgerservicenummer' is '000000024'
      * met 'A-nummer' is '9000000001'
      Als de dubbelinschrijving met verschillende A-nummers is opgelost met 'tweede persoonslijst van Jan' als overbodige persoonslijst
      * met 'Reden opschorting bijhouding' is gevuld met 'F'
      Dan worden de volgende gebeurtenissen geleverd
        | gebeurtenistype                      | burgerservicenummer | nieuwBurgerservicenummer |
        | nl.brp.burgerservicenummer.gewijzigd |           000000024 |                000000012 |

  Regel: Als de persoonslijst wordt afgevoerd en er is geen andere persoonslijst voor dezelfde persoon, dan heeft de gebeurtenis 'persoonslijst.afgevoerd' plaatsgevonden
    Dit is het geval wanneer aan elk van de volgende condities wordt voldaan:
    - opschorting bijhouding met reden 'F' (fout) is gevuld
    - En er bestaat geen andere persoonslijst met hetzelfde A-nummer
    - En er bestaat geen andere persoonslijst met hetzelfde burgerservicenummer
    - En volgend A-nummer (01.20.20) is leeg

    Scenario: De persoonslijst is afgevoerd
      Gegeven de persoon 'Jan' is geregistreerd in de BRP
      * met 'burgerservicenummer' is '000000012'
      * met 'A-nummer' is '9000000001'
      Als de ten onrechte opgenomen persoonslijst voor 'Jan' is afgevoerd
      * met 'Reden opschorting bijhouding' is gevuld met 'F'
      Dan worden de volgende gebeurtenissen geleverd
        | gebeurtenistype                | burgerservicenummer |
        | nl.brp.persoonslijst.afgevoerd |           000000012 |

    Scenario: Een opgeschorte persoonslijst is afgevoerd
      Gegeven de persoon 'Jan' is geregistreerd in de BRP
      * met 'burgerservicenummer' is '000000012'
      * met 'A-nummer' is '9000000001'
      En 'Jan' is 2 jaar geleden geëmigreerd naar Duitsland
      Als de ten onrechte opgenomen persoonslijst voor 'Jan' is afgevoerd
      * met 'Reden opschorting bijhouding' is gewijzigd van 'E' naar 'F'
      Dan worden de volgende gebeurtenissen geleverd
        | gebeurtenistype                | burgerservicenummer |
        | nl.brp.persoonslijst.afgevoerd |           000000012 |
