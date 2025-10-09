# language: nl
Functionaliteit: aangifte van adreswijziging naar een andere gemeente
  To do: invullen defaultwaarden verblijfplaats die gevuld worden

  Achtergrond:
    Gegeven een adres in 'Roosendaal' is het standaard adres dat wordt opgegeven als verblijfplaats bij een standaard geboorte aangifte
    En een adres in 'Hengelo' is het standaard adres dat wordt opgegeven als verblijfplaats na een intergemeentelijke verhuizing
    En de persoon 'Jan'

  Regel: de mutatie-service voert bij aangifte van adreswijziging naar een andere gemeente default verblijfplaatsgegevens op in de BRP-V en stuurt een 'verhuisd.intergemeentelijk' event

    Scenario: Aangifte van adreswijziging naar een andere gemeente wordt vastgelegd in de BRP-V
      Als de aangifte van adreswijziging naar een andere gemeente van 'Jan' is verwerkt
      Dan heeft tabel 'lo3_pl_verblijfplaats' de volgende rijen
        | pl_id | adres_id              | volg_nr | gemeente van inschrijving (09.10) | datum inschrijving in de gemeente (09.20) | functie adres (10.10) | datum aanvang adreshouding (10.30) | aangifte adreshouding (72.10) | ingangsdatum geldigheid (85.10) |
        | Jan   | adres in 'Hengelo'    |       0 | gemeentecode van Hengelo          | gisteren                                  | W                     | gisteren                           | I                             | gisteren                        |
        | Jan   | adres in 'Roosendaal' |       1 | gemeentecode van Roosendaal       | ______                                    | _                     | ______                             | _                             | ______                          |

    Scenario: Aangifte van adreswijziging naar een andere gemeente wordt vastgelegd als event 'verhuisd.intergemeentelijk'
      Als de aangifte van adreswijziging naar een andere gemeente van 'Jan' is verwerkt
      Dan is een 'verhuisd.intergemeentelijk' gebeurtenis het laatst gepubliceerd
      * bevat de 'data' in categorie 'persoon' element in groep 'identificatienummers' het element 'A-nummer (01.10)' van 'Jan'
      * bevat de 'data' in categorie 'verblijfplaats' in groep 'adreshouding' element 'datum aanvang adreshouding (10.30)' met waarde 'gisteren'
      * bevat de 'data' in categorie 'verblijfplaats' in groep 'adres' element 'identificatiecode verblijfplaats (11.80)' van het adres in 'Hengelo'
