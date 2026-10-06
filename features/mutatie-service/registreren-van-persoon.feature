#language: nl

@MutatieService
Functionaliteit: Registreren van een persoon in de BRP

  Als consumer van BRP API gebeurtenissen
  Wil ik een persoon kunnen registreren in de BRP
  Zodat ik deze persoon kan gebruiken voor mijn testdoeleinden

  Regel: Bij het registreren van een persoon moet de adresseerbaar object identificatie van het adres waar de persoon verblijft en de verblijfdatum worden opgegeven

    Scenario: Er is geen adresseerbaar object identificatie en verblijfdatum opgegeven bij het registreren van een persoon
      Als een persoon wordt geregistreerd in de BRP zonder het opgeven van een adresseerbaar object identificatie en verblijfdatum
      Dan is de response een problemdetails met de melding dat de adresseerbaar object identificatie en verblijfdatum verplicht zijn

    Scenario: Er is geen adresseerbaar object identificatie opgegeven bij het registreren van een persoon
      Als een persoon wordt geregistreerd in de BRP zonder het opgeven van een adresseerbaar object identificatie
      Dan is de response een problemdetails met de melding dat de adresseerbaar object identificatie verplicht is

    Scenario: De datum waarop de persoon verblijft op het opgegeven adres is niet opgegeven bij het registreren van de persoon
      Gegeven het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo' in gemeente 'Hengelo' is geregistreerd in de BRP
      Als de persoon 'Jan' die verblijft op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo' wordt geregistreerd in de BRP zonder het opgeven van de verblijfdatum
      Dan is de response een problemdetails met de melding dat de verblijfdatum verplicht is

  Regel: Bij het registreren van een persoon moet een geldige adresseerbaar object identificatie worden opgegeven
    Een geldige adresseerbaar object identificatie bestaat uit precies 16 cijfers en er is een adres geregistreerd in de BRP voor deze identificatie.

    Abstract Scenario: De opgegeven adresseerbaar object identificatie bestaat uit <adresseerbaar object identificatie omschrijving>
      Als een persoon wordt geregistreerd in de BRP met adresseerbaar object identificatie '<adresseerbaar object identificatie>'
      Dan is de response een problemdetails met de melding dat de opgegeven adresseerbaar object identificatie ongeldig is

      Voorbeelden:
        | adresseerbaar object identificatie omschrijving | adresseerbaar object identificatie |
        | minder dan 16 cijfers                           | 123456789012345                    |
        | meer dan 16 cijfers                             | 12345678901234567                  |
        | niet-numeriek                                   | abcdefghijklmnop                   |

    Scenario: Er is geen adres geregistreerd in de BRP voor de opgegeven adresseerbaar object identificatie
      Als een persoon wordt geregistreerd in de BRP met adresseerbaar object identificatie '1234567890123456'
      Dan is de response een problemdetails met de melding dat er geen adres bestaat voor de opgegeven adresseerbaar object identificatie

  Regel: Bij het registreren van een persoon moet een geldige verblijfdatum worden opgegeven waarop de persoon verblijft op het opgegeven adres.
    Een geldige verblijfdatum is een datum zijn gelijk aan vandaag of een datum in het verleden en in het formaat 'jjjj-mm-dd'

    Scenario: Een ongeldig datum is opgegeven als verblijfdatum waarde
      Gegeven het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo' in gemeente 'Hengelo' is geregistreerd in de BRP
      Als de persoon 'Jan' die verblijft op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo' wordt geregistreerd in de BRP met een verblijfdatum in ongeldig formaat
      Dan is de response een problemdetails met de melding dat de opgegeven verblijfdatum ongeldig is

    Scenario: De opgegeven verblijfdatum ligt in de toekomst
      Gegeven het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo' in gemeente 'Hengelo' is geregistreerd in de BRP
      Als de persoon 'Jan' die verblijft op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo' wordt geregistreerd in de BRP met een verblijfdatum dat in de toekomst ligt
      Dan is de response een problemdetails met de melding dat de opgegeven verblijfdatum in de toekomst ligt

  Regel: Een uniek anummer en burgerservicenummer worden gegenereerd bij het registreren van een persoon
    Het anummer en het burgerservicenummer is een string bestaande uit 9 cijfers

    Scenario: Een persoon wordt geregistreerd in de BRP
      Gegeven het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo' in gemeente 'Hengelo' is geregistreerd in de BRP
      Als de persoon 'Jan' die vanaf 1-9-2025 verblijft op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo' wordt geregistreerd in de BRP
      Dan is de response een PersoonGeregistreerd response
      En is de persoon 'Jan' geregistreerd in de BRP met geslachtsnaam 'Jan', een unieke anummer en burgerservicenummer
      En is het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo' vanaf 1-9-2025 geregistreerd in de BRP als verblijfplaats van de persoon 'Jan'

    Scenario: Een persoon is geregistreerd in de BRP
      Gegeven het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo' in gemeente 'Hengelo' is geregistreerd in de BRP
      En de persoon 'Jan' die vanaf 1-9-2025 verblijft op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo' is geregistreerd in de BRP
      Dan is de persoon 'Jan' geregistreerd in de BRP met geslachtsnaam 'Jan', een unieke anummer en burgerservicenummer
      En is het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo' vanaf 1-9-2025 geregistreerd in de BRP als verblijfplaats van de persoon 'Jan'
