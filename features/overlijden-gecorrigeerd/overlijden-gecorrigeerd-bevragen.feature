# language: nl

Functionaliteit: Ontvangen van overlijden gecorrigeerd gebeurtenissen

  Regel: Een abonnee ontvangt overlijden gecorrigeerd gebeurtenissen voor een persoon als hij is geabonneerd op overleden gebeurtenissen van de betreffende persoon

    Scenario: De abonnee is geabonneerd op overleden gebeurtenissen van een persoon voor wie een correctie op het overlijden is gemeld
      Gegeven de persoon 'Jan' is geregistreerd in de BRP
      En de abonnee 'jz' van de afnemer 'Gemeente Amsterdam' is geabonneerd op overleden gebeurtenissen van 'Jan'
      En het overlijden van 'Jan' is gecorrigeerd
      Als de abonnee 'jz' van de afnemer 'Gemeente Amsterdam' vraagt of er gebeurtenissen hebben plaatsgevonden waarop hij is geabonneerd
      Dan wordt het overlijden gecorrigeerd gebeurtenis van 'Jan' geleverd

    Scenario: De abonnee is niet geabonneerd op overleden gebeurtenissen van een persoon voor wie een correctie op het overlijden is gemeld
      Gegeven de persoon 'Jan' is geregistreerd in de BRP
      En de persoon 'Piet' is geregistreerd in de BRP
      En de abonnee 'jz' van de afnemer 'Gemeente Amsterdam' is geabonneerd op overleden gebeurtenissen van 'Jan'
      En het overlijden van 'Piet' is gecorrigeerd
      Als de abonnee 'jz' van de afnemer 'Gemeente Amsterdam' vraagt of er gebeurtenissen hebben plaatsgevonden waarop hij is geabonneerd
      Dan wordt het overlijden gecorrigeerd gebeurtenis van 'Piet' niet geleverd

  Regel: Een overlijden gecorrigeerd gebeurtenis bevat geen datum van overlijden als de betreffende persoon niet is overleden

  Regel: Een overlijden gecorrigeerd gebeurtenis bevat een nieuwe datum van overlijden als datum van overlijden is gecorrigeerd

  Regel: Een overlijden gecorrigeerd gebeurtenis bevat het originele datum van overlijden als plaats en/of land van overlijden is gecorrigeerd

