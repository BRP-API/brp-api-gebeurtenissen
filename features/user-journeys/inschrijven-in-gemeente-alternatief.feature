# language: nl
Functionaliteit: Inschrijven in gemeente

  Deze feature beschrijft wat een afnemer ziet bij het publiceren van de gebeurtenis 'PersoonIngeschreven'.

  Regel: Inschrijving in de BRP leidt tot de gebeurtenis 'PersoonIngeschreven'

    Scenario: Inschrijving van een persoon
      Gegeven persoon 'Jan' heeft de volgende gegevens
        | burgerservicenummer | geslachtsnaam | voornamen | geboortedatum | geslacht |
        |           000000012 | Janssen       | Jan       |    1980-01-01 | M        |
      Als 'Jan' wordt ingeschreven in de BRP
      Dan wordt de gebeurtenis 'PersoonIngeschreven' gepubliceerd

  Regel: Afnemer ontvangt notificatie over 'PersoonIngeschreven' gebeurtenis

    Scenario: Afnemer is geabonneerd op 'PersoonIngeschreven' gebeurtenissen van 'Jan'
      Gegeven de afnemer is geabonneerd op 'PersoonIngeschreven' gebeurtenissen van 'Jan'
      Als de gebeurtenis 'PersoonIngeschreven' wordt gepubliceerd voor 'Jan'
      Dan ontvangt de afnemer een notificatie over de 'PersoonIngeschreven' gebeurtenis van 'Jan'

  Regel: Afnemer raadpleegt de 'PersoonIngeschreven' gebeurtenis

    Scenario: Afnemer raadpleegt de 'PersoonIngeschreven' gebeurtenis van 'Jan'
      Gegeven de afnemer is geautoriseerd voor het raadplegen van persoonsgegevens
      En de gebeurtenis 'PersoonIngeschreven' is gepubliceerd voor 'Jan'
      Als de afnemer de 'PersoonIngeschreven' gebeurtenis van 'Jan' raadpleegt
      Dan bevat de response de details van de 'PersoonIngeschreven' gebeurtenis van 'Jan'
