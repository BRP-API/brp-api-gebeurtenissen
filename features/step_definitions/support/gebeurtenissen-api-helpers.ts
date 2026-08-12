import {Afnemer} from '../brp/afnemer-entity.js';
import {Persoon} from '../brp/persoon-entity.js';
import {logger} from './logger.js';
import {getClientAccessToken} from './oauth-helpers.js';
import {DateType} from './date-utils.js';

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

    const deGebeurtenis = alleGebeurtenissen.body.gebeurtenissen.find(
      (geb: any) => geb.data.burgerservicenummer === persoon.burger_service_nr,
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

  if (limit !== null && limit !== undefined) {
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

  return {body: await response.json(), statusCode: response.status};
}

export async function publiceerGebeurtenis(
  gebeurtenistype: string,
  persoon: Persoon,
  datumType: DateType = DateType.VolledigeDatum,
) {
  const gebeurtenisDatum = (datumType1: DateType) => {
    switch (datumType1) {
      case DateType.JaarDatum:
        return '20260000';
      case DateType.JaarMaandDatum:
        return '20260500';
      case DateType.VolledigeDatum:
        return '20260526';
    }
  };
  const data: any = {
    c01: {
      e0110: `${persoon.a_nr}`,
    },
  };

  switch (gebeurtenistype) {
    case 'nl.brp.verhuisd.intergemeentelijk':
      data.c08 = {
        e1030: gebeurtenisDatum(datumType),
        e1180: '0935010000092253',
      };
      break;
    case 'nl.brp.verhuisd.naar-buitenland':
      data.c08 = {
        e1310: '5015',
        e1320: gebeurtenisDatum(datumType),
        e1330: 'Nordmarksvej 9',
        e1340: '7190',
        e1350: 'Billund',
      };
      break;
    case 'nl.brp.overleden':
      data.c06 = {
        e0810: gebeurtenisDatum(datumType),
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
  return {body: await response.json(), statusCode: response.status};
}

export function maakGebeurtenis(
  gebeurtenistype: string,
  persoon: Persoon,
  datumType: DateType = DateType.VolledigeDatum,
) {
  const data: any = {
    burgerservicenummer: persoon.burger_service_nr,
  };

  const datum = (datumType1: DateType) => {
    switch (datumType1) {
      case DateType.VolledigeDatum:
        return {
          type: 'Datum',
          datum: '2026-05-26',
          langFormaat: '26 mei 2026',
        };
      case DateType.JaarDatum:
        return {
          type: 'JaarDatum',
          jaar: 2026,
          langFormaat: '2026',
        };
      case DateType.JaarMaandDatum:
        return {
          type: 'JaarMaandDatum',
          maand: 5,
          jaar: 2026,
          langFormaat: 'mei 2026',
        };
    }
  };

  console.log(datum(datumType));

  switch (gebeurtenistype) {
    case 'nl.brp.verhuisd.intergemeentelijk':
      data.verblijfplaats = {
        datumVan: datum(datumType),
      };
      break;
    case 'nl.brp.verhuisd.naar-buitenland':
      data.verblijfplaats = {
        datumVan: datum(datumType),
      };
      break;
    case 'nl.brp.overleden':
      data.overlijden = {
        datum: datum(datumType),
      };
  }

  return {
    type: gebeurtenistype,
    data: data,
    source: 'brp-api-gebeurtenissen',
    specversion: '1.0',
  };
}
