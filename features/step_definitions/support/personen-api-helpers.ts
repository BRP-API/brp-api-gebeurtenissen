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

  return await parseResponseBody(response);
}
