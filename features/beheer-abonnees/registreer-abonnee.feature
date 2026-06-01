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
      Als de afnemer 'Gemeente Amsterdam' een abonnee registreert zonder abonneeNaam
      Dan is de response '400 Bad Request'

  Regel: Een geldige abonneenaam voldoet aan de volgende criteria:
  - bevat alleen kleine letters (a-z), cijfers (0-9) en koppeltekens (-)
  - bevat geen dubbele koppeltekens achter elkaar (--)
  - bevat minimaal 2 en maximaal 64 tekens
  - begint en eindigt niet met een koppelteken (-)

    Abstract Scenario: <titel>
      Als de afnemer 'Gemeente Amsterdam' de abonnee '<abonneeNaam>' registreert
      Dan is de response '400 Bad Request' met de volgende velden
      * 'title' met tekst 'Abonneenaam ongeldig'

      Voorbeelden:
        | titel                                              | abonneeNaam                                                       |
        | De abonneenaam is te kort                          | a                                                                 |
        | De abonneenaam is te lang (65 tekens)              | abcdefghijklmnopqrstuvwxyz-abcdefghijklmnopqrstuvwxyz-abcdefghijk |
        | De abonneenaam bevat hoofdletters                  | JZ                                                                |
        | De abonneenaam bevat een koppelteken aan het begin | -jz                                                               |
        | De abonneenaam bevat een koppelteken aan het einde | jz-                                                               |
        | De abonneenaam bevat dubbele koppeltekens          | j--z                                                              |
        | De abonneenaam bevat een ongeldig teken            | j_z                                                               |
        | De abonneenaam is leeg                             |                                                                   |
        | De abonneenaam bevat ongeldige tekens              | <script>alert("hello world");</script>                            |

  Regel: De abonneenaam is uniek binnen de context van een afnemer

    Scenario: De abonneeNaam bestaat al bij de afnemer
      Gegeven de afnemer 'Gemeente Amsterdam' heeft de abonnee 'jz' geregistreerd
      # Deze Gegeven stap is nog niet geïmplementeerd
      Als de afnemer 'Gemeente Amsterdam' de abonnee 'jz' registreert
      Dan is de response '400 BadRequest' met de volgende velden
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
