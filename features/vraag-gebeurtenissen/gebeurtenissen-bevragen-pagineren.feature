# language: nl
Functionaliteit: Gebeurtenissen bevragen met cursor en limit
  Als consumer van BRP Gebeurtenissen
  wil ik bij het bevragen van gebeurtenissen kunnen opgeven welke gebeurtenissen ik wil ontvangen
  zodat ik asynchroon de gebeurtenissen waarop ik ben geabonneerd kan verwerken

  - Hiermee kan de abonnee gebeurtenissen vragen na de laatste gelezen/verwerkte gebeurtenis.
  - Hiermee kan de abonnee via paginering gebeurtenissen opvragen wanneer dat meer dan het maximaal aantal is.
  - Hiermee kan de abonnee eerder gelezen gebeurtenissen nogmaals ontvangen vanaf een bepaald punt (de laatste wel goed verwerkte gebeurtenis).

  Achtergrond:
    Gegeven de persoon 'Jan' is geregistreerd in de BRP
    En de persoon 'Piet' is geregistreerd in de BRP
    En de persoon 'Karin' is geregistreerd in de BRP
    En de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
    En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client'
    En groep 'client' bij abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk'
    En abonnee 'jz' heeft zich geabonneerd op gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk' van persoon 'Jan'
    En abonnee 'jz' heeft zich geabonneerd op gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk' van persoon 'Piet'
    En abonnee 'jz' heeft zich geabonneerd op gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk' van persoon 'Karin'
    En er is een 'nl.brp.verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor persoon 'Jan'
    En er is een 'nl.brp.verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor persoon 'Piet'
    En er is een 'nl.brp.verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor persoon 'Karin'

  Regel: Een abonnee kan gebeurtenissen vragen na de id van een eerder ontvangen gebeurtenis
    Hiervoor gebruikt de abonnee optionele parameter 'cursor'

    Scenario: De abonnee vraagt gebeurtenissen na de opgegeven gebeurtenis id
      Als gebeurtenissen worden gevraagd door abonnee 'jz' na de gebeurtenis voor 'Jan'
      Dan worden volgende gebeurtenissen geleverd:
      * de 'nl.brp.verhuisd.intergemeentelijk' gebeurtenis van 'Piet'
      * de 'nl.brp.verhuisd.intergemeentelijk' gebeurtenis van 'Karin'

    Scenario: De abonnee vraagt gebeurtenissen na de laatste gebeurtenis op
      Als gebeurtenissen worden gevraagd door abonnee 'jz' na de gebeurtenis voor 'Karin'
      Dan wordt er geen gebeurtenis geleverd

  Regel: Standaard worden per request maximaal 10 gebeurtenissen geleverd

    Scenario: Er zijn meer dan 10 gebeurtenissen gepubliceerd
      Gegeven er zijn 11 gebeurtenissen gepubliceerd waar abonnee 'jz' op geabonneerd is
      Als gebeurtenissen worden gevraagd door abonnee 'jz'
      Dan worden 10 gebeurtenissen geleverd

  Regel: Een abonnee kan het maximaal aantal te ontvangen gebeurtenissen opgeven
    Hiervoor gebruikt de abonnee optionele parameter 'limit'

    Scenario: De abonnee wil 2 gebeurtenissen per keer ontvangen
      Als maximaal 2 gebeurtenissen worden gevraagd door abonnee 'jz'
      Dan worden volgende gebeurtenissen geleverd:
      * de 'nl.brp.verhuisd.intergemeentelijk' gebeurtenis van 'Jan'
      * de 'nl.brp.verhuisd.intergemeentelijk' gebeurtenis van 'Piet'

    Scenario: De abonnee wil alleen de eerstvolgende gebeurtenis ontvangen
      Als maximaal 1 gebeurtenis wordt gevraagd door abonnee 'jz'
      Dan worden volgende gebeurtenissen geleverd:
      * de 'nl.brp.verhuisd.intergemeentelijk' gebeurtenis van 'Jan'

  Regel: Een abonnee mag parameters 'cursor' en 'limit' samen gebruiken

    Scenario: De abonnee wil 1 gebeurtenis ontvangen na de opgegeven id
      Als maximaal 1 gebeurtenis wordt gevraagd door abonnee 'jz' na de gebeurtenis voor 'Jan'
      Dan worden volgende gebeurtenissen geleverd:
      * de 'nl.brp.verhuisd.intergemeentelijk' gebeurtenis van 'Piet'
