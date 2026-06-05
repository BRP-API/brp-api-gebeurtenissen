# language: nl
Functionaliteit: Abonneer persoon met burgerservicenummer dat niet uniek is

  Achtergrond:
    Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
    En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
    En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' het gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk' aan de groep 'client' toegevoegd

  Regel: Als er meerdere persoonslijsten zijn met hetzelfde burgerservicenummer kan de abonnee hier niet op abonneren

    Scenario: Er zijn twee verschillende personen met hetzelfde burgerservicenummer maar verschillend A-nummer
      Gegeven de persoon 'Jan' is geregistreerd in de BRP
      * met burgerservicenummer '000000012'
      * met A-nummer '0000000012'
      En de persoon 'Piet' is geregistreerd in de BRP
      * met burgerservicenummer '000000012'
      * met A-nummer '0000000024'
      Als de abonnee 'jz' van afnemer 'Gemeente Amsterdam' zich abonneert op de persoon met burgerservicenummer '000000012' voor de groep 'client'
      Dan is de response '409 Conflict' met de volgende velden
      * 'title' met tekst 'Het opgegeven burgerservicenummer is niet uniek.'

    Scenario: De persoonslijst komt dubbel voor
      Gegeven de persoon 'Jan' is geregistreerd in de BRP
      * met burgerservicenummer '000000012'
      * met A-nummer '0000000012'
      En de persoon 'Jan' is opnieuw geregistreerd in de BRP met hetzelfde gegevens
      Als de abonnee 'jz' van afnemer 'Gemeente Amsterdam' zich abonneert op de persoon met burgerservicenummer '000000012' voor de groep 'client'
      Dan is de response '409 Conflict' met de volgende velden
      * 'title' met tekst 'Het opgegeven burgerservicenummer is niet uniek.'

  Regel: Als er meerdere persoonslijsten zijn en één van beide persoonslijsten is gewist of afgevoerd dan kan de abonnee abonneren

    Scenario: Een van de persoonslijsten is <omschrijving reden opschorting>
      Gegeven de persoon 'Jan' is geregistreerd in de BRP
      * met burgerservicenummer '000000012'
      * met A-nummer '0000000012'
      En de persoon 'Jan' is opnieuw geregistreerd in de BRP met hetzelfde gegevens
      En de tweede registratie van 'Jan' is opgeschort met reden '<reden opschorting>'
      Als de abonnee 'jz' van afnemer 'Gemeente Amsterdam' zich abonneert op de persoon met burgerservicenummer '000000012' voor de groep 'client'
      Dan is de response '201 Created'

      Voorbeelden:
        | reden opschorting | omschrijving reden opschorting |
        | F                 | afgevoerd                      |
        | W                 | gewist                         |

    Scenario: Een van de persoonslijsten is opgeschort wegens <omschrijving reden opschorting> van de persoon
      Gegeven de persoon 'Jan' is geregistreerd in de BRP
      * met burgerservicenummer '000000012'
      * met A-nummer '0000000012'
      En de persoon 'Jan' is opnieuw geregistreerd in de BRP met hetzelfde gegevens
      En de tweede registratie van 'Jan' is opgeschort met reden '<reden opschorting>'
      Als de abonnee 'jz' van afnemer 'Gemeente Amsterdam' zich abonneert op de persoon met burgerservicenummer '000000012' voor de groep 'client'
      Dan is de response '409 Conflict' met de volgende velden
      * 'title' met tekst 'Het opgegeven burgerservicenummer is niet uniek.'

      Voorbeelden:
        | reden opschorting | omschrijving reden opschorting |
        | E                 | emigratie                      |
        | O                 | overlijden                     |
