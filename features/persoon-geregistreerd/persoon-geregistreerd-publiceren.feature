# language: nl

Functionaliteit: Publiceren van persoon geregistreerd gebeurtenis bij het publiceren van gebeurtenissen voor een persoon

  Regel: Een 'persoon geregistreerd' gebeurtenis wordt gepubliceerd voor een persoon als er voor de persoon nog geen gebeurtenis (ongeacht het type) is gepubliceerd en nog geen abonnement is geregistreerd

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
    # Opmerking: er is nu voor gekozen om gebeurtenissen die worden gepubliceerd voor personen van wie het burgerservicenummer voorkomt op meerdere persoonslijsten niet af te wijzen, ook al kunnen abonnees niet op gebeurtenissen van deze personen abonneren

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
      Dan wordt de gebeurtenispublicatie afgewezen
      En is er geen gebeurtenis gepubliceerd

  Regel: Een 'persoon geregistreerd' gebeurtenis wordt ook gepubliceerd als de betreffende persoon is opgeschort met reden 'F' (fout) of 'W' (wissen)
    # Opmerking: er is nu voor gekozen om gebeurtenissen die worden gepubliceerd voor personen van wie het persoonslijst is opgeschort met reden 'F' of 'W' niet af te wijzen, ook al kunnen abonnees niet op gebeurtenissen van deze personen abonneren

    Abstract Scenario: Een 'overleden' gebeurtenis wordt gepubliceerd voor een persoon en de betreffende persoon is opgeschort met reden '<reden>'
      Gegeven de persoon 'Jan' is geregistreerd in de BRP met opschortreden '<reden>'
      En er zijn nog geen gebeurtenissen gepubliceerd voor 'Jan'
      Als een 'overleden' gebeurtenis wordt gepubliceerd voor 'Jan'
      Dan is een 'persoon geregistreerd' gebeurtenis gepubliceerd voor 'Jan'
      En is een 'overleden' gebeurtenis gepubliceerd voor 'Jan'

      Voorbeelden:
        | reden |
        | F     |
        | W     |
