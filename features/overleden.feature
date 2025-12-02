# language: nl
Functionaliteit: 'overleden' gebeurtenis

Bij een aangifte van een overlijden in Nederland of overlijden in het buitenland heeft een gebeurtenis 'overleden' plaatsgevonden.

Achtergrond:
    Gegeven de persoon 'Jan'
    * verblijft vanaf '14-4-2020' in de gemeente 'Hengelo'
    En afnemer 'Roosendaal' is geabonneerd op 'overleden' gebeurtenissen van de persoon 'Jan'


Regel: Wanneer voor een persoon een overlijdensakte is geregistreerd, dan heeft een gebeurtenis 'overleden' plaatsgevonden.

Scenario: Overlijden in Nederland
      Als de de overlijdensakte van 'Jan' is verwerkt
      of:
      Als het overlijden van 'Jan' is verwerkt 
      * op '1-9-2025' overleden in de plaats 'Hengelo' in land 'Nederland'
      Dan is een 'overleden' gebeurtenis gepubliceerd met de volgende data
      * het A-nummer van 'Jan'
      * de datum dat 'Jan' is overleden

Scenario: Lijkvinding
     Als de de lijkvindingsakte van 'Jan' is verwerkt
      * op '1-9-2025' overleden in de plaats 'Hengelo' in land 'Nederland'
      Dan is een 'overleden' gebeurtenis gepubliceerd met de volgende data
      * het A-nummer van 'Jan'
      * de datum dat 'Jan' is overleden
      
Scenario: Overlijden in buitenland
      Als de de buitenlandse overlijdensakte of Haagse akte van inschrijving of de consulaire akte of een lager brondocument van 'Jan' is verwerkt
      * op '1-9-2025' overleden in de plaats 'Buenos Aires' in land 'Argentinië'
      Dan is een 'overleden' gebeurtenis gepubliceerd met de volgende data
      * het A-nummer van 'Jan'
      * de datum dat 'Jan' is overleden

Regel: Wanneer voor een persoon een gerechtelijke uitspraak rechtsvermoeden van overlijden is geregistreerd, dan heeft een gebeurtenis 'overleden' plaatsgevonden.

 Scenario: Rechtsvermoeden van overlijden
      Als de de rechterlijke uitspraak rechtsvermoeden van overlijden van 'Jan' is verwerkt
       * op onbekende datum overleden in een onbekende plaats
      Dan is een 'overleden' gebeurtenis gepubliceerd met de volgende data
      * het A-nummer van 'Jan'
      * de datum dat 'Jan' is overleden is 'onbekend'
