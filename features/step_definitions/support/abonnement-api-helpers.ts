import { Afnemer } from "../brp/afnemer-entity";
import { logger } from "./logger";
import { getClientAccessToken } from "./oauth-helpers";
import { Command } from "../brp-api/commands";

export async function registreerAbonnee(afnemer?: Afnemer, command?: Command): Promise<any> {
    const accessToken = afnemer ? await getClientAccessToken(afnemer) : '';

    const response = await fetch(`${process.env.ABONNEMENT_BASE_URL}/abonnees`, {
        method: 'POST',
        headers: {
            'Authorization': `Bearer ${accessToken}`
        },
        body: JSON.stringify(command)
    });

    logger.debug(`registreerAbonnee '${afnemer?.aanduiding}'`, {response: response });

    return await response.json();
}

export async function abonneerOpgebeurtenisTypeVanPersoon(afnemer?: Afnemer, command?: Command): Promise<any> {
    const accessToken = afnemer ? await getClientAccessToken(afnemer) : '';

    const response = await fetch(`${process.env.ABONNEMENT_BASE_URL}/abonnees/mijn/abonnementen`, {
        method: 'POST',
        headers: {
            'Authorization': `Bearer ${accessToken}`
        },
        body: JSON.stringify(command)
    });

    logger.debug(`abonneerOpgebeurtenisTypeVanPersoon '${afnemer?.aanduiding}'`, {response: response });

    return await response.json();
}
