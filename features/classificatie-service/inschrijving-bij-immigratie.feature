# language: nl
Functionaliteit: gepubliceerde gebeurtenis bij een eerste inschrijving bij vestiging vanuit het buitenland in Nederland
  De persoon vestigt zich vanuit het buitenland in een Nederlandse gemeente. Hij is nooit in de BRP ingeschreven (dus
  ook niet in de RNI).

  Deze gebeurtenis is ook van toepassing als de persoon zich vestigt vanuit het Caribisch deel van het Koninkrijk,
  vanuit de PIVA.

  Deze gebeurtenis is ook van toepassing op een kind dat 'toevallig' in het buitenland is geboren maar woont in Nederland. 
  De moeder (uit wie het kind is geboren) of beide ouders zijn als ingezetene ingeschreven in de BRP.

  Scenario: vestiging van een persoon in een Nederlandse gemeente vanuit het buitenland
    Als de eerste inschrijving bij vestiging vanuit het buitenland van 'Jan' is verwerkt
    * is op '1-9-2025' geïmmigreerd uit Duitsland
    * verblijft vanaf '1-9-2025' op een adres in 'Utrecht'
    Dan is een 'ingeschreven.immigratie' gebeurtenis gepubliceerd
    * bevat de 'data' de pl_id van 'Jan'
