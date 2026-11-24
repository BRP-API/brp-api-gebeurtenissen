# language: nl

Functionaliteit: Gebruik van dezelfde persoonId bij het abonneren op en het publiceren van gebeurtenissen voor een persoon

  Regel: Een gebeurtenis voor een persoon op wie al is geabonneerd, bevat de persoonId uit de 'persoon geregistreerd' gebeurtenis die bij het abonneren is gepubliceerd

    Scenario: Een gebeurtenis wordt gepubliceerd voor een persoon op wie is geabonneerd voordat er gebeurtenissen voor de persoon waren gepubliceerd
      Gegeven de persoon 'Jan' is geregistreerd in de BRP
      En er zijn nog geen gebeurtenissen gepubliceerd voor 'Jan'
      En een abonnee heeft zich geabonneerd op de persoon 'Jan' voor de groep 'client'
      Als een 'verhuisd intergemeentelijk' gebeurtenis wordt gepubliceerd voor 'Jan'
      Dan is alleen een 'verhuisd intergemeentelijk' gebeurtenis gepubliceerd voor 'Jan'
      En is de persoonId in de 'verhuisd intergemeentelijk' gebeurtenis gelijk aan de persoonId in de 'persoon geregistreerd' gebeurtenis voor 'Jan'

  Regel: Een 'abonnement geregistreerd' gebeurtenis voor een persoon bevat de persoonId uit de 'persoon geregistreerd' gebeurtenis van de betreffende persoon

    Scenario: Een abonnee abonneert zich op een persoon voor wie er al gebeurtenissen zijn gepubliceerd
      Gegeven de persoon 'Jan' is geregistreerd in de BRP
      En er is een 'verhuisd intergemeentelijk' gebeurtenis gepubliceerd voor 'Jan'
      Als een abonnee zich abonneert op de persoon 'Jan' voor de groep 'client'
      Dan is de persoonId in de 'abonnement geregistreerd' gebeurtenis voor de groep 'client' gelijk aan de persoonId in de 'persoon geregistreerd' gebeurtenis voor 'Jan'

    Scenario: Een abonnee abonneert zich op een persoon voor een tweede groep
      Gegeven de persoon 'Jan' is geregistreerd in de BRP
      En er zijn nog geen gebeurtenissen gepubliceerd voor 'Jan'
      En een abonnee heeft zich geabonneerd op de persoon 'Jan' voor de groep 'client'
      Als een abonnee zich abonneert op de persoon 'Jan' voor de groep 'gerelateerde'
      Dan is alleen een 'abonnement geregistreerd' gebeurtenis voor de groep 'gerelateerde' en persoon 'Jan' gepubliceerd
      En is de persoonId in de 'abonnement geregistreerd' gebeurtenis voor de groep 'gerelateerde' gelijk aan de persoonId in de 'persoon geregistreerd' gebeurtenis voor 'Jan'
