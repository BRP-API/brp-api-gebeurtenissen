# language: nl

Functionaliteit: Publiceren van persoon geregistreerd gebeurtenis bij het abonneren op gebeurtenissen van een persoon

  Regel: Een 'persoon geregistreerd' gebeurtenis wordt gepubliceerd voor een persoon als er voor de persoon nog geen gebeurtenissen zijn gepubliceerd

    Scenario: Een abonnee abonneert zich op een gebeurtenissen groep voor een persoon voor wie er nog geen gebeurtenissen zijn gepubliceerd
      Gegeven de persoon 'Jan' is geregistreerd in de BRP
      En er zijn nog geen gebeurtenissen gepubliceerd voor 'Jan'
      Als een abonnee zich abonneert op de persoon 'Jan' voor de groep 'client'
      Dan is een 'persoon geregistreerd' gebeurtenis gepubliceerd voor 'Jan'
      En is een 'abonnemeent geregistreerd' gebeurtenis voor de groep 'client' en persoon 'Jan' gepubliceerd

    Scenario: Een abonnee abonneert zich op een gebeurtenissen groep voor een persoon voor wie er al gebeurtenissen zijn gepubliceerd
      Gegeven de persoon 'Jan' is geregistreerd in de BRP
      En er is een 'verhuisd intergemeentelijk' gebeurtenis gepubliceerd voor 'Jan'
      Als een abonnee zich abonneert op de persoon 'Jan' voor de groep 'client'
      Dan is alleen een 'abonnemeent geregistreerd' gebeurtenis voor de groep 'client' en persoon 'Jan' gepubliceerd

  Regel: Een 'persoon geregistreerd' gebeurtenis wordt niet gepubliceerd als de persoon niet is geregistreerd in de BRP

    Scenario: Een abonnee abonneert zich op een gebeurtenissen groep voor een persoon die niet is geregistreerd in de BRP
      Als een abonnee zich abonneert op een persoon die niet is geregistreerd in de BRP
      Dan wordt het abonneren afgewezen

  Regel: Een 'persoon geregistreerd' gebeurtenis wordt niet gepubliceerd als de persoon is opgeschort met reden 'F' (fout) of 'W' (wissen)

    Abstract Scenario: Een abonnee abonneert zich op een gebeurtenissen groep voor een persoon, maar de persoon is opgeschort met reden '<reden>'
      Gegeven de persoon 'Jan' is geregistreerd in de BRP met opschortreden '<reden>'
      Als een abonnee zich abonneert op de persoon 'Jan' voor de groep 'client'
      Dan wordt het abonneren afgewezen

      Voorbeelden:
        | reden |
        | F     |
        | W     |

  Regel: Een 'persoon geregistreerd' gebeurtenis wordt niet gepubliceerd als de bij het abonneren opgegeven burgerservicenummer bij meerdere personen is geregistreerd

    Abstract Scenario: Een abonnee abonneert zich op een gebeurtenissen groep voor een persoon, wiens burgerservicenummer is geregistreerd bij meerdere personen
      Gegeven de persoon 'Jan' is geregistreerd in de BRP
      En er zijn nog geen gebeurtenissen gepubliceerd voor 'Jan'
      En de persoon 'Piet' is geregistreerd in de BRP met hetzelfde burgerservicenummer als 'Jan'
      En er zijn nog geen gebeurtenissen gepubliceerd voor 'Piet'
      Als een abonnee zich abonneert op de persoon '<persoon aanduiding>' voor de groep 'client'
      Dan wordt het abonneren afgewezen

      Voorbeelden:
        | persoon aanduiding |
        | Jan                |
        | Piet               |
