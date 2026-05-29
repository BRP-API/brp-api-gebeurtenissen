import { When } from '@cucumber/cucumber';
import { raadpleegGebeurtenissenVoorAbonnee } from './support/gebeurtenissen-api-helpers';
import { AfnemerFactory } from './support/afnemer-factory';

When('gebeurtenissen worden gevraagd door abonnee {string} van afnemer {string}', async function (abonneeNaam: string, afnemerAanduiding: string) {
    const afnemer = await AfnemerFactory.create(this.context, afnemerAanduiding);

    this.result = await raadpleegGebeurtenissenVoorAbonnee(afnemer, abonneeNaam);
});
