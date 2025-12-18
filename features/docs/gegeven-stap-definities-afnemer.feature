# language: nl
@stap-documentatie
Functionaliteit: Afnemer gegeven stap definities

  Scenario: Gegeven de afnemer '[afnemer aanduiding]'
    Gegeven de afnemer 'Gemeente Den Haag'
    Dan heeft de afnemer 'Gemeente Den Haag' de volgende eigenschappen
      | aanduiding        |
      | Gemeente Den Haag |

  Abstract Scenario: Gegeven in gemeente '[gemeente omschrijving]'
    Gegeven de afnemer 'Afnemer A'
    * in gemeente '<gemeente omschrijving>'
    Dan heeft de afnemer 'Afnemer A' de volgende eigenschappen
      | aanduiding | gemeenteCode    |
      | Afnemer A  | <gemeente code> |

    Voorbeelden:
      | gemeente omschrijving | gemeente code |
      | Amsterdam             |          0363 |
      | Den Haag              |          0518 |
      | Hengelo               |          0164 |
      | Roosendaal            |          1674 |
      | Rotterdam             |          0599 |
      | Utrecht               |          0344 |

  Scenario: Gegeven met afnemer identificatie '[waarde]'
    Gegeven de afnemer 'Afnemer B'
    * met afnemer identificatie '00000001'
    Dan heeft de afnemer 'Afnemer B' de volgende eigenschappen
      | aanduiding | afnemerId |
      | Afnemer B  |  00000001 |

  Scenario: Gegeven met oin '[waarde]'
    Gegeven de afnemer 'Afnemer C'
    * met oin '000000099000000080000'
    Dan heeft de afnemer 'Afnemer C' de volgende eigenschappen
      | aanduiding | oin                   |
      | Afnemer C  | 000000099000000080000 |

  Scenario: Gegeven de afnemer is een gemeente
    Gegeven de afnemer 'Gemeente Den Haag'
    * in gemeente 'Den Haag'
    * met afnemer identificatie '000001'
    * met oin '000000099000000081234'
    Dan is de gegenereerde client scope JSON voor afnemer 'Gemeente Den Haag'
      """
      {
        "name": "000000099000000081234",
        "protocol": "openid-connect",
        "attributes": {
            "include.in.token.scope": "true",
            "display.on.consent.screen": "false"
        }
      }
      """
    En is de gegenereerde client JSON voor afnemer 'Gemeente Den Haag'
      """
      {
        "clientId": "Gemeente Den Haag",
        "enabled": true,
        "clientAuthenticatorType": "client-secret",
        "secret": "secret",
        "standardFlowEnabled": false,
        "implicitFlowEnabled": false,
        "directAccessGrantsEnabled": false,
        "serviceAccountsEnabled": true,
        "publicClient": false,
        "protocol": "openid-connect",
        "attributes": {
          "access.token.lifespan": "300",
          "oauth2.device.authorization.grant.enabled": "false",
          "oidc.ciba.grant.enabled": "false"
        }
      }
      """
    En is de gegenereerde protocol mapper JSON voor afnemer 'Gemeente Den Haag'
      """
      {
        "name": "claims-mapper",
        "protocol": "openid-connect",
        "protocolMapper": "oidc-hardcoded-claim-mapper",
        "consentRequired": false,
        "config": {
          "claim.name": "claims",
          "claim.value": "[\"OIN=000000099000000081234\",\"afnemerID=000001\",\"gemeenteCode=0518\"]",
          "jsonType.label": "JSON",
          "userinfo.token.claim": "true",
          "id.token.claim": "true",
          "access.token.claim": "true"
        }
      }
      """

  Scenario: Gegeven de afnemer is geen gemeente
    Gegeven de afnemer 'Afnemer A'
    * met afnemer identificatie '100001'
    * met oin '000000099000000084567'
    Dan is de gegenereerde client scope JSON voor afnemer 'Afnemer A'
      """
      {
        "name": "000000099000000084567",
        "protocol": "openid-connect",
        "attributes": {
            "include.in.token.scope": "true",
            "display.on.consent.screen": "false"
        }
      }
      """
    En is de gegenereerde client JSON voor afnemer 'Afnemer A'
      """
      {
        "clientId": "Afnemer A",
        "enabled": true,
        "clientAuthenticatorType": "client-secret",
        "secret": "secret",
        "standardFlowEnabled": false,
        "implicitFlowEnabled": false,
        "directAccessGrantsEnabled": false,
        "serviceAccountsEnabled": true,
        "publicClient": false,
        "protocol": "openid-connect",
        "attributes": {
          "access.token.lifespan": "300",
          "oauth2.device.authorization.grant.enabled": "false",
          "oidc.ciba.grant.enabled": "false"
        }
      }
      """
    En is de gegenereerde protocol mapper JSON voor afnemer 'Afnemer A'
      """
      {
        "name": "claims-mapper",
        "protocol": "openid-connect",
        "protocolMapper": "oidc-hardcoded-claim-mapper",
        "consentRequired": false,
        "config": {
          "claim.name": "claims",
          "claim.value": "[\"OIN=000000099000000084567\",\"afnemerID=100001\"]",
          "jsonType.label": "JSON",
          "userinfo.token.claim": "true",
          "id.token.claim": "true",
          "access.token.claim": "true"
        }
      }
      """

  Regel: De default afnemer (geen enkel gegeven wordt expliciet gezet) heeft als oin '000000099000000010000', afnemer identificatie '000001' en geen gemeente

    @integratie
    Scenario: Aanmaken van een client in Keycloak voor de default afnemer
      Gegeven de afnemer 'Default Afnemer'
      Dan is de client succesvol aangemaakt in Keycloak voor afnemer 'Default Afnemer'

    @integratie
    Scenario: Aanmaken van een client in Keycloak voor afnemer
      Gegeven de afnemer 'Gemeente Rotterdam'
      * in gemeente 'Rotterdam'
      * met afnemer identificatie '000002'
      * met oin '000000099000000082345'
      Dan is de client succesvol aangemaakt in Keycloak voor afnemer 'Gemeente Rotterdam'

    @integratie
    Scenario: Aanmaken van een client in Keycloak voor afnemer die geen gemeente is
      Gegeven de afnemer 'Niet-gemeente afnemer'
      * met afnemer identificatie '200001'
      * met oin '000000099000000085678'
      Dan is de client succesvol aangemaakt in Keycloak voor afnemer 'Niet-gemeente afnemer'
