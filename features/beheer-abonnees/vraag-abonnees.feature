# language: nl
Functionaliteit: Vraag welke abonnees geregistreerd zijn voor een afnemer
  Als afnemer van BRP API Gebeurtenissen
  wil ik zien welke binnengemeentelijke taakapplicaties ik als abonnee geregistreerd hebt
  zodat ik mijn abonnees goed kan beheren

  Regel: Een afnemer ontvangt alleen zijn eigen abonnees

    Scenario: De afnemer heeft abonnees geregistreerd en een andere afnemer heeft ook abonnees geregistreerd
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft de abonnee 'szw' geregistreerd
      En de afnemer 'Gemeente Rotterdam' heeft de abonnee 'ocw' geregistreerd
      Als de afnemer 'Gemeente Amsterdam' zijn abonnees raadpleegt
      Dan worden volgende abonnees geleverd
        | naam |
        | jz   |
        | szw  |

  Regel: Een afnemer ontvangt niet de gederegistreerde abonnees

    Scenario: De afnemer heeft abonnees geregistreerd en een abonnee gederegistreerd
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft de abonnee 'szw' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft de abonnee 'ocw' geregistreerd
      En de afnemer 'Gemeente Amsterdam' heeft de abonnee 'szw' gederegistreerd
      Als de afnemer 'Gemeente Amsterdam' zijn abonnees raadpleegt
      Dan worden volgende abonnees geleverd
        | naam |
        | jz   |
        | ocw  |

  Regel: Alleen gemeenten zijn geautoriseerd voor het beheren van abonnees

    Scenario: Een gemeente als afnemer mag abonnees vragen
      Gegeven de geauthenticeerde consumer 'Arnhem' is een gemeente
      En de afnemer 'Arnhem' heeft de abonnee 'jz' geregistreerd
      Als de afnemer 'Arnhem' zijn abonnees raadpleegt
      Dan worden volgende abonnees geleverd
        | naam |
        | jz   |

    Scenario: Een niet-gemeentelijke afnemer mag geen abonnees vragen
      Gegeven de geauthenticeerde consumer 'Niet-gemeente' is geen gemeente
      Als de afnemer 'Arnhem' zijn abonnees raadpleegt
      Dan is de response '403 Unauthorized' met de volgende velden
      * 'title' met tekst 'U bent niet geautoriseerd voor deze vraag'
      * 'detail' met tekst 'Alleen gemeenten mogen de gebeurtenissen API gebruiken.'
      * 'code' met tekst 'unauthorized'
