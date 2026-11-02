# language: nl

Functionaliteit: Aangifte van correctie van overlijden

  Regel: Aangifte van correctie van overlijden van een persoon kan alleen worden gedaan als in de BRP is geregistreerd dat de persoon is overleden
    De actuele rij in lo3_pl_overlijden moet namelijk historisch worden gemaakt en 'O' moet worden ingevuld in kolom onjuist_ind

  Regel: Een aangifte van overlijden wordt ongedaan gemaakt met een aangifte van correctie van overlijden waar alleen de burgerservicenummer van de betreffende persoon is opgegeven

  Regel: De datum, plaats en land van overlijden kunnen worden gecorrigeerd met een aangifte van correctie van overlijden

  Regel: Het administratief corrigeren van een overlijden is geen correctie van het overlijden van de betreffende persoon
