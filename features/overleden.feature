# language: nl
Functionaliteit: 'overleden' gebeurtenis
Bij het verwerken van een overlijden heeft een gebeurtenis 'overleden' plaatsgevonden.
(# docs: de discriminerende gegevens per type verwerking overlijden zijn in scenario opgenomen. Voor een overzicht van alle wijzigingen op de Persoon bij een een verwerking van een overlijden wordt verwezen naar https://www.rvig.nl/hup/overlijden)  

  Achtergrond:
    Gegeven de persoon 'Jan'
    * verblijft vanaf '14-4-2020' in de gemeente 'Hengelo'
    En afnemer 'Roosendaal' is geabonneerd op 'overleden' gebeurtenissen van de persoon 'Jan'

  Regel: Wanneer het overlijden van een persoon is verwerkt, dan heeft een gebeurtenis 'overleden' plaatsgevonden.

    Scenario: Verwerking overlijden op basis van een brondocument
      Als het overlijden van 'Jan' is verwerkt
      * op datum <datum overlijden>
      * in plaats <plaats overlijden>
      * in land <land overlijden>
      * door registergemeente <registergemeente>
      * op basis van <beschrijving document>
      * met nummer brondocument <aktenummer>
      * door gemeente ontlening <gemeente ontlening>
      * op datum ontlening <datum ontlening>
      Dan is een 'overleden' gebeurtenis gepubliceerd met de volgende data
      * het A-nummer van 'Jan'
      * de datum dat 'Jan' is overleden

      Voorbeelden:
        | type verwerking                                            | datum overlijden | plaats overlijden | land overlijden | Registergemeente | beschrijving document | aktenummer | gemeente ontlening | datum ontlening |
        | Overlijden in Nederland                                    |         1-9-2025 | Hengelo           | Nederland       | Hengelo          | -                     |    20A0251 | -                  | -               |
        | Overlijden in buitenland met buitenlandse overlijdensakte  |         1-9-2025 | Madrid            | Spanje          | -                | ovlakte 6037          | -          | Hengelo            |        5-9-2025 |
        | Overlijden in buitenland met consolaire overlijdensakte    |         1-9-2025 | Tel Aviv          | Israël          | -                | Cons ovlakte NL 6030  | -          | Hengelo            |        5-9-2025 |
        | Overlijden in buitenland met in Den Haag ingeschreven akte |         1-9-2025 | Douala            | Kameroen        | 's-Gravenhage    | -                     |    2XA0093 | -                  | -               |
        | Overlijden met akte van lijkvinding                        |         1-9-2025 | Hengelo           | Nederland       | Hengelo          | -                     |    20G0085 | -                  | -               |

  Regel: Wanneer voor een persoon een gerechtelijke uitspraak rechtsvermoeden van overlijden is geregistreerd, dan heeft een gebeurtenis 'overleden' plaatsgevonden.

    Scenario: Rechtsvermoeden van overlijden
      Als de de rechterlijke uitspraak rechtsvermoeden van overlijden van 'Jan' is verwerkt
      * op onbekende datum overleden in een onbekende plaats
      Dan is een 'overleden' gebeurtenis gepubliceerd met de volgende data
      * het A-nummer van 'Jan'
      * de datum dat 'Jan' is overleden is 'onbekend'
