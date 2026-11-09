# language: nl

Functionaliteit: Publiceren van persoon geregistreerd gebeurtenis bij het publiceren van gebeurtenissen voor een persoon

  Regel: Een 'persoon geregistreerd' gebeurtenis wordt gepubliceerd voor een persoon als er voor de persoon nog geen gebeurtenissen zijn gepubliceerd

    Abstract Scenario: Een '<gebeurtenistype>' gebeurtenis wordt gepubliceerd voor een persoon voor wie nog geen gebeurtenissen zijn gepubliceerd
      Gegeven de persoon 'Jan' is geregistreerd in de BRP
      En er zijn nog geen gebeurtenissen gepubliceerd voor 'Jan'
      Als een '<gebeurtenistype>' gebeurtenis wordt gepubliceerd voor 'Jan'
      Dan is een 'persoon geregistreerd' gebeurtenis gepubliceerd voor 'Jan'
      En is een '<gebeurtenistype>' gebeurtenis gepubliceerd voor 'Jan'

      Voorbeelden:
        | gebeurtenistype            |
        | verhuisd intergemeentelijk |
        | verhuisd naar buitenland   |
        | overleden                  |

    Scenario: Een 'verhuisd naar buitenland' gebeurtenis wordt gepubliceerd voor een persoon voor wie er al gebeurtenissen zijn gepubliceerd
      Gegeven de persoon 'Jan' is geregistreerd in de BRP
      En er is een 'verhuisd intergemeentelijk' gebeurtenis gepubliceerd voor 'Jan'
      Als een 'verhuisd naar buitenland' gebeurtenis wordt gepubliceerd voor 'Jan'
      Dan is alleen een 'verhuisd naar buitenland' gebeurtenis gepubliceerd voor 'Jan'

  Regel: Een 'persoon geregistreerd' gebeurtenis wordt ook gepubliceerd als meerdere personen hetzelfde burgerservicenummer hebben als de betreffende persoon
    # er kan niet meer op het betreffende burgerservicenummer worden geabonneerd

    Abstract Scenario: Een 'verhuisd intergemeentelijk' gebeurtenis wordt gepubliceerd voor een persoon, maar meerdere personen hebben hetzelfde burgerservicenummer als de betreffende persoon
      Gegeven de persoon 'Jan' is geregistreerd in de BRP
      En er zijn nog geen gebeurtenissen gepubliceerd voor 'Jan'
      En de persoon 'Piet' is geregistreerd in de BRP met hetzelfde burgerservicenummer als 'Jan'
      En er zijn nog geen gebeurtenissen gepubliceerd voor 'Piet'
      Als een 'verhuisd intergemeentelijk' gebeurtenis wordt gepubliceerd voor '<persoon aanduiding>'
      Dan is een 'persoon geregistreerd' gebeurtenis gepubliceerd voor '<persoon aanduiding>'
      En is een 'verhuisd intergemeentelijk' gebeurtenis gepubliceerd voor '<persoon aanduiding>'

      Voorbeelden:
        | persoon aanduiding |
        | Jan                |
        | Piet               |

  Regel: Een 'persoon geregistreerd' gebeurtenis wordt niet gepubliceerd als de persoon niet is geregistreerd in de BRP

    Scenario: Een 'verhuisd intergemeentelijk' gebeurtenis wordt gepubliceerd voor een persoon die niet is geregistreerd in de BRP
      Als een 'verhuisd intergemeentelijk' gebeurtenis wordt gepubliceerd voor een persoon die niet is geregistreerd in de BRP
      Dan wordt de gebeurtenis publicatie voor 'Jan' afgewezen

  Regel: Een 'persoon geregistreerd' gebeurtenis wordt niet gepubliceerd als de persoon is opgeschort met reden 'F' (fout) or 'W' (wissen)

    Abstract Scenario: Een 'overleden' gebeurtenis wordt gepubliceerd voor een persoon, maar de persoon is opgeschort met reden '<reden>'
      Gegeven de persoon 'Jan' is geregistreerd in de BRP met opschortreden '<reden>'
      Als een 'overleden' gebeurtenis wordt gepubliceerd voor 'Jan'
      Dan wordt de gebeurtenis publicatie voor 'Jan' afgewezen

      Voorbeelden:
        | reden |
        | F     |
        | W     |
