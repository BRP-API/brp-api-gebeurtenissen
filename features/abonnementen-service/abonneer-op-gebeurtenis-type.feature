# language: nl
Functionaliteit: Abonneer op gebeurtenistype
  Als abonnee van BRP API Gebeurtenissen
  wil ik mij kunnen abonneren op specifieke gebeurtenissen van personen aan wie ik diensten verleen
  zodat ik alleen die gebeurtenissen krijg die relevant zijn voor mijn dienstverlening

  Achtergrond:
    Gegeven de persoon 'Jan'
    En de persoon 'Piet'

  Regel: Alleen een als abonnee geregistreerde afnemer kan zich abonneren op gebeurtenistypes

    Scenario: Een geregistreerde abonnee abonneert zich op een specifiek gebeurtenistype
      Gegeven de afnemer 'Gemeente Den Haag'
      * is geregistreerd als abonnee 'szw' van BRP API Gebeurtenissen
      Als de abonnee 'szw' zich abonneert op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      Dan is een 'op-gebeurtenis-type-van-persoon-geabonneerd' gebeurtenis gepubliceerd met de volgende data velden
      * de afnemer id van 'Gemeente Den Haag'
      * 'abonnee' met de waarde 'szw'
      * het gebeurtenistype 'verhuisd.intergemeentelijk'
      * het a-nummer van 'Jan'
      En is de response '201 Created'

    Scenario: Een niet-geregistreerde abonnee probeert zich te abonneren op een specifiek gebeurtenistype
      Gegeven de afnemer 'Gemeente Den Haag'
      * is niet geregistreerd als abonnee van BRP API Gebeurtenissen
      Als de abonnee 'szw' zich abonneert op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      Dan zijn er geen gebeurtenissen gepubliceerd
      En is de response '403 Forbidden'
      * heeft het detail veld de tekst 'Uw verzoek kan niet worden uitgevoerd omdat u niet als abonnee geregistreerd bent.'

    Scenario: Een afnemer heeft zich geregistreerd als abonnee en probeert zich te abonneren met een andere abonneenaam op een specifiek gebeurtenistype
      Gegeven de afnemer 'Gemeente Den Haag'
      * is geregistreerd als abonnee 'szw' van BRP API Gebeurtenissen
      Als de abonnee 'JZ' zich abonneert op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      Dan zijn er geen gebeurtenissen gepubliceerd
      En is de response '403 Forbidden'
      * heeft het detail veld de tekst 'Uw verzoek kan niet worden uitgevoerd omdat u niet als abonnee geregistreerd bent.'

    Scenario: Een afnemer wil zich abonneren met een abonneenaam die door een andere afnemer is geregistreerd
      Gegeven de afnemer 'Gemeente Rotterdam'
      * is geregistreerd als abonnee 'szw' van BRP API Gebeurtenissen
      En de afnemer 'Gemeente Den Haag'
      * is niet geregistreerd als abonnee van BRP API Gebeurtenissen
      Als de abonnee 'szw' van afnemer 'Gemeente Den Haag' zich abonneert op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      Dan zijn er geen gebeurtenissen gepubliceerd
      En is de response '403 Forbidden'
      * heeft het detail veld de tekst 'Uw verzoek kan niet worden uitgevoerd omdat u niet als abonnee geregistreerd bent.'

    Scenario: Een niet-geautheniceerde gebruiker probeert zich te abonneren op een specifiek gebeurtenistype
      Als een niet-geauthenticeerde gebruiker zich abonneert op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      Dan zijn er geen gebeurtenissen gepubliceerd
      En is de response '401 Unauthorized'

  Regel: Een abonnee kan alleen een abonnement op een specifiek gebeurtenistype van een specifieke persoon nemen, wanneer hij hier nog niet op geabonneerd is

    Scenario: Een geregistreerde abonnee abonneert zich op een specifiek gebeurtenistype en is hier al op geabonneerd
      Gegeven de afnemer 'Gemeente Den Haag'
      * is geregistreerd als abonnee 'szw' van BRP API Gebeurtenissen
      * is geregistreerd als abonnee 'JZ' van BRP API Gebeurtenissen
      En abonnee 'JZ' is geabonneerd op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      Als de abonnee 'szw' zich abonneert op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      Dan zijn er geen gebeurtenissen gepubliceerd
      En is de response '409 Conflict' met de volgende velden
      * 'detail' met tekst 'Uw verzoek kan niet worden uitgevoerd omdat u dit abonnement al heeft.'

    Scenario: Een geregistreerde abonnee abonneert zich op een specifiek gebeurtenistype en een andere abonnee van dezelfde afnemer is hier al op geabonneerd
      Gegeven de afnemer 'Gemeente Den Haag'
      * is geregistreerd als abonnee 'szw' van BRP API Gebeurtenissen
      * is geregistreerd als abonnee 'JZ' van BRP API Gebeurtenissen
      En abonnee 'JZ' is geabonneerd op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      Als de abonnee 'szw' zich abonneert op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      Dan is een 'op-gebeurtenis-type-van-persoon-geabonneerd' gebeurtenis gepubliceerd met de volgende data velden
      * de afnemer id van 'Gemeente Den Haag'
      * 'abonnee' met de waarde 'szw'
      * het gebeurtenistype 'verhuisd.intergemeentelijk'
      * het a-nummer van 'Jan'
      En is de response '201 Created'

    Scenario: Een geregistreerde abonnee abonneert zich op een specifiek gebeurtenistype en is al op geabonneerd op hetzelfde gebeurtenistype van een andere persoon
      Gegeven de afnemer 'Gemeente Den Haag'
      * is geregistreerd als abonnee 'szw' van BRP API Gebeurtenissen
      En abonnee 'szw' is geabonneerd op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Piet'
      Als de abonnee 'szw' zich abonneert op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      Dan is een 'op-gebeurtenis-type-van-persoon-geabonneerd' gebeurtenis gepubliceerd met de volgende data velden
      * de afnemer id van 'Gemeente Den Haag'
      * 'abonnee' met de waarde 'szw'
      * het gebeurtenistype 'verhuisd.intergemeentelijk'
      * het a-nummer van 'Jan'
      En is de response '201 Created'

    Scenario: Een geregistreerde abonnee abonneert zich op een specifiek gebeurtenistype en is al op geabonneerd op een ander gebeurtenistype van een dezelfde persoon
      Gegeven de afnemer 'Gemeente Den Haag'
      * is geregistreerd als abonnee 'szw' van BRP API Gebeurtenissen
      En abonnee 'szw' is geabonneerd op de 'verhuisd.naar-buitenland' gebeurtenissen van 'Jan'
      Als de abonnee 'szw' zich abonneert op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      Dan is een 'op-gebeurtenis-type-van-persoon-geabonneerd' gebeurtenis gepubliceerd met de volgende data velden
      * de afnemer id van 'Gemeente Den Haag'
      * 'abonnee' met de waarde 'szw'
      * het gebeurtenistype 'verhuisd.intergemeentelijk'
      * het a-nummer van 'Jan'
      En is de response '201 Created'
    
    Scenario: Een geregistreerde abonnee abonneert zich op een specifiek gebeurtenistype en een abonnee met dezelfde abonneenaam van een andere afnemer is hier al op geabonneerd
      Gegeven de afnemer 'Gemeente Rotterdam'
      * is geregistreerd als abonnee 'szw' van BRP API Gebeurtenissen
      * abonnee 'szw' is geabonneerd op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      En de afnemer 'Gemeente Den Haag'
      * is geregistreerd als abonnee 'szw' van BRP API Gebeurtenissen
      Als de abonnee 'szw' zich abonneert op de 'verhuisd.intergemeentelijk' gebeurtenissen van 'Jan'
      Dan is een 'op-gebeurtenis-type-van-persoon-geabonneerd' gebeurtenis gepubliceerd met de volgende data velden
      * de afnemer id van 'Gemeente Den Haag'
      * 'abonnee' met de waarde 'szw'
      * het gebeurtenistype 'verhuisd.intergemeentelijk'
      * het a-nummer van 'Jan'
      En is de response '201 Created'
