import { Afnemer } from "../brp/afnemer-entity";
import { logger } from "./logger";
import { getClientAccessToken } from "./oauth-helpers";
import * as dotenv from "dotenv";

dotenv.config();

export async function registreerAlsAbonnee(afnemer?: Afnemer): Promise<any> {
    logger.info(`Registreer afnemer '${afnemer?.aanduiding}' als abonnee`);

    const accessToken = afnemer ? await getClientAccessToken(afnemer) : '';

    const response = await fetch(`${process.env.ABONNEMENT_BASE_URL}/abonnees`, {
        method: 'POST',
        headers: {
            'Authorization': `Bearer ${accessToken}`
        },
    });

    return await response.json();
}
