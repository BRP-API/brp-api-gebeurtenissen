# language: nl
Functionaliteit: Zegop abonnement

  Regel: Alleen een bestaand abonnement kan worden opgezegd

    Scenario: Een abonnee zegt een bestaand abonnement op
      Gegeven de persoon 'Jan' is geregistreerd in de BRP
      En de abonnee 'szw' van afnemer 'Gemeente Den Haag' heeft zich geabonneerd op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      Als de abonnee 'szw' van afnemer 'Gemeente Den Haag' zijn abonnement op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan' opzegt
      Dan is de response '204 No Content'
      En is een 'AbonnementOpgezegd' gebeurtenis gepubliceerd met de volgende velden
        | afnemerId         | abonneeNaam | gebeurtenistype            | anummer |
        | Gemeente Den Haag | szw         | verhuisd.intergemeentelijk | Jan     |

    Scenario: Een abonnee zegt een niet-bestaand abonnement op
      Gegeven de persoon 'Jan' is geregistreerd in de BRP
      Als de abonnee 'szw' van afnemer 'Gemeente Den Haag' zijn abonnement op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan' opzegt
      Dan is de response '404 Not Found'

  Regel: Voor een reeds opgezegd abonnement wordt geen 'AbonnementOpgezegd' gebeurtenis gepubliceerd

    Scenario: Een abonnee zegt een reeds opgezegd abonnement op
      Gegeven de persoon 'Jan' is geregistreerd in de BRP
      En de abonnee 'szw' van afnemer 'Gemeente Den Haag' heeft zich geabonneerd op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      En de abonnee 'szw' van afnemer 'Gemeente Den Haag' heeft zijn abonnement op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan' opgezegd
      Als de abonnee 'szw' van afnemer 'Gemeente Den Haag' zijn abonnement op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan' opnieuw opzegt
      Dan is de response '204 No Content'

  Regel: Een abonnee kan alle abonnementen op een persoon opzeggen

    Scenario: Een abonnee zegt alle abonnementen op een persoon op
      Gegeven de persoon 'Jan' is geregistreerd in de BRP
      En de abonnee 'szw' van afnemer 'Gemeente Den Haag' heeft zich geabonneerd op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      En de abonnee 'szw' van afnemer 'Gemeente Den Haag' heeft zich geabonneerd op de 'verhuisd.naar-buitenland' gebeurtenissen van 'Jan'
      Als de abonnee 'szw' van afnemer 'Gemeente Den Haag' alle abonnementen op de gebeurtenissen van 'Jan' opzegt
      Dan is de response '204 No Content'
      En zijn er twee 'AbonnementOpgezegd' gebeurtenissen gepubliceerd met de volgende velden
        | afnemerId         | abonneeNaam | gebeurtenistype            | anummer |
        | Gemeente Den Haag | szw         | verhuisd.intergemeentelijk | Jan     |
        | Gemeente Den Haag | szw         | verhuisd.naar-buitenland   | Jan     |
