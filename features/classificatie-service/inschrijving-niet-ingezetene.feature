# language: nl
Functionaliteit: gepubliceerde gebeurtenis bij een eerste inschrijving bij vestiging vanuit het buitenland in Nederland
  De persoon schrijft zich in als niet-ingezetene bij een RNI-loket.

  Deze gebeurtenis is ook van toepassing op een persoon die zich inschrijft bij het RNI omdat deze minder dan 4 maanden 
  in Nederland verblijft.

  Scenario: eerste inschrijving van een persoon als niet-ingezetene in het RNI
    Als de eerste inschrijving in het RNI van 'Jan' is verwerkt
    Dan is een 'ingeschreven.niet-ingezetene' gebeurtenis gepubliceerd
    * bevat de 'data' de pl_id van 'Jan'