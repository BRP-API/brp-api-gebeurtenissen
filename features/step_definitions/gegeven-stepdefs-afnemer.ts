import { Given } from '@cucumber/cucumber';
import { Afnemer } from './brp/afnemer-entity';
import { Aanduiding } from './support/aanduiding';

Given('de afnemer {string}', async function (aanduidingAfnemer: string) {
    if (!this.context.afnemers) {
        this.context.afnemers = {};
    }
    this.context.afnemers[aanduidingAfnemer] = new Afnemer(aanduidingAfnemer);
    this.huidigAanduiding = Aanduiding.afnemer(aanduidingAfnemer);
});

Given('met afnemer identificatie {string}', function (afnemerId: string) {
    if (this.huidigAanduiding?.isAfnemer) {
        (this.context.afnemers[this.huidigAanduiding.id] as Afnemer).afnemerId = afnemerId;
    }
});

Given('met oin {string}', function (oin: string) {
    if (this.huidigAanduiding?.isAfnemer) {
        (this.context.afnemers[this.huidigAanduiding.id] as Afnemer).oin = oin;
    }
});
