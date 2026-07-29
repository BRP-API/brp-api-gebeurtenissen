# language: nl
Functionaliteit: Vraag abonnementen wanneer een of de identificatienummer(s) van de persoon gewijzigd is/zijn

  Achtergrond:
    Gegeven de persoon 'Jan' is geregistreerd in de BRP
    * met 'burgerservicenummer' is '000000012'
    * met 'A-nummer' is '9000000001'
    En de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
    En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
    En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'client'

  Regel: Na een burgerservicenummerwijziging behouden de abonnees hun abonnement op deze persoon
    Ze hebben dan nog het abonnement op het oude burgerservicenummer, zodat ze gebeurtenissen die vóór de burgerservicenummerwijziging plaatsgevonden nog kunnen ontvangen.
    En ze hebben dan een abonnement op het nieuwe burgerservicenummer, zodat ze gebeurtenissen die ná de burgerservicenummerwijziging plaatsvonden kunnen ontvangen.

    Scenario: Het burgerservicenummer van de persoon is gewijzigd, omdat er meerdere personen met hetzelfde burgerservicenummer waren
      Gegeven de persoon 'Piet' is geregistreerd in de BRP
      * met 'burgerservicenummer' is '000000012'
      * met 'A-nummer' is '9000000002'
      En het burgerservicenummer van 'Jan' is gewijzigd van '000000012' naar '000000024'
      En het burgerservicenummer van 'Piet' is gewijzigd van '000000012' naar '000000036'
      Als abonnee 'jz' van afnemer 'Gemeente Amsterdam' de abonnementen opvraagt
      Dan worden volgende abonnementen geleverd
        | burgerservicenummer | groep  | vorigBurgerservicenummer |
        |           000000024 | client |                000000012 |

    Scenario: Dubbelinschrijving met verschillende A-nummers en verschillende burgerservicenummers is opgelost en er was een abonnement op de overbodig geworden persoonslijst
      Gegeven de persoon 'tweede persoonslijst van Jan' is geregistreerd in de BRP
      * met 'burgerservicenummer' is '000000024'
      * met 'A-nummer' is '9000000002'
      En de dubbelinschrijving met verschillende A-nummers is opgelost met 'Jan' als overbodige persoonslijst
      * met 'Volgend A-nummer' is gevuld met '9000000002'
      Als abonnee 'jz' van afnemer 'Gemeente Amsterdam' de abonnementen opvraagt
      Dan worden volgende abonnementen geleverd
        | burgerservicenummer | groep  | vorigBurgerservicenummer |
        |           000000024 | client |                000000012 |

    Scenario: Dubbelinschrijving met hetzelfde A-nummer en verschillende burgerservicenummers is opgelost en er was een abonnement op de overbodig geworden persoonslijst
      Gegeven de persoon 'tweede persoonslijst van Jan' is geregistreerd in de BRP
      * met 'burgerservicenummer' is '000000024'
      * met 'A-nummer' is '9000000001'
      En de dubbelinschrijving met hetzelfde A-nummer is opgelost met 'Jan' als overbodige persoonslijst
      * met 'Reden opschorting bijhouding' is gevuld met 'F'
      Als abonnee 'jz' van afnemer 'Gemeente Amsterdam' de abonnementen opvraagt
      Dan worden volgende abonnementen geleverd
        | burgerservicenummer | groep  | vorigBurgerservicenummer |
        |           000000024 | client |                000000012 |

  Regel: Na een A-nummerwijziging behouden de abonnees hun abonnement op deze persoon

    Scenario: Het A-nummer van een persoon is gewijzigd, omdat twee verschillende personen hetzelfde A-nummer hadden
      Gegeven de persoon 'Piet' is geregistreerd in de BRP
      * met 'burgerservicenummer' is '000000024'
      * met 'A-nummer' is '9000000001'
      En het A-nummer van 'Jan' is gewijzigd van '9000000001' naar '9000000002'
      * met 'Vorig A-nummer' is gevuld met '9000000001'
      En het A-nummer van 'Piet' is gewijzigd van '9000000001' naar '9000000003'
      * met 'Vorig A-nummer' is gevuld met '9000000001'
      Als abonnee 'jz' van afnemer 'Gemeente Amsterdam' de abonnementen opvraagt
      Dan worden volgende abonnementen geleverd
        | burgerservicenummer | groep  |
        |           000000012 | client |

    Scenario: Dubbelinschrijving met verschillende A-nummers en hetzelfde burgerservicenummer is opgelost en er was een abonnement op de overbodig geworden persoonslijst
      Gegeven de persoon 'tweede persoonslijst van Jan' is geregistreerd in de BRP
      * met 'burgerservicenummer' is '000000012'
      * met 'A-nummer' is '9000000002'
      En de dubbelinschrijving met verschillende A-nummers is opgelost met 'Jan' als overbodige persoonslijst
      * met 'Volgend A-nummer' is gevuld met '9000000002'
      Als abonnee 'jz' van afnemer 'Gemeente Amsterdam' de abonnementen opvraagt
      Dan worden volgende abonnementen geleverd
        | burgerservicenummer | groep  |
        |           000000012 | client |

  Regel: Na een burgerservicenummerwijziging kan het abonnement alleen worden beëindigd met het nieuwe burgerservicenummer

    Scenario: Het burgerservicenummer van de persoon is gewijzigd en daarna beëindigt de abonnee het abonnement met het nieuwe burgerservicenummer
      Gegeven het burgerservicenummer van 'Jan' is gewijzigd van '000000012' naar '000000024'
      Als de abonnee 'jz' van afnemer 'Gemeente Amsterdam' zijn abonnement op de persoon met burgerservicenummer '000000024' voor de groep 'client' opzegt
      Dan is de response '204 No Content'

    Scenario: Het burgerservicenummer van de persoon is gewijzigd en daarna wil de abonnee het abonnement beëindigen met het oude burgerservicenummer
      Gegeven het burgerservicenummer van 'Jan' is gewijzigd van '000000012' naar '000000024'
      Als de abonnee 'jz' van afnemer 'Gemeente Amsterdam' zijn abonnement op de persoon met burgerservicenummer '000000012' voor de groep 'client' opzegt
      Dan is de response '409 Conflict' met de volgende velden
      * 'title' met tekst 'Abonnement bestaat niet'

    Scenario: Het burgerservicenummer van de persoon is gewijzigd en na het beëindigen van het abonnement vraagt de abonnee de abonnementen op
      Gegeven het burgerservicenummer van 'Jan' is gewijzigd van '000000012' naar '000000024'
      Als de abonnee 'jz' van afnemer 'Gemeente Amsterdam' zijn abonnement op de persoon met burgerservicenummer '000000024' voor de groep 'client' opzegt
      En abonnee 'jz' van afnemer 'Gemeente Amsterdam' de abonnementen opvraagt
      Dan wordt er geen abonnement geleverd
