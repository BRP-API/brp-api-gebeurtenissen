# language: nl
Functionaliteit: gepubliceerde gebeurtenis 'verhuisd.intergemeentelijk' bij een aangifte van adreswijziging naar een andere gemeente

  Scenario: Aangifte van adreswijziging naar een andere gemeente in Nederland
    Gegeven de persoon 'Jan'
    * verblijft vanaf '14-4-2020' op een adres in 'Amsterdam'
    Als de opgave van verhuizing van 'Jan' is verwerkt
    * verblijft vanaf '1-9-2025' op een adres in 'Utrecht'
    Dan is een 'verhuisd.intergemeentelijk' gebeurtenis het laatst gepubliceerd
    * bevat de 'data' in categorie 'persoon' element in groep 'identificatienummers' het element 'A-nummer (01.10)' van 'Jan'
    * bevat de 'data' in categorie 'verblijfplaats' in groep 'adreshouding' element 'datum aanvang adreshouding (10.30)' met waarde '20250901'
    * bevat de 'data' in categorie 'verblijfplaats' in groep 'adres' element 'identificatiecode verblijfplaats (11.80)' van het adres in 'Utrecht'
