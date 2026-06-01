import { Given } from '@cucumber/cucumber';
import { PersoonFactory } from './support/persoon-factory';
import {
  publiceerGebeurtenis, raadpleegGebeurtenissenVoorAbonnee
} from './support/gebeurtenissen-api-helpers';
import { AfnemerFactory } from './support/afnemer-factory';

Given('er is een {string} gebeurtenis gepubliceerd voor persoon {string}', async function (gebeurtenistype: string, persoonAanduiding: string) {
  const persoon = await PersoonFactory.create(this.context, persoonAanduiding);

  this.result = await publiceerGebeurtenis(gebeurtenistype, persoon);
});

Given('gebeurtenissen zijn gevraagd door abonnee {string} van afnemer {string}', async function (abonneeNaam: string, afnemerAanduiding: string) {
    const afnemer = await AfnemerFactory.create(this.context, afnemerAanduiding);

    this.result = await raadpleegGebeurtenissenVoorAbonnee(afnemer, abonneeNaam);
});