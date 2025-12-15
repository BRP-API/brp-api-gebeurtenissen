#language: nl

Functionaliteit: Abonneer op gebeurtenis type

  Als abonnee van BRP API Gebeurtenissen
  wil ik mij kunnen abonneren op gebeurtenissen van personen aan wie ik diensten verleen
  zodat ik alleen de relevante gebeurtenissen krijg die nodig zijn voor mijn dienstverlening

  Regel: Een afnemer kan zich abonneren op gebeurtenis types als hij is geregistreerd als abonnee.

    Scenario: Een geregistreerde abonnee abonneert zich op een specifiek gebeurtenis type
      Gegeven de persoon 'Jan'
      Gegeven de afnemer 'Gemeente Den Haag'
      * is geregistreerd als abonnee van BRP API Gebeurtenissen
      Als de afnemer zich abonneert op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      Dan is een 'op-gebeurtenis-type-geabonneerd' gebeurtenis gepubliceerd met de volgende data velden
      * de afnemer id van 'Gemeente Den Haag'
      * het gebeurtenis type 'verhuisd.intergemeentelijk'
      * het a-nummer van 'Jan'
      En is de response '201 Created'

    Scenario: Een niet-geregistreerde afnemer probeert zich te abonneren op een specifiek gebeurtenis type
      Gegeven de afnemer 'Gemeente Den Haag'
      * is niet geregistreerd als abonnee van BRP API Gebeurtenissen
      Als de afnemer zich abonneert op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      Dan zijn er geen gebeurtenissen gepubliceerd
      En is de response '403 Forbidden'
      * heeft het detail veld de tekst 'Uw verzoek kan niet worden uitgevoerd omdat u niet als abonnee geregistreerd bent.'

    Scenario: Een niet-geautheniceerde gebruiker probeert zich te abonneren op een specifiek gebeurtenis type
      Als een niet-geauthenticeerde gebruiker zich abonneert op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      Dan zijn er geen gebeurtenissen gepubliceerd
      En is de response '401 Unauthorized'