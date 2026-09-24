#language: nl

@MutatieService
Functionaliteit: Registreren van een persoon in de BRP

  Als consumer van BRP API gebeurtenissen
  Wil ik een persoon kunnen registreren in de BRP
  Zodat ik deze persoon kan gebruiken voor mijn testdoeleinden

  Regel: Een uniek anummer en burgerservicenummer worden gegenereerd bij het registreren van een persoon
    Het anummer en het burgerservicenummer is een string bestaande uit 9 cijfers

    Scenario: Een persoon wordt geregistreerd
      Als de persoon 'Jan' wordt geregistreerd in de BRP
      Dan is de response een PersoonGeregistreerd response
      En is de persoon 'Jan' geregistreerd in de BRP met geslachtsnaam 'Jan', een unieke anummer en burgerservicenummer
