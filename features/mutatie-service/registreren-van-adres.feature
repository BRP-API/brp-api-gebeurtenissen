#language: nl

@MutatieService
Functionaliteit: Registreren van een adres in de BRP

  Als consumer van BRP API gebeurtenissen
  Wil ik een adres kunnen registreren in de BRP
  Zodat ik dit adres kan gebruiken voor mijn test doeleinden

  Regel: De code van de gemeente waar een adres zich bevindt moet worden opgegeven bij het registreren van het adres

    Scenario: Er is geen gemeentecode opgegeven bij het registreren van een adres
      Als een adres in een gemeente wordt geregistreerd in de BRP zonder het opgeven van de code van de gemeente
      Dan is de response een problemdetails met de melding dat de gemeentecode verplicht is

  Regel: De opgegeven gemeentecode bestaat niet in de BRP

    Scenario: De opgegeven gemeentecode bestaat niet in de BRP
      Als een adres in een gemeente wordt geregistreerd in de BRP met een gemeentecode die niet bestaat
      Dan is de response een problemdetails response met een invalidParams object met de melding dat de gemeentecode niet bestaat

  Regel: Een adresseerbaar object identificatie wordt gegenereerd bij het registreren van een adres
    De gegenereerde adresseerbaar object identificatie is een string bestaande uit 16 cijfers
    - waarvan de eerste 4 cijfers gelijk zijn aan de opgegeven gemeentecode
    - en de overige 12 cijfers is gelijk aan '010000000001' als deze nog niet is gebruikt voor de opgegeven gemeente
    - of de overige 12 cijfers is gelijk aan '010000000001' opgehoogd met 1 totdat deze nog niet eerder is gebruikt voor opgegeven gemeente

    Scenario: Er zijn geen adressen geregistreerd voor de opgegeven gemeente
      Gegeven er zijn nog geen adressen in gemeente 'Hengelo' geregistreerd in de BRP
      Als het adres 'Burgemeester van der Dusselplein 1' in gemeente 'Hengelo' wordt geregistreerd in de BRP
      Dan is de response een AdresGeregistreerd response met adresseerbaar object identificatie '0614010000000001'
      En is het adres geregisteerd in de BRP

    Scenario: Er zijn al adressen geregistreerd voor de opgegeven gemeente
      Gegeven een adres met adresseerbaar object identificatie '0614010000000001' in gemeente 'Hengelo' is geregistreerd in de BRP
      Als het adres 'Burgemeester van der Dusselplein 1' in gemeente 'Hengelo' wordt geregistreerd in de BRP
      Dan is de response een AdresGeregistreerd response met adresseerbaar object identificatie '0614010000000002'
      En is het adres geregisteerd in de BRP
