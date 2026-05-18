import { Afnemer } from "../brp/afnemer-entity";
import { Persoon } from "../brp/persoon-entity";
import { logger } from "./logger";
import { getClientAccessToken } from "./oauth-helpers";

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

export async function registreerAbonneeVoorAfnemer(afnemer: Afnemer, abonneeNaam: string): Promise<any> {
    const accessToken = afnemer ? await getClientAccessToken(afnemer) : '';

    const response = await fetch(`${process.env.ABONNEMENT_BASE_URL}/api/brp/abonnees`, {
        method: 'POST',
        headers: {
            'Authorization': `Bearer ${accessToken}`,
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            abonneeNaam: abonneeNaam
        })
    });


    logger.debug(`registreerAbonneeVoorAfnemer afnemer: '${afnemer?.aanduiding}', abonnee: '${abonneeNaam}'`, {response: response });

    if (response.status === 201) {
        afnemer.abonnees.push(abonneeNaam);
    }

    return await parseResponseBody(response);
}

export async function deregistreerAbonneeVoorAfnemer(afnemer: Afnemer, abonneeNaam: string): Promise<any> {
    const accessToken = afnemer ? await getClientAccessToken(afnemer) : '';

    const response = await fetch(`${process.env.ABONNEMENT_BASE_URL}/api/brp/abonnees/${abonneeNaam}`, {
        method: 'DELETE',
        headers: {
            'Authorization': `Bearer ${accessToken}`
        }
    });

    logger.debug(`deregistreerAbonneeVoorAfnemer afnemer: '${afnemer?.aanduiding}', abonnee: '${abonneeNaam}'`, {response: response });

    if(response.status === 204) {
        const index = afnemer.abonnees.indexOf(abonneeNaam);
        if (index > -1) {
            afnemer.abonnees.splice(index, 1);
        }
    }

    return await parseResponseBody(response);
}

export async function raadpleegAbonneesVoorAfnemer(afnemer: Afnemer): Promise<any> {
    const accessToken = afnemer ? await getClientAccessToken(afnemer) : '';

    const response = await fetch(`${process.env.ABONNEMENT_BASE_URL}/api/brp/abonnees`, {
        method: 'GET',
        headers: {
            'Authorization': `Bearer ${accessToken}`
        }
    });

    logger.debug(`raadpleegAbonneesVoorAfnemer afnemer: '${afnemer?.aanduiding}'`, {response: response });

    return await parseResponseBody(response);
}

export async function abonneerOpGebeurtenistypeVanPersoon(afnemer: Afnemer, abonneeNaam: string, gebeurtenistype: string, persoon: Persoon): Promise<any> {
    const accessToken = afnemer ? await getClientAccessToken(afnemer) : '';

    const response = await fetch(`${process.env.ABONNEMENT_BASE_URL}/api/brp/abonnees/${abonneeNaam}/abonnementen`, {
        method: 'POST',
        headers: {
            'Authorization': `Bearer ${accessToken}`,
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            type: "AbonneerOpGebeurtenisTypeVanPersoon",
            gebeurtenisType: gebeurtenistype,
            burgerservicenummer: persoon.burger_service_nr
        })
    });

    logger.debug(`abonneerOpGebeurtenistypeVanPersoon afnemer: '${afnemer?.aanduiding}', abonnee: '${abonneeNaam}', gebeurtenistype: '${gebeurtenistype}', persoon: '${persoon.burger_service_nr}'`, {response: response });

    return await parseResponseBody(response);
}

export async function zegOpAbonnementOpGebeurtenistypeVanPersoon(afnemer: Afnemer, abonneeNaam: string, gebeurtenistype: string, persoon: Persoon): Promise<any> {
    const accessToken = afnemer ? await getClientAccessToken(afnemer) : '';

    const response = await fetch(`${process.env.ABONNEMENT_BASE_URL}/api/brp/abonnees/${abonneeNaam}/abonnementen`, {
        method: 'POST',
        headers: {
            'Authorization': `Bearer ${accessToken}`,
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            type: "ZegOpAbonnementOpGebeurtenisTypeVanPersoon",
            gebeurtenisType: gebeurtenistype,
            burgerservicenummer: persoon.burger_service_nr
        })
    });

    logger.debug(`zegOpAbonnementOpGebeurtenistypeVanPersoon afnemer: '${afnemer?.aanduiding}', abonnee: '${abonneeNaam}', gebeurtenistype: '${gebeurtenistype}', persoon: '${persoon.burger_service_nr}'`, {response: response });

    return await parseResponseBody(response);
}

export async function zegOpAbonnementenOpPersoon(afnemer: Afnemer, abonneeNaam: string, persoon: Persoon): Promise<any> {
    const accessToken = afnemer ? await getClientAccessToken(afnemer) : '';

    const response = await fetch(`${process.env.ABONNEMENT_BASE_URL}/api/brp/abonnees/${abonneeNaam}/abonnementen`, {
        method: 'POST',
        headers: {
            'Authorization': `Bearer ${accessToken}`,
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            type: "ZegOpAbonnementenOpPersoon",
            burgerservicenummer: persoon.burger_service_nr
        })
    });

    logger.debug(`zegOpAbonnementenOpPersoon afnemer: '${afnemer?.aanduiding}', abonnee: '${abonneeNaam}', persoon: '${persoon.burger_service_nr}'`, {response: response });

    return await parseResponseBody(response);
}
