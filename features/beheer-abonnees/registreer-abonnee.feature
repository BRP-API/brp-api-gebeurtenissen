# language: nl
Functionaliteit: Registreer een abonnee
  Als afnemer van BRP API Gebeurtenissen
  wil ik binnengemeentelijke taakapplicaties kunnen registreren als abonnee
  zodat de taakapplicatie zelfstandig abonnementen kan beheren en gebeurtenissen op de eigen abonnementen kan opvragen

  Regel: Een afnemer kan een abonnee registreren

    Scenario: Een afnemer registreert een abonnee met een geldige abonneenaam
      Als de afnemer 'Gemeente Amsterdam' de abonnee 'jz' registreert
      Dan is de response '201 Created'

  Regel: Een 'AbonneeGeregistreerd' gebeurtenis wordt gepubliceerd wanneer een abonnee succesvol is geregistreerd

    @skip-verify
    Scenario: Een afnemer registreert een abonnee met een geldige abonneenaam
      Als de afnemer 'Gemeente Amsterdam' de abonnee 'jz' registreert
      Dan is een 'AbonneeGeregistreerd' gebeurtenis gepubliceerd met de volgende velden
        | afnemerId          | abonneeNaam |
        | Gemeente Amsterdam | jz          |
      # Deze Dan stap kan niet worden ge-automate. Met de API van Axon Server kan geen gebeurtenissen worden bevraagd die zijn gepubliceerd conform Dynamic Boundary Context

  Regel: Opgeven van een abonneeNaam is verplicht

    Scenario: Afnemer probeert een abonnee te registreren zonder een naam op te geven
      Als de afnemer 'Gemeente Amsterdam' een abonnee registreert zonder een naam voor de abonnee op te geven
      Dan is de response '400 Bad Request'

  Regel: Een geldige abonneenaam voldoet aan de volgende criteria:
    - bevat alleen kleine letters (a-z), cijfers (0-9) en koppeltekens (-)
    - bevat geen dubbele koppeltekens achter elkaar (--)
    - bevat minimaal 2 en maximaal 64 tekens
    - begint en eindigt niet met een koppelteken (-)

    Abstract Scenario: De <titel>
      Als de afnemer 'Gemeente Amsterdam' de abonnee '<abonneeNaam>' registreert
      Dan is de response '400 Bad Request' met de volgende velden
      * 'title' met tekst 'Abonneenaam ongeldig'

      Voorbeelden:
        | titel                                           | abonneeNaam                                                       |
        | abonneenaam is te kort                          | a                                                                 |
        | abonneenaam is te lang (65 tekens)              | abcdefghijklmnopqrstuvwxyz-abcdefghijklmnopqrstuvwxyz-abcdefghijk |
        | abonneenaam bevat hoofdletters                  | JZ                                                                |
        | abonneenaam bevat een koppelteken aan het begin | -jz                                                               |
        | abonneenaam bevat een koppelteken aan het einde | jz-                                                               |
        | abonneenaam bevat dubbele koppeltekens          | j--z                                                              |
        | abonneenaam bevat een ongeldig teken            | j_z                                                               |
        | abonneenaam is leeg                             |                                                                   |
        | abonneenaam bevat ongeldige tekens              | <script>alert("hello world");</script>                            |

  Regel: De abonneenaam is uniek binnen de context van een afnemer

    Scenario: De abonneeNaam bestaat al bij de afnemer
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      Als de afnemer 'Gemeente Amsterdam' de abonnee 'jz' registreert
      Dan is de response '409 Conflict' met de volgende velden
      * 'title' met tekst 'Abonnee bestaat al'
      * 'detail' met tekst 'Uw verzoek kan niet worden uitgevoerd omdat u al een abonnee met de opgegeven naam hebt geregistreerd.'

    @skip-verify
    Scenario: De opgegeven abonneenaam is al geregistreerd als abonnee door een andere afnemer
      Gegeven de afnemer 'Gemeente Rotterdam' heeft de abonnee 'jz' geregistreerd
      Als de afnemer 'Gemeente Amsterdam' de abonnee 'jz' registreert
      Dan is een 'AbonneeGeregistreerd' gebeurtenis gepubliceerd met de volgende velden
        | afnemerId          | abonneeNaam |
        | Gemeente Amsterdam | jz          |
      # Deze Dan stap kan niet worden ge-automate. Met de API van Axon Server kan geen gebeurtenissen worden bevraagd die zijn gepubliceerd conform Dynamic Boundary Context

  Regel: Alleen gemeenten zijn geautoriseerd voor het beheren van abonnees

    Scenario: Een gemeente als afnemer mag een abonnee registreren
      Gegeven de geauthenticeerde consumer 'Arnhem' is een gemeente
      Als de afnemer 'Arnhem' de abonnee 'jz' registreert
      Dan is de response '201 Created'

    Scenario: Een niet-gemeentelijke afnemer mag geen abonnee registreren
      Gegeven de geauthenticeerde consumer 'Niet-gemeente' is geen gemeente
      Als de afnemer 'Niet-gemeente' de abonnee 'jz' registreert
      Dan is de response '403 Unauthorized' met de volgende velden
      * 'title' met tekst 'U bent niet geautoriseerd voor deze vraag'
      * 'detail' met tekst 'Alleen gemeenten mogen de gebeurtenissen API gebruiken.'
      * 'code' met tekst 'unauthorized'
