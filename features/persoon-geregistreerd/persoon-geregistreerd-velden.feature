# language: nl

Functionaliteit: Persoon geregistreerd gebeurtenis velden

  Regel: Een 'persoon geregistreerd' gebeurtenis bevat een gegenereerde persoonId en de BRP identificatienummers van een persoon

    Scenario: Een gebeurtenis wordt gepubliceerd voor een persoon voor wie nog geen gebeurtenissen zijn gepubliceerd
      Gegeven de persoon 'Jan' is geregistreerd in de BRP
      En er zijn nog geen gebeurtenissen gepubliceerd voor 'Jan'
      Als een 'verhuisd intergemeentelijk' gebeurtenis wordt gepubliceerd voor 'Jan'
      Dan bevat de 'persoon geregistreerd' gebeurtenis voor 'Jan' een persoonId
      En bevat de 'persoon geregistreerd' gebeurtenis het a-nummer, het burgerservicenummer en de pl_id van 'Jan'

  Regel: Elke andere gebeurtenis voor een persoon bevat de persoonId uit de 'persoon geregistreerd' gebeurtenis van die persoon

    Scenario: Een gebeurtenis wordt gepubliceerd voor een persoon voor wie een 'persoon geregistreerd' gebeurtenis is gepubliceerd
      Gegeven de persoon 'Jan' is geregistreerd in de BRP
      En er is een 'persoon geregistreerd' gebeurtenis gepubliceerd voor 'Jan'
      Als een 'verhuisd intergemeentelijk' gebeurtenis wordt gepubliceerd voor 'Jan'
      Dan is de persoonId in de 'verhuisd intergemeentelijk' gebeurtenis gelijk aan de persoonId in de 'persoon geregistreerd' gebeurtenis voor 'Jan'
      En bevat de 'verhuisd intergemeentelijk' gebeurtenis voor 'Jan' geen a-nummer, geen burgerservicenummer en geen pl_id

  Regel: Twee personen met hetzelfde burgerservicenummer krijgen elk een eigen persoonId

    Scenario: Een persoon met hetzelfde burgerservicenummer als een al geregistreerde persoon krijgt een eigen persoonId
      Gegeven de persoon 'Jan' is geregistreerd in de BRP
      En er is een 'persoon geregistreerd' gebeurtenis gepubliceerd voor 'Jan'
      En de persoon 'Piet' is geregistreerd in de BRP met hetzelfde burgerservicenummer als 'Jan'
      En er zijn nog geen gebeurtenissen gepubliceerd voor 'Piet'
      Als een 'verhuisd intergemeentelijk' gebeurtenis wordt gepubliceerd voor 'Piet'
      Dan bevat de 'persoon geregistreerd' gebeurtenis van 'Piet' een persoonId die ongelijk is aan die van 'Jan'
      En bevat de 'persoon geregistreerd' gebeurtenis het a-nummer, het burgerservicenummer en de pl_id van 'Piet'
