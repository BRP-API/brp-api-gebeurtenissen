import {Afnemer} from '../brp/afnemer-entity';
import {Persoon} from '../brp/persoon-entity';
import {logger} from './logger';
import {getClientAccessToken} from './oauth-helpers';

export async function raadpleegGebeurtenissenVoorAbonnee(
  afnemer: Afnemer,
  abonneeNaam: string,
  limit?: bigint,
  persoon?: Persoon,
  cursor?: string,
): Promise<any> {
  const accessToken = afnemer ? await getClientAccessToken(afnemer) : '';

  const uriParams = [];

  if (persoon) {
    // haal eerst alle gebeurtenissen op om de uuid van cursor op te zoeken
    const alleGebeurtenissen = await raadpleegGebeurtenissenVoorAbonnee(
      afnemer,
      abonneeNaam,
    );

    const deGebeurtenis = alleGebeurtenissen.gebeurtenissen.find(
      (geb: any) => geb.burgerservicenummer === persoon.burger_service_nr,
    );
    if (deGebeurtenis) {
      uriParams.push(`cursor=${deGebeurtenis.id}`);
    } else {
      logger.warn(
        `Geen gebeurtenis gevonden met burgerservicenummer ${persoon.burger_service_nr}`,
        alleGebeurtenissen,
      );
      return false;
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
    `${process.env.GEBEURTENISSEN_BASE_URL}/api/brp/abonnees/${abonneeNaam}/gebeurtenissen${uriParamsString}`,
    {
      method: 'GET',
      headers: {
        Authorization: `Bearer ${accessToken}`,
      },
    },
  );

  logger.debug(
    `raadpleegGebeurtenissenVoorAbonnee afnemer: '${afnemer?.aanduiding}', abonneeNaam: ${abonneeNaam}`,
    {response: response},
  );
  logger.info(
    `GET /api/brp/abonnees/${abonneeNaam}/gebeurtenissen${uriParamsString} >>> status: ${response.status}`,
  );

  return await response.json();
}

export async function publiceerGebeurtenis(
  gebeurtenistype: string,
  persoon: Persoon,
) {
  const data: any = {
    c01: {
      e0110: `${persoon.a_nr}`,
    },
  };

  switch (gebeurtenistype) {
    case 'nl.brp.verhuisd.intergemeentelijk':
      data.c08 = {
        e1030: '20260526',
        e1180: '0935010000092253',
      };
      break;
    case 'nl.brp.verhuisd.naar-buitenland':
      data.c08 = {
        e1310: '5015',
        e1320: '20260526',
        e1330: 'Nordmarksvej 9',
        e1340: '7190',
        e1350: 'Billund',
      };
      break;
    case 'nl.brp.overleden':
      data.c06 = {
        e0810: '20260526',
        e0820: '0518',
        e0830: '6030',
      };
  }

  const requestBody: any = {
    type: gebeurtenistype,
    data: data,
    metadata: [
      {
        naam: 'activiteitId',
        waarde:
          `publiceerGebeurtenis-${persoon.geslachts_naam}-` +
          Math.floor(Math.random() * 10000).toString(),
      },
    ],
  };

  const response = await fetch(
    `${process.env.GEBEURTENISSEN_BASE_URL}/personen/gebeurtenissen`,
    {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(requestBody),
    },
  );

  logger.debug(
    `publiceerGebeurtenis afnemer: type: ${gebeurtenistype}, requestBody: ${requestBody}`,
    {response: response},
  );
  logger.info(
    `POST /personen/gebeurtenissen >>> status: ${response.status}`,
    requestBody,
  );
}

export function maakGebeurtenis(gebeurtenistype: string, persoon: Persoon) {
  const data: any = {
    burgerservicenummer: persoon.burger_service_nr,
  };

  switch (gebeurtenistype) {
    case 'nl.brp.verhuisd.intergemeentelijk':
      data.verblijfplaats = {
        datumVan: {
          type: 'Datum',
          datum: '2026-05-26',
          langFormaat: '26 mei 2026',
        },
      };
      break;
    case 'nl.brp.verhuisd.naar-buitenland':
      data.verblijfplaats = {
        datumVan: {
          type: 'Datum',
          datum: '2026-05-26',
          langFormaat: '26 mei 2026',
        },
      };
      break;
    case 'nl.brp.overleden':
      data.overlijden = {
        datum: {
          type: 'Datum',
          datum: '2026-05-26',
          langFormaat: '26 mei 2026',
        },
      };
  }

  return {type: gebeurtenistype, data: data};
}
