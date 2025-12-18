import { logger } from './logger';

export async function getOudsteOngelezenGebeurtenisVoorAfnemer(afnemerAanduiding: string): Promise<any> {
    const response = await fetch(`${process.env.GEBEURTENISSEN_BASE_URL}/personen/gebeurtenissen`, {
        method: 'GET',
        headers: {
            'Accept': 'application/json',
        }
    });

    logger.debug(`getOudsteOngelezenGebeurtenisVoorAfnemer ${afnemerAanduiding}`, { response: response });

    return await response.json();
};
