#language: nl

Functionaliteit: Verwijderen van een persoon in de BRP (test) database

  Als tester van BRP API gebeurtenissen
  Wil ik een geregistreerd persoon in de BRP kunnen verwijderen
  Zodat ik mijn tests met dezelfde persoon kan herhalen

  Regel: Een persoon mag alleen worden verwijderd door een afnemer

    Scenario: Een persoon wordt verwijderd door een niet-geauthenticeerd client
      Als een verwijder persoon aanroep wordt gedaan door een niet-geauthenticeerd client
      Dan is de response een problemdetails met status 401 en de melding dat de gebruiker niet is geauthenticeerd

  Regel: Een geldig persoon identificatie moet worden opgegeven

    Scenario: Een geslachtsnaam en geboortedatum wordt opgegeven als persoon identificatie
      Als een geslachtsnaam en geboortedatum wordt opgegeven voor het vewijderen van een persoon
      Dan is de response een problemdetails met status 400 en de melding dat de opgegeven persoon identificatie ongeldig is

  Regel: Alleen een bestaand persoon kan worden verwijderd

    Scenario: Een bestaand persoon wordt verwijderd
      Gegeven het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo' in gemeente 'Hengelo' is geregistreerd in de BRP
      En de persoon 'Jan' die vanaf 1-9-2025 verblijft op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo' is geregistreerd in de BRP
      Als de persoon 'Jan' wordt verwijderd in de BRP
      Dan is de response '204 No Content'
      En is persoon 'Jan' en zijn gerelateerde entiteiten verwijderd in de BRP

    Scenario: De identificatie van een niet-bestaand persoon wordt opgegeven
      Als een niet-bestaand persoon wordt verwijderd
      Dan is de response een problemdetails met status 404 en de melding dat er geen persoon bestaat voor de opgegeven persoon identificatie

  Regel: Een adres wordt niet verwijderd als alle personen die op dat adres verblijven zijn verwijderd

    Scenario: Alle personen die op een adres verblijven worden verwijderd
      Gegeven het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo' in gemeente 'Hengelo' is geregistreerd in de BRP
      En de persoon 'Jan' die vanaf 1-9-2025 verblijft op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo' is geregistreerd in de BRP
      En de persoon 'Piet' die vanaf 1-9-2025 verblijft op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo' is geregistreerd in de BRP
      Als de persoon 'Jan' wordt verwijderd in de BRP
      En de persoon 'Piet' wordt verwijderd in de BRP
      Dan is het adres 'Burgemeester van der Dusselplein 1' niet verwijderd in de BRP
