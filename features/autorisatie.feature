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

  Regel: Een afnemer die geen gemeente is mag de gebeurtenissen API niet gebruiken
    Elke operatie van de Gebeurtenissen API controleert eerst of de afnemer wel een gemeente is,
    voordat andere controles of acties worden uitgevoerd.

    Scenario: Een afnemer probeert een abonnee te registreren
      Als de afnemer 'Waterschap Rijnland' de abonnee 'jz' registreert
      Dan is de response '403 Unauthorized' met de volgende velden
      * 'title' met tekst 'Niet geautoriseerd'
      * 'detail' met tekst 'Alleen gemeenten mogen de BRP Gebeurtenissen API gebruiken.'

    Scenario: Een afnemer probeert een groep toe te voegen
      Als de afnemer 'Waterschap Rijnland' bij de abonnee 'jz' de groep 'client' toevoegt
      Dan is de response '403 Unauthorized' met de volgende velden
      * 'title' met tekst 'Niet geautoriseerd'
      * 'detail' met tekst 'Alleen gemeenten mogen de BRP Gebeurtenissen API gebruiken.'
