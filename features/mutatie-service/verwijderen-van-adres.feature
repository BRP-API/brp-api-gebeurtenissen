#language: nl

Functionaliteit: Verwijderen van een adres in de BRP test database

  Als tester van BRP API gebeurtenissen
  Wil ik een geregistreerd adres in de BRP kunnen verwijderen
  Zodat ik mijn tests met hetzelfde adres kan herhalen

  Regel: Een adres mag alleen worden verwijderd door een afnemer

    Scenario: Een adres wordt verwijderd door een niet-geauthenticeerd client
      Als een verwijder adres aanroep wordt gedaan door een niet-geauthenticeerd client
      Dan is de response een problemdetails met status 401 en de melding dat de gebruiker niet is geauthenticeerd

  Regel: Een geldig adres identificatie moet worden opgegeven

    Scenario: Een straatnaam en huisnummer wordt opgegeven als adres identificatie
      Als een straatnaam en huisnummer wordt opgegeven voor het vewijderen van een adres
      Dan is de response een problemdetails met status 400 en de melding dat de opgegeven adres identificatie ongeldig is

  Regel: Alleen een bestaand adres kan worden verwijderd

    Scenario: Een bestaand adres wordt verwijderd
      Gegeven het adres 'Burgemeester van der Dusselplein 1' in gemeente 'Hengelo' is geregistreerd in de BRP
      Als het adres 'Burgemeester van der Dusselplein 1' wordt verwijderd in de BRP
      Dan is de response '204 No Content'
      En is het adres 'Burgemeester van der Dusselplein 1' verwijderd in de BRP

    Scenario: De identificatie van een niet-bestaand adres wordt opgegeven
      Als een niet-bestaand adres wordt verwijderd
      Dan is de response een problemdetails met status 404 en de melding dat er geen adres bestaat voor de opgegeven adres identificatie

  Regel: Een adres kan niet worden verwijderd als er personen op dat adres verblijven (HTTP Status 409)

    Scenario: Een adres waar personen verblijven wordt verwijderd
      Gegeven het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo' in gemeente 'Hengelo' is geregistreerd in de BRP
      En de persoon 'Jan' die vanaf 1-9-2025 verblijft op het adres 'Burgemeester_Van_Der_Dussenplein_1_Hengelo' is geregistreerd in de BRP
      Als het adres 'Burgemeester van der Dusselplein 1' wordt verwijderd in de BRP
      Dan is de response een problemdetails met status 409 de melding dat er personen verblijven op het adres
