import {When} from '@cucumber/cucumber';
import {registreerAbonnee, abonneerOpgebeurtenisTypeVanPersoon} from './support/abonnement-api-helpers';
import {AbonneerOpgebeurtenisTypeVanPersoonCommand, RegistreerAbonneeCommand} from "./brp-api/commands";
import {parseResponse} from "./support/response-helper";

When('afnemer {string} zich registreert als abonnee', async function (afnemerAanduiding: string) {
    this.result = await registreerAbonnee(this.context.afnemers[afnemerAanduiding]);
});

When('een niet-geauthenticeerde gebruiker zich registreert als abonnee', async function () {
    this.result = await registreerAbonnee();
});

When('de afnemer {string} zich registreert als abonnee {string}', async function (afnemerAanduiding: string, abonneeNaam: string) {
    const afnemer = this.context.afnemers[afnemerAanduiding];
    const command = new RegistreerAbonneeCommand(abonneeNaam);

    const response = await registreerAbonnee(afnemer, command);

    const parsedResponse = await parseResponse(response);
    this.result = parsedResponse.body || null;
});

When('de abonnee {string} van afnemer {string} zich abonneert op de {string} gebeurtenissen van {string}', async function (abonneeNaam: string, afnemerAanduiding: string, gebeurtenisTypeAanduiding: string, persoonAanduiding: string) {
    const gebeurtenisType = this.context.gebeurtenisTypes[gebeurtenisTypeAanduiding];
    const persoon = this.context.personen[persoonAanduiding];
    const command = new AbonneerOpgebeurtenisTypeVanPersoonCommand( abonneeNaam, gebeurtenisType, persoon.burger_service_nr);
    const afnemer = this.context.afnemers[afnemerAanduiding];

    const response = await abonneerOpgebeurtenisTypeVanPersoon(afnemer, command);

    const parsedResponse = await parseResponse(response);
    this.result = parsedResponse.body || null;
});