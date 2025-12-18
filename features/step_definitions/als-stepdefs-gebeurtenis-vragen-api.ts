import { When } from '@cucumber/cucumber';
import { getOudsteOngelezenGebeurtenisVoorAfnemer } from './support/gebeurtenissen-vragen-api-helpers';

When('de oudste ongelezen gebeurtenis wordt gevraagd door afnemer {string}', async function (afnemerAanduiding: string) {
    const gebeurtenis = await getOudsteOngelezenGebeurtenisVoorAfnemer(afnemerAanduiding);
    this.result = gebeurtenis;
});
