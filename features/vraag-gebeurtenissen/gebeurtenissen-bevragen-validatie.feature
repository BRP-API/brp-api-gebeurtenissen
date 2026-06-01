# language: nl
Functionaliteit: Gebeurtenissen bevragen waar de abonnee op geabonneerd is
  Als consumer van BRP Gebeurtenissen
  wil ik bij het bevragen van gebeurtenissen kunnen opgeven welke gebeurtenissen ik wil ontvangen
  zodat ik asynchroon de gebeurtenissen waarop ik ben geabonneerd kan verwerken

  Achtergrond:
    Gegeven de persoon 'Jan' is geregistreerd in de BRP
    En de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
    En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client'

  Regel: Alleen een abonnee mag gebeurtenissen bevragen

    Scenario: Afnemer vraagt gebeurtenissen en vult bij abonnee een naam die nog niet bekend is als abonnee
      Als gebeurtenissen worden gevraagd met een abonneenaam die niet geregistreerd is
      Dan is de response '404 Not found'

    Scenario: Afnemer vraagt gebeurtenissen en vult een abonnee die gederegistreerd is
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' gederegistreerd
      Als gebeurtenissen worden gevraagd door abonnee 'jz' van afnemer 'Gemeente Amsterdam'
      Dan is de response '404 Not found'

  Regel: Parameter 'cursor' moet een geldige uuid zijn

    Scenario: De abonnee vraagt gebeurtenissen met een cursor die geen uuid is
      Als gebeurtenissen worden gevraagd door abonnee 'jz' vanaf gebeurtenis '47bf7642'
      Dan is de response '400 Bad Request' met de volgende velden
      * 'detail' met tekst 'De foutieve parameter(s) zijn: cursor.'
      En heeft de response invalidParams met de volgende gegevens
        | code | name   | reason               |
        | uuid | cursor | Waarde is geen uuid. |

  Regel: Parameter 'cursor' moet een id zijn van een gebeurtenis waar de abonnee een abonnement op heeft

    Scenario: De opgegeven cursor is geen id van een gebeurtenis
      Als gebeurtenissen worden gevraagd door abonnee 'jz' vanaf gebeurtenis 'ad095c09-6c0e-4800-94ac-adf05b5ea4a4'
      Dan is de response '400 Bad Request' met de volgende velden
      * 'detail' met tekst 'De foutieve parameter(s) zijn: cursor.'
      En heeft de response invalidParams met de volgende gegevens
        | code    | name   | reason                                  |
        | unknown | cursor | Cursor is geen correcte gebeurtenis id. |

    Scenario: De opgegeven cursor is de id van een gebeurtenis waar de abonnee niet op geabonneerd is
      Gegeven er is een 'nl.brp.verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor persoon 'Jan'
      Als gebeurtenissen worden gevraagd door abonnee 'jz' vanaf de gebeurtenis voor 'Jan'
      Dan is de response '400 Bad Request' met de volgende velden
      * 'detail' met tekst 'De foutieve parameter(s) zijn: cursor.'
      En heeft de response invalidParams met de volgende gegevens
        | code    | name   | reason                                  |
        | unknown | cursor | Cursor is geen correcte gebeurtenis id. |

  Regel: Parameter 'limit' moet een getal zijn tussen 1 en 10

    Abstract Scenario: De opgegeven 'limit' <omschrijving>
      Als abonnee 'jz' van afnemer 'Gemeente Amsterdam' maximaal <waarde> gebeurtenissen vraagt
      Dan is de response '400 Bad Request' met de volgende velden
      * 'detail' met tekst 'De foutieve parameter(s) zijn: limit.'
      En heeft de response invalidParams met de volgende gegevens
        | code   | name   | reason   |
        | <code> | cursor | <reason> |

      Voorbeelden:
        | omschrijving    | waarde | code    | reason                          |
        | is 0            |      0 | minimum | Waarde is lager dan minimum 1.  |
        | is negatief     |     -3 | minimum | Waarde is lager dan minimum 1.  |
        | is hoger dan 10 |     11 | maximum | Waarde is hoger dan maximum 10. |
