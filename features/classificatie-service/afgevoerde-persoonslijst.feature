# language: nl
Functionaliteit: Bepaal gebeurtenissen bij wijzigingen identificatienummers en afvoeren van een persoonslijst
  Dit gaat over de volgende situaties:
  1. Dubbelinschrijving: er zijn voor één persoon meerdere persoonslijsten 
     a. De persoonslijsten hebben hetzelfde A-nummer één van beide persoonslijsten wordt afgevoerd
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
    Dit gaat over de situatie van onterecht opgevoerde persoonslijst (situatie 3. hierboven
    Dit is het geval wanneer:
    - opschorting bijhouding met reden 'F' (fout) is gevuld
    - EN er bestaat geen andere persoonslijst met hetzelfde A-nummer
    - EN volgend A-nummer (01.20.20) is leeg
    - EN er bestaat geen andere persoonslijst met hetzelfde burgerservicenummer

  Andere soorten gebeurtenissen, zoals A-nummerwijziging of afvoeren van een dubbel opgenomen persoonslijst, zijn dus niet relevant voor abonnees.
  Deze soorten wijzigingen hoeven dus niet als gebeurtenis geclassificeerd en geleverd te worden.

  Achtergrond:
    Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
    En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
    En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' het gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk' aan de groep 'client' toegevoegd



    Scenario: Er zijn twee verschillende personen met hetzelfde burgerservicenummer maar verschillend A-nummer
      Gegeven de persoon 'Jan' is geregistreerd in de BRP
      * met burgerservicenummer '000000012'
      * met A-nummer '0000000012'
      En de persoon 'Piet' is geregistreerd in de BRP
      * met burgerservicenummer '000000012'
      * met A-nummer '0000000024'
      Als de abonnee 'jz' van afnemer 'Gemeente Amsterdam' zich abonneert op de persoon met burgerservicenummer '000000012' voor de groep 'client'
