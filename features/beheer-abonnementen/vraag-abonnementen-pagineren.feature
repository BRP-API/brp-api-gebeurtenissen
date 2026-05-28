# language: nl
Functionaliteit: Abonneer persoon voor een groep
  Als abonnee wil ik kunnen raadplegen welke actieve abonnementen ik heb
  zodat ik mijn abonnementen kan beheren

  Wanneer de abonnee heel veel abonnementen heeft, kan deze door de abonnementen pagineren.

  Ook kan de abonnee het maximum aantal te ontvangen abonnementen opgeven.

  Achtergrond:
    Gegeven de persoon 'Jan' is geregistreerd in de BRP
    En de persoon 'Piet' is geregistreerd in de BRP
    En de persoon 'Karin' is geregistreerd in de BRP
    En de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
    En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client'
    En groep 'client' bij abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft gebeurtenistype 'nl.brp.verhuisd.intergemeentelijk'
    En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'client'
    En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Piet' voor de groep 'client'
    En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Karin' voor de groep 'client'

  Regel: Een abonnee kan abonnementen vragen na de id van een eerder ontvangen abonnement
    Hiervoor gebruikt de abonnee optionele parameter 'cursor'.
    De abonnee vraagt de volgende 'pagina' aan abonnementen door het id uit het laatste abonnement van de laatst ontvangen pagina in parameter cursor te zetten.

    Scenario: De abonnee vraagt abonnementen na de opgegeven gebeurtenis id
      Als abonnee 'jz' van afnemer 'Gemeente Amsterdam' de abonnementen opvraagt na het abonnement op 'Jan' voor de groep 'client'
      Dan worden volgende abonnementen geleverd
        | burgerservicenummer | groepnaam |
        | Piet                | client    |
        | Karin               | client    |

    Scenario: De abonnee vraagt abonnementen na het laatste abonnement op
      Als abonnee 'jz' van afnemer 'Gemeente Amsterdam' de abonnementen opvraagt na het abonnement op 'Karin' voor de groep 'client'
      Dan wordt er geen abonnement geleverd

  Regel: Standaard worden per request maximaal 10 abonnementen geleverd

    @skip-verify
    Scenario: Er zijn meer dan 10 abonnementen
      Gegeven er zijn 11 abonnementen voor abonnee 'jz' van afnemer 'Gemeente Amsterdam'
      Als abonnee 'jz' van afnemer 'Gemeente Amsterdam' de abonnementen opvraagt
      Dan worden 10 abonnementen geleverd
      # nog geen automation voor tellen aantal abonnementen in resultaat

  Regel: Een abonnee kan het maximaal aantal te ontvangen abonnementen opgeven
    Hiervoor gebruikt de abonnee optionele parameter 'limit'

    Scenario: De abonnee wil 2 abonnementen per keer ontvangen
      Als abonnee 'jz' van afnemer 'Gemeente Amsterdam' maximaal 2 abonnementen opvraagt
      Dan worden volgende abonnementen geleverd
        | burgerservicenummer | groepnaam |
        | Jan                 | client    |
        | Piet                | client    |

    Scenario: De abonnee wil alleen de eerstvolgende gebeurtenis ontvangen
      Als abonnee 'jz' van afnemer 'Gemeente Amsterdam' maximaal 1 abonnement opvraagt
      Dan worden volgende abonnementen geleverd
        | burgerservicenummer | groepnaam |
        | Jan                 | client    |

  Regel: Een abonnee mag parameters 'cursor' en 'limit' samen gebruiken

    Scenario: De abonnee wil 1 abonnement ontvangen na de opgegeven id
      Als abonnee 'jz' van afnemer 'Gemeente Amsterdam' maximaal 1 abonnement opvraagt na het abonnement op 'Jan' voor de groep 'client'
      Dan worden volgende abonnementen geleverd
        | burgerservicenummer | groepnaam |
        | Piet                | client    |

  Regel: Parameter 'cursor' moet een geldige uuid zijn

    Scenario: De abonnee vraagt abonnementen met een cursor die geen uuid is
      Als abonnee 'jz' van afnemer 'Gemeente Amsterdam' de abonnementen opvraagt met cursor '47bf7642'
      Dan is de response '400 Bad Request' met de volgende velden
      * 'detail' met tekst 'De foutieve parameter(s) zijn: cursor.'
      En heeft de response invalidParams met de volgende gegevens
        | code | name   | reason               |
        | uuid | cursor | Waarde is geen uuid. |

  Regel: Parameter 'cursor' moet een id zijn van een gebeurtenis waar de abonnee een abonnement op heeft

    Scenario: De opgegeven cursor is geen id van een abonnement
      Als abonnee 'jz' van afnemer 'Gemeente Amsterdam' de abonnementen opvraagt met cursor 'ad095c09-6c0e-4800-94ac-adf05b5ea4a4'
      Dan is de response '400 Bad Request' met de volgende velden
      * 'detail' met tekst 'De foutieve parameter(s) zijn: cursor.'
      En heeft de response invalidParams met de volgende gegevens
        | code    | name   | reason                                 |
        | unknown | cursor | Cursor is geen correcte abonnement id. |

  Regel: Parameter 'limit' moet een getal zijn tussen 1 en 10

    Abstract Scenario: De opgegeven 'limit' <omschrijving>
      Als abonnee 'jz' van afnemer 'Gemeente Amsterdam' maximaal <waarde> abonnementen opvraagt
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
