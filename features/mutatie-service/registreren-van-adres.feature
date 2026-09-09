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

  Regel: De opgegeven gemeentecode bestaat uit exact 4 cijfers

    Abstract Scenario: De opgegeven gemeentecode bestaat uit <gemeentecode omschrijving>
      Als een adres in een gemeente wordt geregistreerd in de BRP met een gemeentecode '<gemeentecode>'
      Dan is de response een problemdetails response met de melding dat de gemeentecode ongeldig is

      Voorbeelden:
        | gemeentecode omschrijving | gemeentecode |
        | 3 cijfers                 | 123          |
        | 5 cijfers                 | 12345        |
        | naam van een gemeente     | Eindhoven    |

  Regel: De opgegeven gemeentecode bestaat niet in de BRP

    Scenario: De opgegeven gemeentecode bestaat niet in de BRP
      Als een adres in een gemeente wordt geregistreerd in de BRP met een gemeentecode die niet bestaat
      Dan is de response een problemdetails response met een invalidParams object met de melding dat de gemeentecode niet bestaat

  Regel: Een uniek adresseerbaar object identificatie wordt gegenereerd bij het registreren van een adres
    De gegenereerde adresseerbaar object identificatie is een string bestaande uit 16 cijfers waarbij
    - de eerste 4 cijfers gelijk zijn aan de opgegeven gemeentecode
    - de volgende 2 cijfers gelijk zijn aan '01'
    - de laatste 10 cijfers random zijn

    Scenario: Een adres wordt geregistreerd voor de opgegeven gemeente
      Als het adres 'Burgemeester van der Dusselplein 1' in gemeente 'Hengelo' wordt geregistreerd in de BRP
      Dan is de response een AdresGeregistreerd response
      En is het adres geregisteerd in de BRP
