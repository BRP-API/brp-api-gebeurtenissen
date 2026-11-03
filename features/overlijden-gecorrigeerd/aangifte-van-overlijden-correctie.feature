# language: nl

Functionaliteit: Aangifte van correctie van overlijden

  Regel: Aangifte van correctie van overlijden van een persoon kan alleen worden gedaan als in de BRP is geregistreerd dat de persoon is overleden
    De actuele rij in lo3_pl_overlijden moet namelijk historisch worden gemaakt en 'O' moet worden ingevuld in kolom onjuist_ind

  Regel: Een overlijden wordt ongedaan gemaakt met een aangifte van correctie van overlijden waarbij datum, plaats en land van overlijden niet zijn opgegeven

    Scenario: Overlijden is ten onrechte geregistreerd
      Gegeven de persoon 'Jan' is geregistreerd in de BRP
      En het overlijden van 'Jan' op '12-08-2026' in 'Gemeente Roosendaal' is verwerkt
      Als het overlijden van 'Jan' ten onrechte wordt verklaard
      Dan is een overlijden gecorrigeerd gebeurtenis voor 'Jan' gepubliceerd

  Regel: Een overlijden wordt gecorrigeerd met een aangifte van correctie van overlijden waarbij voor datum, plaats en land van overlijden hun correcte waarde zijn opgegeven

    Scenario: Datum van overlijden wordt gecorrigeerd
      Gegeven de persoon 'Jan' is geregistreerd in de BRP
      En het overlijden van 'Jan' op '12-08-2026' in 'Gemeente Roosendaal' is verwerkt
      Als het overlijden van 'Jan' wordt gecorrigeerd naar '13-08-2026' in 'Gemeente Roosendaal'
      Dan is een overlijden gecorrigeerd gebeurtenis voor 'Jan' gepubliceerd

    Scenario: Plaats van overlijden wordt gecorrigeerd
      Gegeven de persoon 'Jan' is geregistreerd in de BRP
      En het overlijden van 'Jan' op '12-08-2026' in 'Gemeente Roosendaal' is verwerkt
      Als het overlijden van 'Jan' wordt gecorrigeerd naar '12-08-2026' in 'Gemeente Amsterdam'
      Dan is een overlijden gecorrigeerd gebeurtenis voor 'Jan' gepubliceerd

  Regel: Een aangifte van overlijden wordt administratief gecorrigeerd met een aangifte van administratieve correctie van overlijden

    Scenario: Overlijden wordt administratief gecorrigeerd
      Gegeven de persoon 'Jan' is geregistreerd in de BRP
      En het overlijden van 'Jan' op '12-08-2026' in 'Gemeente Roosendaal' is verwerkt
      Als het overlijden van 'Jan' administratief wordt gecorrigeerd
      Dan is een overlijden gecorrigeerd gebeurtenis voor 'Jan' gepubliceerd
