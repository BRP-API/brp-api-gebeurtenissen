# language: nl
Functionaliteit: Gebeurtenis wanneer de persoonslijst van een persoon is afgevoerd
  Als abonnee wil ik het weten wanneer een persoonslijst is afgevoerd,
  zodat ik een onderzoek kan starten naar de consequenties van het afvoeren op mijn dienstverlening.

  Zie https://www.rvig.nl/hup/afvoeren-van-een-ten-onrechte-opgenomen-persoonslijst

  In de volgende gevallen is sprake van een ten onrechte opgenomen persoonslijst:
  - De persoonslijst die na het uitvoeren van Dubbelinschrijving overbodig is geworden.
  - Uit onderzoek blijkt dat een persoonslijst ten onrechte is aangelegd, bijvoorbeeld omdat er identiteitsfraude is gepleegd.

  De gebeurtenis 'persoonslijst-afgevoerd' is te herkennen aan het vullen van omschrijving reden opschorting bijhouding (07.67.20) wordt gevuld met de waarde 'F' (= fout).

  Opmerking: het is mogelijk dat bij oplossen van een dubbelinschrijving eerst de persoonslijst wordt afgevoerd, 
  en daarna - in een volgend Lg01 bericht - de A-nummerverwijzing wordt opgevoerd.
  Er komt dan eerst een gebeurtenis 'persoonslijst-afgevoerd' en daarna een gebeurtenis 'dubbelinschrijving-opgelost.a-nummer-gewijzigd'.

  Regel: Als opschorting bijhouding is gevuld met reden Fout, dan heeft gebeurtenis 'persoonslijst-afgevoerd' plaatsgevonden

    Scenario: Persoonslijst wordt afgevoerd bij dubbelinschrijving
      Gegeven 'Gemeente Amsterdam' heeft de persoonslijst voor 'Jan' met A-nummer 9000000001 en burgerservicenummer 000000012
      En 'RNI' heeft de persoonslijst voor 'Jan' met A-nummer 9000000002 en burgerservicenummer 000000024
      Als de dubbelschrijving van 'Jan' wordt opgelost
      * op de overbodig geworden persoonslijst met A-nummer 9000000002 heeft 'omschrijving reden opschorting bijhouding' de waarde 'F' gekregen
      Dan is een 'persoonslijst-afgevoerd' gebeurtenis gepubliceerd

    Scenario: Onterecht opgevoerde persoonslijst wordt afgevoerd
      Gegeven 'Gemeente Amsterdam' heeft de persoonslijst voor 'Jan' met A-nummer 9000000001 en burgerservicenummer 000000012
      Als de persoonslijst wordt met A-nummer 9000000002 wordt afgevoerd
      Dan is een 'persoonslijst-afgevoerd' gebeurtenis gepubliceerd

  Regel: Bij gebeurtenistype 'persoonslijst-afgevoerd' wordt het A-nummer van de persoon meegeleverd en de opschorting bijhouding

    Scenario: Onterecht opgevoerde persoonslijst wordt afgevoerd
      Gegeven 'Gemeente Amsterdam' heeft de persoonslijst voor 'Jan' met A-nummer 9000000001 en burgerservicenummer 000000012
      Als op '15-09-2026' de persoonslijst wordt met A-nummer 9000000002 wordt afgevoerd
      Dan is een 'persoonslijst-afgevoerd' gebeurtenis gepubliceerd met de volgende data
      * A-nummer 9000000001
      * datum opschorting bijhouding '15-09-2026'
      * Omschrijving reden opschorting bijhouding 'F'
