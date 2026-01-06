import { Afnemer } from '../brp/afnemer-entity';
import { oauthConfig } from './oauth-config';
import { logger } from './logger';

async function getAccessToken(URLSearchParams: URLSearchParams, tokenUrl: string): Promise<string> {
  const response = await fetch(tokenUrl, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: URLSearchParams.toString(),
  });

  if (!response.ok) {
    logger.error(`Failed to obtain access token`, { response: response });
    throw new Error(`Failed to obtain token from ${tokenUrl}: ${response.status} ${response.statusText}`);
  }

  const data = await response.json();

  return data.access_token;
}

export async function getClientAccessToken(afnemer: Afnemer): Promise<string> {
  const brpApiRealm = oauthConfig.brpApiRealm;

  const params = new URLSearchParams();
  params.append('grant_type', 'client_credentials');
  params.append('client_id', afnemer.aanduiding);
  params.append('client_secret', afnemer.clientSecret!);
  params.append('scope', afnemer.oin!);
  params.append('resourceServer', 'ResourceServer02');

  return await getAccessToken(params, brpApiRealm.accessTokenUrl);
}

async function getAdminAccessToken(): Promise<string> {
  const masterRealm = oauthConfig.masterRealm;

  const params = new URLSearchParams();
  params.append('grant_type', 'password');
  params.append('client_id', 'admin-cli');
  params.append('username', masterRealm.username);
  params.append('password', masterRealm.password);

  return await getAccessToken(params, masterRealm.accessTokenUrl);
}

export function generateClientScopeJSON(scopeName: string): any {
  return {
    name: scopeName,
    protocol: 'openid-connect',
    attributes: {
      'include.in.token.scope': 'true',
      'display.on.consent.screen': 'false',
    },
  };
}

async function findClientScopeIdByName(adminToken: string, scopeName: string): Promise<string | undefined> {
  const response = await fetch(`${oauthConfig.brpApiRealm.adminBaseUrl}/client-scopes`, {
    method: 'GET',
    headers: { Authorization: `Bearer ${adminToken}` },
  });

  if (!response.ok) {
    logger.error('Failed to list client scopes when resolving existing scope', { status: response.status, statusText: response.statusText });
    throw new Error(`Failed to list client scopes: ${response.status} ${response.statusText}`);
  }

  const scopes = await response.json();
  const found = (scopes || []).find((s: any) => s.name === scopeName);
  return found?.id;
}

async function createClientScope(adminToken: string, scopeName: string): Promise<string> {
  const response = await fetch(`${oauthConfig.brpApiRealm.adminBaseUrl}/client-scopes`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${adminToken}`,
    },
    body: JSON.stringify(generateClientScopeJSON(scopeName)),
  });

  logger.debug(`create client scope '${scopeName}'`, { response: response });

  if (response.ok) {
    return response.headers.get('Location')!.split('/').pop()!;
  }

  if (response.status === 409) {
    logger.info(`Client scope '${scopeName}' already exists, fetching existing id`);
    const existingId = await findClientScopeIdByName(adminToken, scopeName);
    if (existingId) return existingId;
  }

  throw new Error(`Failed to create client scope '${scopeName}': ${response.status} ${response.statusText}`);
}

export function generateClientJSON(clientId: string, clientSecret: string): any {
  return {
    clientId: clientId,
    secret: clientSecret,
    enabled: true,
    clientAuthenticatorType: 'client-secret',
    standardFlowEnabled: false,
    implicitFlowEnabled: false,
    directAccessGrantsEnabled: false,
    serviceAccountsEnabled: true,
    publicClient: false,
    protocol: 'openid-connect',
    attributes: {
      'access.token.lifespan': '300',
      'oauth2.device.authorization.grant.enabled': 'false',
      'oidc.ciba.grant.enabled': 'false',
    },
  };
}

async function findClientIdByClientId(adminToken: string, clientId: string): Promise<string | undefined> {
  const response = await fetch(`${oauthConfig.brpApiRealm.adminBaseUrl}/clients?clientId=${encodeURIComponent(clientId)}`, {
    method: 'GET',
    headers: { Authorization: `Bearer ${adminToken}` },
  });

  if (!response.ok) {
    logger.error('Failed to fetch client when resolving existing client', { status: response.status, statusText: response.statusText });
    throw new Error(`Failed to fetch client for clientId '${clientId}': ${response.status} ${response.statusText}`);
  }

  const clients = await response.json();
  return clients[0]?.id;
}

async function createClient(adminToken: string, clientId: string, clientSecret: string): Promise<string> {
  const response = await fetch(`${oauthConfig.brpApiRealm.adminBaseUrl}/clients`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${adminToken}`,
    },
    body: JSON.stringify(generateClientJSON(clientId, clientSecret)),
  });

  logger.debug(`create client '${clientId}'`, { response: response });

  if (response.ok) {
    return response.headers.get('Location')!.split('/').pop()!;
  }

  if (response.status === 409) {
    logger.warn(`Client '${clientId}' already exists, fetching existing id`);
    const existingId = await findClientIdByClientId(adminToken, clientId);
    if (existingId) return existingId;
  }

  throw new Error(`Failed to create client '${clientId}': ${response.status} ${response.statusText}`);
}

