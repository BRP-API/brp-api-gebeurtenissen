import {Afnemer} from '../brp/afnemer-entity';
import {Persoon} from '../brp/persoon-entity';
import {logger} from './logger';
import {getClientAccessToken} from './oauth-helpers';

async function parseResponseBody(response: Response): Promise<any> {
  const responseText = await response.text();

  if (!responseText) {
    return null;
  }

  try {
    return JSON.parse(responseText);
  } catch {
    return responseText;
  }
}

export async function registreerAbonneeVoorAfnemer(
  afnemer: Afnemer,
  abonneeNaam?: string,
): Promise<any> {
  const accessToken = afnemer ? await getClientAccessToken(afnemer) : '';

  const requestBody = abonneeNaam ? {naam: abonneeNaam} : {};

  const response = await fetch(
    `${process.env.GEBEURTENISSEN_BASE_URL}/api/brp/abonnees`,
    {
      method: 'POST',
      headers: {
        Authorization: `Bearer ${accessToken}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(requestBody),
    },
  );

  logger.debug(
    `registreerAbonneeVoorAfnemer afnemer: '${afnemer?.aanduiding}', abonnee: '${abonneeNaam}'`,
    {response: response},
  );
  logger.info(
    `/api/brp/abonnees ${JSON.stringify(requestBody)} >>> status: ${response.status}`,
  );

  if (response.status === 201 && abonneeNaam) {
    afnemer.abonnees.push(abonneeNaam);
  }

  return {
    statusCode: response.status,
    body: await parseResponseBody(response),
  };
}

export async function deregistreerAbonneeVoorAfnemer(
  afnemer: Afnemer,
  abonneeNaam: string,
): Promise<any> {
  const accessToken = afnemer ? await getClientAccessToken(afnemer) : '';

  const response = await fetch(
    `${process.env.GEBEURTENISSEN_BASE_URL}/api/brp/abonnees/${abonneeNaam}`,
    {
      method: 'DELETE',
      headers: {
        Authorization: `Bearer ${accessToken}`,
      },
    },
  );

  logger.debug(
    `deregistreerAbonneeVoorAfnemer afnemer: '${afnemer?.aanduiding}', abonnee: '${abonneeNaam}'`,
    {response: response},
  );

  if (response.status === 204) {
    afnemer.abonnees = afnemer.abonnees.filter(a => a !== abonneeNaam);
  }

  return {
    statusCode: response.status,
    body: await parseResponseBody(response),
  };
}

export async function raadpleegAbonneesVoorAfnemer(
  afnemer: Afnemer,
): Promise<any> {
  const accessToken = afnemer ? await getClientAccessToken(afnemer) : '';

  const response = await fetch(
    `${process.env.GEBEURTENISSEN_BASE_URL}/api/brp/abonnees`,
    {
      method: 'GET',
      headers: {
        Authorization: `Bearer ${accessToken}`,
      },
    },
  );

  logger.debug(
    `raadpleegAbonneesVoorAfnemer afnemer: '${afnemer?.aanduiding}'`,
    {response: response},
  );

  return {
    statusCode: response.status,
    body: await parseResponseBody(response),
  };
}

export async function voegGroepToeBijAbonnee(
  afnemer: Afnemer,
  abonneeNaam: string,
  groepNaam?: string,
): Promise<any> {
  const accessToken = afnemer ? await getClientAccessToken(afnemer) : '';

  const requestBody = groepNaam ? {naam: groepNaam} : {};

  const response = await fetch(
    `${process.env.GEBEURTENISSEN_BASE_URL}/api/brp/abonnees/${abonneeNaam}/groepen`,
    {
      method: 'POST',
      headers: {
        Authorization: `Bearer ${accessToken}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(requestBody),
    },
  );

  logger.debug(
    `voegGroepToeBijAbonnee afnemer: '${afnemer?.aanduiding}', abonnee: '${abonneeNaam}', groepNaam: '${groepNaam}'`,
    {response: response},
  );

  return {
    statusCode: response.status,
    body: await parseResponseBody(response),
  };
}

export async function verwijderGroepVanAbonnee(
  afnemer: Afnemer,
  abonneeNaam: string,
  groepNaam?: string,
): Promise<any> {
  const accessToken = afnemer ? await getClientAccessToken(afnemer) : '';

  const response = await fetch(
    `${process.env.GEBEURTENISSEN_BASE_URL}/api/brp/abonnees/${abonneeNaam}/groepen/${groepNaam}`,
    {
      method: 'DELETE',
      headers: {
        Authorization: `Bearer ${accessToken}`,
      },
    },
  );

  logger.debug(
    `verwijderGroepVanAbonnee afnemer: '${afnemer?.aanduiding}', abonnee: '${abonneeNaam}', groepNaam: '${groepNaam}'`,
    {response: response},
  );

  return {
    statusCode: response.status,
    body: await parseResponseBody(response),
  };
}

export async function raadpleegGroepenVanAbonnee(
  afnemer: Afnemer,
  abonneeNaam: string,
): Promise<any> {
  const accessToken = afnemer ? await getClientAccessToken(afnemer) : '';

  const response = await fetch(
    `${process.env.GEBEURTENISSEN_BASE_URL}/api/brp/abonnees/${abonneeNaam}/groepen`,
    {
      method: 'GET',
      headers: {
        Authorization: `Bearer ${accessToken}`,
      },
    },
  );

  logger.debug(
    `raadpleegGroepenVanAbonnee afnemer: '${afnemer?.aanduiding}', abonneeNaam: '${abonneeNaam}'`,
    {response: response},
  );

  return {
    statusCode: response.status,
    body: await parseResponseBody(response),
  };
}

export async function voegGebeurtenistypeToeAanGroep(
  afnemer: Afnemer,
  abonneeNaam: string,
  groepNaam: string,
  gebeurtenistype: string,
): Promise<any> {
  const accessToken = afnemer ? await getClientAccessToken(afnemer) : '';

  const requestBody = {
    gebeurtenistype: gebeurtenistype,
  };

  const response = await fetch(
    `${process.env.GEBEURTENISSEN_BASE_URL}/api/brp/abonnees/${abonneeNaam}/groepen/${groepNaam}/gebeurtenistypes`,
    {
      method: 'POST',
      headers: {
        Authorization: `Bearer ${accessToken}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(requestBody),
    },
  );

  logger.debug(
    `voegGebeurtenistypeToeAanGroep afnemer: '${afnemer?.aanduiding}', abonnee: '${abonneeNaam}', groepNaam: '${groepNaam}', gebeurtenistype: '${gebeurtenistype}'`,
    {response: response},
  );

  return {
    statusCode: response.status,
    body: await parseResponseBody(response),
  };
}

export async function verwijderGebeurtenistypeUitGroep(
  afnemer: Afnemer,
  abonneeNaam: string,
  groepNaam: string,
  gebeurtenistype: string,
): Promise<any> {
  const accessToken = afnemer ? await getClientAccessToken(afnemer) : '';

  const response = await fetch(
    `${process.env.GEBEURTENISSEN_BASE_URL}/api/brp/abonnees/${abonneeNaam}/groepen/${groepNaam}/gebeurtenistypes/${gebeurtenistype}`,
    {
      method: 'DELETE',
      headers: {
        Authorization: `Bearer ${accessToken}`,
      },
    },
  );

  logger.debug(
    `verwijderGebeurtenistypeUitGroep afnemer: '${afnemer?.aanduiding}', abonnee: '${abonneeNaam}', groepNaam: '${groepNaam}', gebeurtenistype: '${gebeurtenistype}'`,
    {response: response},
  );

  return {
    statusCode: response.status,
    body: await parseResponseBody(response),
  };
}

export async function raadpleegGebeurtenistypesInGroep(
  afnemer: Afnemer,
  abonneeNaam: string,
  groepNaam: string,
): Promise<any> {
  const accessToken = afnemer ? await getClientAccessToken(afnemer) : '';

  const response = await fetch(
    `${process.env.GEBEURTENISSEN_BASE_URL}/api/brp/abonnees/${abonneeNaam}/groepen/${groepNaam}/gebeurtenistypes`,
    {
      method: 'GET',
      headers: {
        Authorization: `Bearer ${accessToken}`,
      },
    },
  );

  logger.debug(
    `raadpleegGebeurtenistypesInGroep afnemer: '${afnemer?.aanduiding}', abonneeNaam: '${abonneeNaam}', groepNaam: '${groepNaam}'`,
    {response: response},
  );

  return {
    statusCode: response.status,
    body: await parseResponseBody(response),
  };
}

export async function abonneerPersoonOpGroep(
  afnemer: Afnemer,
  abonneeNaam: string,
  groepNaam: string,
  persoon: Persoon,
  type?: string,
): Promise<any> {
  const accessToken = afnemer ? await getClientAccessToken(afnemer) : '';

  const requestBody: any = {};
  if (type) {
    requestBody.type = type;
  }
  if (groepNaam !== '') {
    requestBody.groep = groepNaam;
  }
  if (persoon.burger_service_nr) {
    requestBody.burgerservicenummer = persoon.burger_service_nr;
  }

  const response = await fetch(
    `${process.env.GEBEURTENISSEN_BASE_URL}/api/brp/abonnees/${abonneeNaam}/abonnementen`,
    {
      method: 'POST',
      headers: {
        Authorization: `Bearer ${accessToken}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(requestBody),
    },
  );

  logger.debug(
    `abonneerPersoonOpGroep afnemer: '${afnemer?.aanduiding}', abonnee: '${abonneeNaam}', groep: '${groepNaam}', persoon: '${persoon.burger_service_nr}', type: '${type}'`,
    {response: response},
  );
  logger.info(
    `/api/brp/abonnees/${abonneeNaam}/abonnementen ${JSON.stringify(requestBody)} >>> status: ${response.status}`,
  );

  return {
    statusCode: response.status,
    body: await parseResponseBody(response),
  };
}

export async function raadpleegAbonnementen(
  afnemer: Afnemer,
  abonneeNaam: string,
  limit?: bigint,
  groepNaam?: string,
  persoon?: Persoon,
  cursor?: string,
): Promise<any> {
  const accessToken = afnemer ? await getClientAccessToken(afnemer) : '';

  const uriParams = [];

  if (persoon && groepNaam) {
    // haal eerst alle abonnementen op om de uuid van cursor op te zoeken
    const alleAbonnementen = await raadpleegAbonnementen(afnemer, abonneeNaam);

    const hetAbonnement = alleAbonnementen.abonnementen.find(
      (abo: any) =>
        abo.burgerservicenummer === persoon.burger_service_nr &&
        abo.groep === groepNaam,
    );
    if (hetAbonnement) {
      uriParams.push(`cursor=${hetAbonnement.id}`);
    }
  }

  if (cursor) {
    uriParams.push(`cursor=${cursor}`);
  }

  if (limit) {
    uriParams.push(`limit=${limit.toString()}`);
  }

  const uriParamsString = uriParams.length > 0 ? '?' + uriParams.join('&') : '';

  const response = await fetch(
    `${process.env.GEBEURTENISSEN_BASE_URL}/api/brp/abonnees/${abonneeNaam}/abonnementen${uriParamsString}`,
    {
      method: 'GET',
      headers: {
        Authorization: `Bearer ${accessToken}`,
      },
    },
  );

  logger.debug(
    `raadpleegAbonnementen afnemer: '${afnemer?.aanduiding}', abonneeNaam: ${abonneeNaam}`,
    {response: response},
  );
  logger.debug(
    `GET /api/brp/abonnees/${abonneeNaam}/abonnementen${uriParamsString} >>> status: ${response.status}`,
  );

  return {
    statusCode: response.status,
    body: await parseResponseBody(response),
  };
}

export async function zegOpAbonnementenOpPersoon(
  afnemer: Afnemer,
  abonneeNaam: string,
  persoon: Persoon,
): Promise<any> {
  const accessToken = afnemer ? await getClientAccessToken(afnemer) : '';

  const response = await fetch(
    `${process.env.GEBEURTENISSEN_BASE_URL}/api/brp/abonnees/${abonneeNaam}/abonnementen`,
    {
      method: 'POST',
      headers: {
        Authorization: `Bearer ${accessToken}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        type: 'ZegOpAbonnementenOpPersoon',
        burgerservicenummer: persoon.burger_service_nr,
      }),
    },
  );

  logger.debug(
    `zegOpAbonnementenOpPersoon afnemer: '${afnemer?.aanduiding}', abonnee: '${abonneeNaam}', persoon: '${persoon.burger_service_nr}'`,
    {response: response},
  );

  return {
    statusCode: response.status,
    body: await parseResponseBody(response),
  };
}
