import { When } from '@cucumber/cucumber';
import { registreerAlsAbonnee } from './support/abonnement-api-helpers';

When('afnemer {string} zich registreert als abonnee', async function (afnemerAanduiding: string) {
    this.context.result = await registreerAlsAbonnee(this.context.afnemers[afnemerAanduiding]);
});

When('een niet-geauthenticeerde gebruiker zich registreert als abonnee', async function () {
    this.context.result = await registreerAlsAbonnee();
});
