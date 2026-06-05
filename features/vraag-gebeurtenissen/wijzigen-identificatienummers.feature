# language: nl
Functionaliteit: Vraag gebeurtenissen wanneer een of de identificatienummer(s) van de persoon gewijzigd is/zijn

  Achtergrond:
    Gegeven de persoon 'Jan' is geregistreerd in de BRP
    En de persoon 'Piet' is geregistreerd in de BRPÌ
    En de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
    En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de groep 'client' toegevoegd
    En groep 'client' bij abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft gebeurtenistypes 'nl.brp.verhuisd.intergemeentelijk en nl.brp.verhuisd.naar-buitenland'
    En de abonnee 'jz' van afnemer 'Gemeente Amsterdam' heeft een abonnement op de persoon 'Jan' voor de groep 'client'

  Regel: Als het burgerservicenummer van een persoon gewijzigd is, dan krijgt een abonnee op deze persoon hiervoor een gebeurtenis 'nl.brp.burgerservicenummer.gewijzigd'
    - Aan de groep van deze abonnee hoeft hiervoor gebeurtenistype 'nl.brp.burgerservicenummer.gewijzigd' niet te zijn toegevoegd.
    - Alleen een abonnee die een abonnement heeft voor deze persoon ontvangt dit gebeurtenistype.

    Scenario: De abonnee heeft een abonnement op de persoon en het burgerservicenummer van de persoon wijzigt
      Gegeven het burgerservicenummer van 'Jan' is gewijzigd
      Als gebeurtenissen worden gevraagd door abonnee 'jz' van afnemer 'Gemeente Amsterdam'
      Dan wordt de 'nl.brp.burgerservicenummer.gewijzigd' gebeurtenis van 'Jan' geleverd

    Scenario: De abonnee heeft geen abonnement op de persoon en het burgerservicenummer van de persoon wijzigt
      Gegeven het burgerservicenummer van 'Piet' is gewijzigd
      Als gebeurtenissen worden gevraagd door abonnee 'jz' van afnemer 'Gemeente Amsterdam'
      Dan wordt er geen gebeurtenis geleverd

  Regel: Na een burgerservicenummerwijziging behouden de abonnees hun abonnement op deze persoon
    Ze kunnen dan nog gebeurtenissen ontvangen van voor de burgerservicenummerwijziging, met daarin het oude burgerservicenummer.
    En ze kunnen gebeurtenissen ontvangen van na de burgerservicenummerwijziging, met daarin het nieuwe burgerservicenummer.

    Scenario: Er zijn gebeurtenissen voor en na het wijzigen van het abonnement
      Gegeven er is een 'nl.brp.verhuisd.intergemeentelijk' gebeurtenis gepubliceerd voor persoon 'Jan'
      En het burgerservicenummer van 'Jan' is gewijzigd
      En er is een 'nl.brp.verhuisd.naar-buitenland' gebeurtenis gepubliceerd voor persoon 'Jan'
      Als gebeurtenissen worden gevraagd door abonnee 'jz' van afnemer 'Gemeente Amsterdam'
      Dan worden de volgende gebeurtenissen geleverd
        | gebeurtenistype                      | burgerservicenummer                    |
        | nl.brp.verhuisd.intergemeentelijk    | het oude burgerservicenummer van Jan   |
        | nl.brp.burgerservicenummer.gewijzigd | het oude burgerservicenummer van Jan   |
        | nl.brp.verhuisd.naar-buitenland      | het nieuwe burgerservicenummer van Jan |
