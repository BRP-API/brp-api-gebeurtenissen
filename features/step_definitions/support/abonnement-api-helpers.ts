import { Afnemer } from "../brp/afnemer-entity";
import { logger } from "./logger";
import { getClientAccessToken } from "./oauth-helpers";

export async function registreerAlsAbonnee(afnemer?: Afnemer): Promise<any> {
    const accessToken = afnemer ? await getClientAccessToken(afnemer) : '';

    const response = await fetch(`${process.env.ABONNEMENT_BASE_URL}/abonnees`, {
        method: 'POST',
        headers: {
            'Authorization': `Bearer ${accessToken}`
        },
    });

    logger.debug(`registreerAlsAbonnee '${afnemer?.aanduiding}'`, {response: response });

    return await response.json();
}
