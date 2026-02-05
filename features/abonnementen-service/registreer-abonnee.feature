# language: nl

Functionaliteit: Registreer abonnee
  Als afnemer van BRP API Gebeurtenissen
  wil ik mijn interne afnemers (applicaties, processen) als abonnee kunnen registreren
  zodat ik de voor hen relevante gebeurtenissen niet zelf hoef te distribueren
  zodat mijn interne afnemers zelf abonnementen kunnen beheren

  Regel: Om een abonnee te kunnen registreren, moet een geldige abonneenaam worden opgegeven

    Scenario: Een afnemer registreert een abonnee met een geldige abonneenaam
      Als de afnemer 'Gemeente Amsterdam' de abonnee 'jz' registreert
      Dan is de response '201 Created'

  Regel: Een 'AbonneeGeregistreerd' gebeurtenis wordt gepubliceerd wanneer een abonnee succesvol is geregistreerd

    Scenario: Een afnemer registreert een abonnee met een geldige abonneenaam
      Als de afnemer 'Gemeente Amsterdam' de abonnee 'jz' registreert
      Dan is een 'AbonneeGeregistreerd' gebeurtenis gepubliceerd met de volgende velden
        | afnemerId          | abonneeNaam |
        | Gemeente Amsterdam | jz          |

  Regel: Een geldige abonneenaam voldoet aan de volgende criteria:
          - bevat alleen kleine letters (a-z) en de koppelteken (-)
          - bevat geen dubbele koppeltekens achter elkaar (--)
          - bevat minimaal 2 en maximaal 10 tekens
          - begint en eindigt niet met de koppelteken (-)

    Abstract Scenario: <titel>
      Als de afnemer 'Gemeente Amsterdam' de abonnee '<abonneeNaam>' registreert
      Dan is de response '400 Bad Request'

      Voorbeelden:
        | titel                                              | abonneeNaam |
        | De abonneenaam is te kort                          | a           |
        | De abonneenaam is te lang                          | abcdefghijk |
        | De abonneenaam bevat hoofdletters                  | JZ          |
        | De abonneenaam bevat een koppelteken aan het begin | -jz         |
        | De abonneenaam bevat een koppelteken aan het einde | jz-         |
        | De abonneenaam bevat dubbele koppeltekens          | j--z        |
        | De abonneenaam bevat een ongeldig tekens           | j_z         |

  Regel: De abonneenaam is uniek binnen de context van een afnemer

    Scenario: De opgegeven abonneenaam is al geregistreerd als abonnee door dezelfde afnemer
      Gegeven er is een 'AbonneeGeregistreerd' gebeurtenis gepubliceerd met de volgende velden
        | afnemerId          | abonneeNaam |
        | Gemeente Amsterdam | jz          |
      Als de afnemer 'Gemeente Amsterdam' de abonnee 'jz' registreert
      Dan is de response '409 Conflict' met de volgende velden
      * 'detail' met tekst 'Uw verzoek kan niet worden uitgevoerd omdat u al een abonnee met de opgegeven naam hebt geregistreerd.'

    Scenario: De opgegeven abonneenaam is al geregistreerd als abonnee door een andere afnemer
      Gegeven er is een 'AbonneeGeregistreerd' gebeurtenis gepubliceerd met de volgende velden
        | afnemerId          | abonneeNaam |
        | Gemeente Rotterdam | jz          |
      Als de afnemer 'Gemeente Amsterdam' de abonnee 'jz' registreert
      Dan is een 'AbonneeGeregistreerd' gebeurtenis gepubliceerd
