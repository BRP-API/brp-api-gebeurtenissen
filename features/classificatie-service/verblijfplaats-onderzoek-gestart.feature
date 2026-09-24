# language: nl
Functionaliteit: Gebeurtenis wanneer er een onderzoek gestart is naar de verblijfplaats

  Achtergrond:
    Gegeven het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    * in gemeente 'Hengelo'
    En het adres 'Beursstraat_44_Hengelo'
    * in gemeente 'Hengelo'
    En het adres 'Stadserf_1_Roosendaal'
    * in gemeente 'Roosendaal'
    En de persoon 'Jan'
    * verblijft vanaf '14-04-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo'
    * verblijft vanaf '14-06-2026' op het adres 'Beursstraat_44_Hengelo'

  Regel: Als een onderzoek gestart is naar de actuele verblijfplaats, heeft de gebeurtenis 'verblijfplaats-onderzoek-gestart' plaatsgevonden
    Dit is alleen het geval wanneer onderzoek start en de aanduiding van het onderzoek betreft gegevens over het verblijf:
    - gemeente
    - adreshouding (o.a. datum aanvang adreshouding en functie adres)
    - adres, locatie of adres buitenland

    Abstract Scenario: Onderzoek naar <betwijfelde gegevens> is gestart
      Als een onderzoek is gestart naar '<betwijfelde gegevens>' van het verblijf op het adres 'Beursstraat_44_Hengelo' van 'Jan'
      Dan is een 'verblijfplaats-onderzoek-gestart' gebeurtenis gepubliceerd

      Voorbeelden:
        | betwijfelde gegevens             |
        | de hele categorie verblijfplaats |
        | de groep adres                   |
        | datum aanvang adreshouding       |
        | functie adres                    |
        | de groep verblijf buitenland     |
        | datum aanvang adres buitenland   |

    Abstract Scenario: Onderzoek naar <betwijfelde gegevens> is gestart
      Als een onderzoek is gestart naar '<betwijfelde gegevens>' van het verblijf op het adres 'Beursstraat_44_Hengelo' van 'Jan'
      Dan is er geen 'verblijfplaats-onderzoek-gestart' gebeurtenis gepubliceerd

      Voorbeelden:
        | betwijfelde gegevens                      |
        | de groep immigratie                       |
        | land vanwaar ingeschreven                 |
        | datum vestiging in Nederland              |
        | de groep adresaangifte                    |
        | omschrijving van de aangifte adreshouding |

    Scenario: Bij de start van het onderzoek is al duidelijk dat de persoon niet verblijft op het adres
      Als is vastgesteld dat 'Jan' niet verblijft op het adres 'Beursstraat_44_Hengelo'
      Dan is een 'verblijfplaats-onderzoek-gestart' gebeurtenis gepubliceerd

    Scenario: Intergemeentelijke verhuizing is doorgevoerd zonder eerst het onderzoek te beëindigen
      Gegeven een onderzoek loopt naar het verblijf op het adres 'Beursstraat_44_Hengelo' van 'Jan'
      Als de aangifte van adreswijziging van 'Jan' is verwerkt
      * verblijft vanaf '1-9-2025' op het adres 'Stadserf_1_Roosendaal'
      En het lopende onderzoek is overgenomen naar de nieuwe verblijfplaats
      Dan is een 'verhuisd.intergemeentelijk' gebeurtenis gepubliceerd
      En is een 'verblijfplaats-onderzoek-gestart' gebeurtenis gepubliceerd

  Regel: Als een onderzoek gestart is naar een historische verblijfplaats, heeft geen 'verblijfplaats-onderzoek-gestart' gebeurtenis plaatsgevonden

    Abstract Scenario: Onderzoek naar <betwijfelde gegevens> van een historische verblijfplaats is gestart
      Als een onderzoek is gestart naar het verblijf vanaf '14-04-2020' op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo' van 'Jan'
      Dan is er geen 'verblijfplaats-onderzoek-gestart' gebeurtenis gepubliceerd

      Voorbeelden:
        | betwijfelde gegevens             |
        | de hele categorie verblijfplaats |
        | de groep adres                   |
        | datum aanvang adreshouding       |

  Regel: Als op een verblijfplaats voor de tweede keer een onderzoek is gestart, heeft de gebeurtenis 'verblijfplaats-onderzoek-gestart' plaatsgevonden

    Abstract Scenario: Een onderzoek was eerst afgerond en wordt nu opnieuw gestart <omschrijving>
      Gegeven een onderzoek loopt naar '<betwijfelde gegevens eerste onderzoek >' van het verblijf op het adres 'Beursstraat_44_Hengelo' van 'Jan'
      En het onderzoek naar het verblijf op het adres 'Beursstraat_44_Hengelo' van 'Jan' is beëindigd
      Als een onderzoek is gestart naar '<betwijfelde gegevens nieuwe onderzoek>' van het verblijf op het adres 'Beursstraat_44_Hengelo' van 'Jan'
      Dan is een 'verblijfplaats-onderzoek-gestart' gebeurtenis gepubliceerd

      Voorbeelden:
        | omschrijving                      | betwijfelde gegevens eerste onderzoek | betwijfelde gegevens nieuwe onderzoek |
        | met dezelfde betwijfelde gegevens | de hele categorie verblijfplaats      | de hele categorie verblijfplaats      |
        | met een ander betwijfeld gegeven  | de groep adres                        | datum aanvang adreshouding            |
