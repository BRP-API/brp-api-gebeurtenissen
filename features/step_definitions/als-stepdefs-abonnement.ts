import { When } from '@cucumber/cucumber';
import { registreerAbonnee } from './support/abonnement-api-helpers';
import { RegistreerAbonneeCommand } from "./brp-api/commands";

When('afnemer {string} zich registreert als abonnee', async function (afnemerAanduiding: string) {
    this.context.result = await registreerAbonnee(this.context.afnemers[afnemerAanduiding]);
});

When('een niet-geauthenticeerde gebruiker zich registreert als abonnee', async function () {
    this.context.result = await registreerAbonnee();
});

When('de afnemer {string} zich registreert als abonnee {string}', async function (afnemerAanduiding: string, abonneeNaam: string) {
    this.context.result = await registreerAbonnee(this.context.afnemers[afnemerAanduiding], new RegistreerAbonneeCommand(abonneeNaam));
});

When('de abonnee {string} van afnemer {string} zich abonneert op de {string} gebeurtenissen van {string}', function () {
    throw new Error('Not implemented yet');
});