export function generateProtocollMapperJSON(oin: string, afnemerID: string, gemeenteCode?: string): any {
  return {
    name: 'claims-mapper',
    protocol: 'openid-connect',
    protocolMapper: 'oidc-hardcoded-claim-mapper',
    consentRequired: false,
    config: {
      'claim.name': 'claims',
      'claim.value': `["OIN=${oin}","afnemerID=${afnemerID}"${gemeenteCode ? `,"gemeenteCode=${gemeenteCode}"` : ''}]`,
      'jsonType.label': 'JSON',
      'userinfo.token.claim': 'true',
      'id.token.claim': 'true',
      'access.token.claim': 'true',
    },
  };
}

async function addProtocolMapperToClient(
  adminToken: string,
  clientUuid: string,
  oin: string,
  afnemerID: string,
  gemeenteCode?: string
): Promise<void> {
  const response = await fetch(`${oauthConfig.brpApiRealm.adminBaseUrl}/clients/${clientUuid}/protocol-mappers/models`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${adminToken}`,
    },
    body: JSON.stringify(generateProtocollMapperJSON(oin, afnemerID, gemeenteCode)),
  });

  logger.debug(`add protocol mapper to client '${clientUuid}', oin='${oin}', afnemerID='${afnemerID}', gemeenteCode='${gemeenteCode}'`, {
    response,
  });

  if (!response.ok) {
    throw new Error(`Failed to add protocol mapper to client '${clientUuid}': ${response.status} ${response.statusText}`);
  }
}

async function addOptionalClientScopeToClient(adminToken: string, clientUuid: string, scopeUuid: string): Promise<void> {
  const response = await fetch(`${oauthConfig.brpApiRealm.adminBaseUrl}/clients/${clientUuid}/optional-client-scopes/${scopeUuid}`, {
    method: 'PUT',
    headers: {
      Authorization: `Bearer ${adminToken}`,
    },
  });

  logger.debug(`add optional client scope '${scopeUuid}' to client '${clientUuid}'`, { response: response });

  if (!response.ok) {
    throw new Error(`Failed to add optional client scope '${scopeUuid}' to client '${clientUuid}': ${response.status} ${response.statusText}`);
  }
}

export async function setupClient(afnemer: Afnemer): Promise<void> {
  logger.debug('Setting up client', { afnemer: afnemer });

  const adminToken = await getAdminAccessToken();

  if (!afnemer.oin) {
    afnemer.oin = '000000099000000010000';
  }
  if (!afnemer.afnemerId) {
    afnemer.afnemerId = Math.random().toString(36).substring(2, 15);
  }
  if (!afnemer.clientSecret) {
    afnemer.clientSecret = 'secret';
  }

  afnemer.idpScopeId = await createClientScope(adminToken, afnemer.oin!);

  afnemer.idpId = await createClient(adminToken, afnemer.aanduiding, afnemer.clientSecret!);

  await addProtocolMapperToClient(adminToken, afnemer.idpId, afnemer.oin!, afnemer.afnemerId!, afnemer.gemeenteCode);
  await addOptionalClientScopeToClient(adminToken, afnemer.idpId, afnemer.idpScopeId);
}

async function deleteClient(adminToken: string, clientUuid: string): Promise<void> {
  const response = await fetch(`${oauthConfig.brpApiRealm.adminBaseUrl}/clients/${clientUuid}`, {
    method: 'DELETE',
    headers: {
      Authorization: `Bearer ${adminToken}`,
    },
  });

  if (!response.ok) {
    throw new Error(`Failed to delete client '${clientUuid}': ${response.status} ${response.statusText}`);
  }
}

async function deleteClientScopes(adminToken: string, scopeUuid: string): Promise<void> {
  const response = await fetch(`${oauthConfig.brpApiRealm.adminBaseUrl}/client-scopes/${scopeUuid}`, {
    method: 'DELETE',
    headers: {
      Authorization: `Bearer ${adminToken}`,
    },
  });

  if (response.status === 404) {
    logger.debug(`Client scope '${scopeUuid}' not found when deleting - is this client scope already deleted?`);
    return;
  }

  if (!response.ok) {
    throw new Error(`Failed to delete client scope '${scopeUuid}': ${response.status} ${response.statusText}`);
  }
}

export async function tearDownClient(afnemer: Afnemer): Promise<void> {
  logger.debug('Tearing down client', afnemer);

  const adminToken = await getAdminAccessToken();

  await deleteClient(adminToken, afnemer.idpId!);
  await deleteClientScopes(adminToken, afnemer.idpScopeId!);
}

export async function fetchClientVoorAfnemer(afnemer: Afnemer): Promise<any> {
  const adminToken = await getAdminAccessToken();

  const response = await fetch(`${oauthConfig.brpApiRealm.adminBaseUrl}/clients?clientId=${afnemer.aanduiding}`, {
    method: 'GET',
    headers: {
      Authorization: `Bearer ${adminToken}`,
    },
  });

  if (!response.ok) {
    throw new Error(`Failed to fetch client for afnemer '${afnemer.aanduiding}': ${response.status} ${response.statusText}`);
  }

  const clients = await response.json();
  return clients[0];
}
