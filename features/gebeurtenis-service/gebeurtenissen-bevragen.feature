# language: nl
Functionaliteit: Gebeurtenissen bevragen waar de abonnee op geabonneerd is
  Als consumer van BRP Gebeurtenissen
  wil ik ongelezen gebeurtenissen chronologisch kunnen bevragen
  zodat ik asynchroon de gebeurtenissen waarop ik ben geabonneerd kan verwerken

  Regel: Als er voor de abonnee geen gebeurtenissen zijn, krijgt hij geen gebeurtenissen

    Scenario: Er is nog geen gebeurtenis voor de abonnee
      Gegeven abonnee 'szw' heeft zich geabonneerd op gebeurtenistype 'verhuisd.intergemeentelijk' van persoon 'Piet'
      Als gebeurtenissen worden gevraagd door abonnee 'szw'
      Dan wordt er geen gebeurtenis geleverd

  Regel: Een abonnee ontvangt alleen gebeurtenissen waar deze op geabonneerd is

    Scenario: De abonnee is geabonneerd op de gebeurtenis
      Gegeven abonnee 'szw' heeft zich geabonneerd op gebeurtenistype 'verhuisd.intergemeentelijk' van persoon 'Piet'
      En er is een 'verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor persoon 'Piet'
      Als gebeurtenissen worden gevraagd door abonnee 'szw'
      Dan wordt de 'verhuisd.intergemeentelijk' gebeurtenis van 'Piet' geleverd

    Scenario: De abonnee is niet geabonneerd op de gebeurtenis
      Gegeven er is een 'verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor persoon 'Piet'
      Als gebeurtenissen worden gevraagd door abonnee 'szw'
      Dan wordt er geen gebeurtenis geleverd

  Regel: Meerdere abonnees kunnen dezelfde gebeurtenis ontvangen

    Scenario: De abonnee vraagt ongelezen gebeurtenissen en een andere abonnee heeft ook een abonnement op dezelfde gebeurtenis
      Gegeven abonnee 'szw' heeft zich geabonneerd op gebeurtenistype 'verhuisd.intergemeentelijk' van persoon 'Piet'
      En abonnee 'jz' heeft zich geabonneerd op gebeurtenistype 'verhuisd.intergemeentelijk' van persoon 'Piet'
      En er is een 'verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor persoon 'Piet'
      Als gebeurtenissen worden gevraagd door abonnee 'szw'
      Dan wordt de 'verhuisd.intergemeentelijk' gebeurtenis van 'Piet' geleverd

    Scenario: De abonnee vraagt ongelezen gebeurtenissen en een andere abonnee heeft dezelfde gebeurtenis al ontvangen
      Gegeven abonnee 'szw' heeft zich geabonneerd op gebeurtenistype 'verhuisd.intergemeentelijk' van persoon 'Piet'
      En abonnee 'jz' heeft zich geabonneerd op gebeurtenistype 'verhuisd.intergemeentelijk' van persoon 'Piet'
      En er is een 'verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor persoon 'Piet'
      En gebeurtenissen zijn gevraagd door abonnee 'szw'
      Als gebeurtenissen worden gevraagd door abonnee 'jz'
      Dan wordt de 'verhuisd.intergemeentelijk' gebeurtenis van 'Piet' geleverd

  Regel: Een abonnee ontvangt alleen gebeurtenissen die hebben plaatsgevonden na het plaatsen van het abonnement daarop

    Scenario: De gebeurtenis heeft plaatsgevonden vóór het abonnement werd gezet
      Gegeven er is een 'verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor persoon 'Piet'
      En abonnee 'szw' abonneert zich op gebeurtenistype 'verhuisd.intergemeentelijk' van persoon 'Piet'
      Als gebeurtenissen worden gevraagd door abonnee 'szw'
      Dan wordt er geen gebeurtenis geleverd

  Regel: Een abonnee ontvangt gebeurtenissen op volgorde dat ze gepubliceerd zijn

    Scenario: Er zijn meerdere gebeurtenissen
      Gegeven abonnee 'szw' heeft zich geabonneerd op gebeurtenistype 'verhuisd.intergemeentelijk' van persoon 'Piet'
      En abonnee 'szw' heeft zich geabonneerd op gebeurtenistype 'verhuisd.intergemeentelijk' van persoon 'Jan'
      En er is een 'verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor persoon 'Piet'
      En er is een 'verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor persoon 'Jan'
      Als gebeurtenissen worden gevraagd door abonnee 'szw'
      Dan worden gebeurtenissen geleverd in de volgende volgorde:
      * de 'verhuisd.intergemeentelijk' gebeurtenis van 'Piet'
      * de 'verhuisd.intergemeentelijk' gebeurtenis van 'Jan'

  Regel: Een abonnee kan gebeurtenissen vragen vanaf de id van een eerder ontvangen gebeurtenis
    Hiervoor gebruikt de abonnee optionele parameter 'cursor'

    Scenario: De abonnee vraagt gebeurtenissen na de opgegeven gebeurtenis id
      Gegeven abonnee 'szw' heeft zich geabonneerd op gebeurtenistype 'verhuisd.intergemeentelijk' van persoon 'Piet'
      En abonnee 'szw' heeft zich geabonneerd op gebeurtenistype 'verhuisd.intergemeentelijk' van persoon 'Jan'
      En abonnee 'szw' heeft zich geabonneerd op gebeurtenistype 'verhuisd.intergemeentelijk' van persoon 'Karin'
      En er is een 'verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor persoon 'Piet' met id '47bf7642-12f9-425c-ba05-4295ed4ac915'
      En er is een 'verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor persoon 'Jan' met id 'c193c7af-1d17-484e-a640-ad7fa2c1f769'
      En er is een 'verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor persoon 'Karin' met id '9687756c-12f9-40d8-8703-f7a560cf6f81'
      Als gebeurtenissen worden gevraagd door abonnee 'szw' vanaf gebeurtenis '47bf7642-12f9-425c-ba05-4295ed4ac915'
      Dan worden volgende gebeurtenissen geleverd:
      * de 'verhuisd.intergemeentelijk' gebeurtenis van 'Jan'
      * de 'verhuisd.intergemeentelijk' gebeurtenis van 'Karin'

    Scenario: De abonnee vraagt gebeurtenissen na de laatste gebeurtenis op
      Gegeven abonnee 'szw' heeft zich geabonneerd op gebeurtenistype 'verhuisd.intergemeentelijk' van persoon 'Piet'
      En abonnee 'szw' heeft zich geabonneerd op gebeurtenistype 'verhuisd.intergemeentelijk' van persoon 'Jan'
      En abonnee 'szw' heeft zich geabonneerd op gebeurtenistype 'verhuisd.intergemeentelijk' van persoon 'Karin'
      En er is een 'verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor persoon 'Piet' met id '47bf7642-12f9-425c-ba05-4295ed4ac915'
      En er is een 'verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor persoon 'Jan' met id 'c193c7af-1d17-484e-a640-ad7fa2c1f769'
      En er is een 'verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor persoon 'Karin' met id '9687756c-12f9-40d8-8703-f7a560cf6f81'
      Als gebeurtenissen worden gevraagd door abonnee 'szw' vanaf gebeurtenis '9687756c-12f9-40d8-8703-f7a560cf6f81'
      Dan wordt er geen gebeurtenis geleverd

  Regel: Parameter 'cursor' moet een geldige uuid zijn

    Scenario: De abonnee vraagt gebeurtenissen met een cursor die geen uuid is
      Als gebeurtenissen worden gevraagd door abonnee 'szw' vanaf gebeurtenis '47bf7642'
      Dan is de response '400 Bad Request' met de volgende velden
      * 'detail' met tekst 'De foutieve parameter(s) zijn: cursor.'
      En heeft de response invalidParams met de volgende gegevens
        | code | name   | reason               |
        | uuid | cursor | Waarde is geen uuid. |

  Regel: Parameter 'cursor' moet een id zijn van een gebeurtenis waar de abonnee een abonnement op heeft

    Scenario: De opgegeven cursor is geen id van een gebeurtenis
      Als gebeurtenissen worden gevraagd door abonnee 'szw' vanaf gebeurtenis 'ad095c09-6c0e-4800-94ac-adf05b5ea4a4'
      Dan is de response '400 Bad Request' met de volgende velden
      * 'detail' met tekst 'De foutieve parameter(s) zijn: cursor.'
      En heeft de response invalidParams met de volgende gegevens
        | code    | name   | reason                                  |
        | unknown | cursor | Cursor is geen correcte gebeurtenis id. |

    Scenario: De opgegeven cursor is de id van een gebeurtenis waar de abonnee niet op geabonneerd is
      Gegeven er is een 'verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor persoon 'Piet' met id 'ad095c09-6c0e-4800-94ac-adf05b5ea4a4'
      Als gebeurtenissen worden gevraagd door abonnee 'szw' vanaf gebeurtenis 'ad095c09-6c0e-4800-94ac-adf05b5ea4a4'
      Dan is de response '400 Bad Request' met de volgende velden
      * 'detail' met tekst 'De foutieve parameter(s) zijn: cursor.'
      En heeft de response invalidParams met de volgende gegevens
        | code    | name   | reason                                  |
        | unknown | cursor | Cursor is geen correcte gebeurtenis id. |

  Regel: Standaard worden per request maximaal 10 gebeurtenissen geleverd

    Scenario: Er zijn meer dan 10 gebeurtenissen gepubliceerd
      Gegeven er zijn 11 gebeurtenissen gepubliceerd waar abonnee 'szw' op geabonneerd is
      Als gebeurtenissen worden gevraagd door abonnee 'szw'
      Dan worden 10 gebeurtenissen geleverd

  Regel: Een abonnee kan het maximaal aantal te ontvangen gebeurtenissen opgeven
    Hiervoor gebruikt de abonnee optionele parameter 'limiet'

    Scenario: De abonnee wil 5 gebeurtenissen per keer ontvangen
      Gegeven er zijn 11 gebeurtenissen gepubliceerd waar abonnee 'szw' op geabonneerd is
      Als maximaal 5 gebeurtenissen worden gevraagd door abonnee 'szw'
      Dan worden 5 gebeurtenissen geleverd

    Scenario: De abonnee wil alleen de eerstvolgende gebeurtenis ontvangen
      Gegeven er zijn 11 gebeurtenissen gepubliceerd waar abonnee 'szw' op geabonneerd is
      Als maximaal 1 gebeurtenis worden gevraagd door abonnee 'szw'
      Dan wordt 1 gebeurtenis geleverd

  Regel: Parameter 'limiet' moet een getal zijn tussen 1 en 10

    Abstract Scenario: De opgegeven 'limiet' <omschrijving>
      Als maximaal <waarde> gebeurtenissen worden gevraagd door abonnee 'szw'
      Dan is de response '400 Bad Request' met de volgende velden
      * 'detail' met tekst 'De foutieve parameter(s) zijn: cursor.'
      En heeft de response invalidParams met de volgende gegevens
        | code   | name   | reason   |
        | <code> | cursor | <reason> |

      Voorbeelden:
        | omschrijving    | waarde | code    | reason                          |
        | is geen getal   | alle   | integer | Waarde is geen geldig getal.    |
        | is 0            |      0 | minimum | Waarde is lager dan minimum 1.  |
        | is negatief     |     -3 | minimum | Waarde is lager dan minimum 1.  |
        | is hoger dan 10 |     11 | maximum | Waarde is hoger dan maximum 10. |

  Regel: Alleen een abonnee mag gebeurtenissen bevragen

    Scenario: Afnemer vraagt gebeurtenissen en vult bij abonnee een naam die nog niet bekend is als abonnee
      Als gebeurtenissen worden gevraagd met een abonneenaam die niet geregistreerd is
      Dan is de response '404 Not found'
