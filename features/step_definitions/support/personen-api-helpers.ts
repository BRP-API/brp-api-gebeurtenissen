import {Afnemer} from '../brp/afnemer-entity';
import {Persoon} from '../brp/persoon-entity';
import {logger} from './logger';
import {getClientAccessToken} from './oauth-helpers';
import {toIsoDate} from './date-utils';

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

export async function raadpleegMetBurgerservicenummer(
  afnemer: Afnemer,
  persoon: Persoon,
  fields: Array<string>,
) {
  const accessToken = afnemer ? await getClientAccessToken(afnemer) : '';

  const requestBody = {
    type: 'RaadpleegMetBurgerservicenummer',
    fields: fields,
    burgerservicenummer: [persoon.burger_service_nr],
  };

  const response = await fetch(
    `${process.env.PERSONEN_BASE_URL}/haalcentraal/api/brp/personen`,
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
    `/haalcentraal/api/brp/personen ${JSON.stringify(requestBody)} >>> status: ${response.status}`,
  );

  return {
    statusCode: response.status,
    body: await parseResponseBody(response),
  };
}

export async function raadpleegVerblijfplaatshistorieMetPeriode(
  afnemer: Afnemer,
  persoon: Persoon,
  datumVan: string,
  datumTot: string,
) {
  const accessToken = afnemer ? await getClientAccessToken(afnemer) : '';

  const requestBody = {
    type: 'RaadpleegMetPeriode',
    burgerservicenummer: persoon.burger_service_nr,
    datumVan: toIsoDate(datumVan),
    datumTot: toIsoDate(datumTot),
  };

  const response = await fetch(
    `${process.env.HISTORIE_BASE_URL}/haalcentraal/api/brphistorie/verblijfplaatshistorie`,
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
    `/haalcentraal/api/brphistorie/verblijfplaatshistorie ${JSON.stringify(requestBody)} >>> status: ${response.status}`,
  );

  return {
    statusCode: response.status,
    body: await parseResponseBody(response),
  };
}
