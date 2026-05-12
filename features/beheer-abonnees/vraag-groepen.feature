# language: nl
Functionaliteit: Vraag welke groepen er zijn bij een abonnee
  Als afnemer van BRP API Gebeurtenissen
  wil ik zien welke groepen er zijn bij een geregistreerde abonnee
  zodat ik de groepen van mijn abonnees goed kan beheren

  Regel: Een afnemer ontvangt de groepen van de opgegeven abonnee

    Scenario: De afnemer heeft groepen in verschillende abonnees
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de 'GebeurtenissenOpPersoon' groep 'minderjarige'
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de 'GebeurtenissenOpPersoon' groep 'ouder'
      En de afnemer 'Gemeente Amsterdam' heeft de abonnee 'szw' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'szw' de 'GebeurtenissenOpPersoon' groep 'client'
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'szw' de 'GebeurtenissenOpPersoon' groep 'relatie'
      Als de afnemer 'Gemeente Amsterdam' de groepen van abonnee 'jz' opvraagt
      Dan worden volgende groepen geleverd
        | groepnaam    |
        | minderjarige |
        | ouder        |

  Regel: Een afnemer ontvangt niet de groepen van een gelijknamige abonnee van een andere afnemer

    Scenario: De afnemer en een andere afnemer hebben een groep met dezelfde abonneenaam
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de 'GebeurtenissenOpPersoon' groep 'minderjarige'
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de 'GebeurtenissenOpPersoon' groep 'ouder'
      En de afnemer 'Gemeente Rotterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Rotterdam' heeft bij de abonnee 'jz' de 'GebeurtenissenOpPersoon' groep 'client'
      En de afnemer 'Gemeente Rotterdam' heeft bij de abonnee 'jz' de 'GebeurtenissenOpPersoon' groep 'relatie'
      Als de afnemer 'Gemeente Amsterdam' de groepen van abonnee 'jz' opvraagt
      Dan worden volgende groepen geleverd
        | groepnaam    |
        | minderjarige |
        | ouder        |

  Regel: Een afnemer kan alleen groepen vragen van een geregistreerde abonnee

    Scenario: De afnemer vraagt groepen van een niet geregistreerde abonnee (en een andere afnemer heeft wel een abonnee met deze naam)
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de 'GebeurtenissenOpPersoon' groep 'client'
      En de afnemer 'Gemeente Rotterdam' heeft de abonnee 'szw' geregistreerd
      Als de afnemer 'Gemeente Amsterdam' de groepen van abonnee 'szw' opvraagt
      Dan is de response '404 Not Found' met de volgende velden
      * 'title' met tekst 'Abonnee bestaat niet'

    Scenario: De afnemer vraagt groepen van een gederegistreerde abonnee
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft bij de abonnee 'jz' de 'GebeurtenissenOpPersoon' groep 'client'
      En de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' gederegistreerd
      Als de afnemer 'Gemeente Amsterdam' de groepen van abonnee 'jz' opvraagt
      Dan is de response '404 Not Found' met de volgende velden
      * 'title' met tekst 'Abonnee bestaat niet'
