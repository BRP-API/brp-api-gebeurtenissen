# language: nl
Functionaliteit: Alleen gemeenten als afnemer mogen de Gebeurtenissen API gebruiken

  Achtergrond:
    Gegeven de afnemer 'Gemeente Amsterdam' heeft de volgende 'claim' gegevens
      | naam         | waarde                |
      | afnemerID    |                000008 |
      | OIN          | 000000099000000080000 |
      | gemeenteCode |                  0800 |
    En de afnemer 'Waterschap Rijnland' heeft de volgende 'claim' gegevens
      | naam      | waarde                |
      | afnemerID |                000009 |
      | OIN       | 000000099000000090000 |

  Regel: Een gemeente mag de gebeurtenissen API gebruiken

    Scenario: Een gemeente probeert een abonnee te registreren
      Als de afnemer 'Gemeente Amsterdam' de abonnee 'jz' registreert
      Dan is de response '201 Created'

    Scenario: Een gemeente probeert een abonnement op een persoon te zetten
      Gegeven de persoon 'Jan' is geregistreerd in de BRP
      En de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
      Als de abonnee 'jz' van afnemer 'Gemeente Amsterdam' zich abonneert op de persoon 'Jan' voor de groep 'client'
      Dan is de response '201 Created'

    Scenario: Een gemeente probeert gebeurtenissen te vragen
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      Als gebeurtenissen worden gevraagd door abonnee 'jz' van afnemer 'Gemeente Amsterdam'
      Dan is de response '200 OK'

  Regel: Een afnemer die geen gemeente is mag de gebeurtenissen API niet gebruiken
    Elke operatie van de Gebeurtenissen API controleert eerst of de afnemer wel een gemeente is,
    voordat andere controles of acties worden uitgevoerd.

    Scenario: Een afnemer probeert een abonnee te registreren
      Als de afnemer 'Waterschap Rijnland' de abonnee 'jz' registreert
      Dan is de response '403 Unauthorized' met de volgende velden
      * 'title' met tekst 'Niet geautoriseerd'
      * 'detail' met tekst 'Alleen gemeenten mogen de BRP Gebeurtenissen API gebruiken.'

    Scenario: Een afnemer probeert de abonnees te vragen
      Als de afnemer 'Waterschap Rijnland' zijn abonnees raadpleegt
      Dan is de response '403 Unauthorized' met de volgende velden
      * 'title' met tekst 'Niet geautoriseerd'
      * 'detail' met tekst 'Alleen gemeenten mogen de BRP Gebeurtenissen API gebruiken.'

    Scenario: Een afnemer probeert een abonnee te verwijderen
      Als de afnemer 'Waterschap Rijnland' de abonnee 'jz' deregistreert
      Dan is de response '403 Unauthorized' met de volgende velden
      * 'title' met tekst 'Niet geautoriseerd'
      * 'detail' met tekst 'Alleen gemeenten mogen de BRP Gebeurtenissen API gebruiken.'

    Scenario: Een afnemer probeert een groep toe te voegen
      Als de afnemer 'Waterschap Rijnland' bij de abonnee 'jz' de groep 'client' toevoegt
      Dan is de response '403 Unauthorized' met de volgende velden
      * 'title' met tekst 'Niet geautoriseerd'
      * 'detail' met tekst 'Alleen gemeenten mogen de BRP Gebeurtenissen API gebruiken.'

    Scenario: Een afnemer probeert de groepen van een abonnee te vragen
      Als de afnemer 'Waterschap Rijnland' de groepen van abonnee 'jz' opvraagt
      Dan is de response '403 Unauthorized' met de volgende velden
      * 'title' met tekst 'Niet geautoriseerd'
      * 'detail' met tekst 'Alleen gemeenten mogen de BRP Gebeurtenissen API gebruiken.'

    Scenario: Een afnemer probeert een groep te verwijderen
      Als de afnemer 'Waterschap Rijnland' bij de abonnee 'jz' de groep 'client' verwijdert
      Dan is de response '403 Unauthorized' met de volgende velden
      * 'title' met tekst 'Niet geautoriseerd'
      * 'detail' met tekst 'Alleen gemeenten mogen de BRP Gebeurtenissen API gebruiken.'

    Scenario: Een afnemer probeert een gebeurtenistype toe te voegen aan een groep
      Als de afnemer 'Waterschap Rijnland' bij de abonnee 'jz' het gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk' aan de groep 'client' toevoegt
      Dan is de response '403 Unauthorized' met de volgende velden
      * 'title' met tekst 'Niet geautoriseerd'
      * 'detail' met tekst 'Alleen gemeenten mogen de BRP Gebeurtenissen API gebruiken.'

    Scenario: Een afnemer probeert de gebeurtenistypes van een groep te vragen
      Als de afnemer 'Waterschap Rijnland' de gebeurtenistypes van groep 'client' van abonnee 'jz' opvraagt
      Dan is de response '403 Unauthorized' met de volgende velden
      * 'title' met tekst 'Niet geautoriseerd'
      * 'detail' met tekst 'Alleen gemeenten mogen de BRP Gebeurtenissen API gebruiken.'

    Scenario: Een afnemer probeert een gebeurtenis uit een groep te verwijderen
      Als de afnemer 'Waterschap Rijnland' bij de abonnee 'jz' het gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk' uit de groep 'client' verwijdert
      Dan is de response '403 Unauthorized' met de volgende velden
      * 'title' met tekst 'Niet geautoriseerd'
      * 'detail' met tekst 'Alleen gemeenten mogen de BRP Gebeurtenissen API gebruiken.'

    Scenario: Een afnemer probeert een abonnement op een persoon te zetten
      Als de abonnee 'jz' van afnemer 'Waterschap Rijnland' zich abonneert op de persoon 'Jan' voor de groep 'client'
      Dan is de response '403 Unauthorized' met de volgende velden
      * 'title' met tekst 'Niet geautoriseerd'
      * 'detail' met tekst 'Alleen gemeenten mogen de BRP Gebeurtenissen API gebruiken.'

    Scenario: Een afnemer probeert abonnementen te vragen
      Als abonnee 'jz' van afnemer 'Waterschap Rijnland' de abonnementen opvraagt
      Dan is de response '403 Unauthorized' met de volgende velden
      * 'title' met tekst 'Niet geautoriseerd'
      * 'detail' met tekst 'Alleen gemeenten mogen de BRP Gebeurtenissen API gebruiken.'

    Scenario: Een afnemer probeert een abonnement op te zeggen
      Als de abonnee 'jz' van afnemer 'Waterschap Rijnland' zijn abonnement op de persoon 'Jan' voor de groep 'client' opzegt
      Dan is de response '403 Unauthorized' met de volgende velden
      * 'title' met tekst 'Niet geautoriseerd'
      * 'detail' met tekst 'Alleen gemeenten mogen de BRP Gebeurtenissen API gebruiken.'

    Scenario: Een afnemer probeert gebeurtenissen te vragen
      Als gebeurtenissen worden gevraagd door abonnee 'jz' van afnemer 'Waterschap Rijnland'
      Dan is de response '403 Unauthorized' met de volgende velden
      * 'title' met tekst 'Niet geautoriseerd'
      * 'detail' met tekst 'Alleen gemeenten mogen de BRP Gebeurtenissen API gebruiken.'
