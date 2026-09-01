# language: nl
Functionaliteit: Alleen gemeenten als afnemer mogen de Gebeurtenissen API gebruiken

  Regel: Een gemeente mag de gebeurtenissen API gebruiken

    Scenario: Een gemeente probeert een abonnee te registreren
      Gegeven de geauthenticeerde consumer 'Arnhem' is een gemeente
      Als de afnemer 'Arnhem' de abonnee 'jz' registreert
      Dan is de response '201 Created'

  Regel: Een afnemer die geen gemeente is mag de gebeurtenissen API niet gebruiken
  Elke operatie van de Gebeurtenissen API controleert eerst of de afnemer wel een gemeente is,
  voordat andere controles of acties worden uitgevoerd.

    Scenario: Een afnemer probeert een abonnee te registreren
      Gegeven de geauthenticeerde consumer 'Waterschap Rijnland' is geen gemeente
      Als de afnemer 'Waterschap Rijnland' de abonnee 'jz' registreert
      Dan is de response '403 Unauthorized' met de volgende velden
      * 'title' met tekst 'Niet geautoriseerd'
      * 'detail' met tekst 'Alleen gemeenten mogen de BRP Gebeurtenissen API gebruiken.'

    Scenario: Een afnemer probeert een groep toe te voegen aan een abonnee die niet is geregistreerd
      Gegeven de geauthenticeerde consumer 'Waterschap Rijnland' is geen gemeente
      Als de afnemer 'Waterschap Rijnland' bij de abonnee 'jz' de groep 'client' toevoegt
      Dan is de response '403 Unauthorized' met de volgende velden
      * 'title' met tekst 'Niet geautoriseerd'
      * 'detail' met tekst 'Alleen gemeenten mogen de BRP Gebeurtenissen API gebruiken.'

    Scenario: Een afnemer probeert een abonnee te registreren met een niet valide naam
      Gegeven de geauthenticeerde consumer 'Waterschap Rijnland' is geen gemeente
      Als de afnemer 'Waterschap Rijnland' de abonnee 'JZ--' registreert
      Dan is de response '403 Unauthorized' met de volgende velden
      * 'title' met tekst 'Niet geautoriseerd'
      * 'detail' met tekst 'Alleen gemeenten mogen de BRP Gebeurtenissen API gebruiken.'

    Scenario: Een afnemer probeert een abonnee te registreren zonder een abonneenaam op te geven
      Gegeven de geauthenticeerde consumer 'Waterschap Rijnland' is geen gemeente
      Als de afnemer 'Waterschap Rijnland' een abonnee registreert zonder een naam voor de abonnee op te geven
      Dan is de response '403 Unauthorized' met de volgende velden
      * 'title' met tekst 'Niet geautoriseerd'
      * 'detail' met tekst 'Alleen gemeenten mogen de BRP Gebeurtenissen API gebruiken.'
