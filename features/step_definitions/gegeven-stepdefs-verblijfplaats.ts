import {Given} from '@cucumber/cucumber';
import {toBrpDate} from './support/date-utils.js';
import {Adres} from './brp/adres-entity.js';
import {Persoon} from './brp/persoon-entity.js';
import {VerblijfplaatsBinnenland} from './brp/verblijfplaats-entity.js';
import {createVerblijfPlaatsVoorPersoon} from './support/repository.js';
import {PersoonFactory} from './support/persoon-factory.js';

Given(
  'verblijft vanaf {string} op het adres {string}',
  async function (datum: string, adresAanduiding: string) {
    const persoon = this.context.personen[this.context.actuelePersoon];
    const adres = this.context.adressen[adresAanduiding];

    await PersoonFactory.verhuisNaarAdres(persoon, adres, toBrpDate(datum));
  },
);

Given(
  '{string} verblijft sinds {string} op adres {string}',
  async function (
    persoonAanduiding: string,
    datum: string,
    adresAanduiding: string,
  ) {
    const persoon: Persoon = this.context.personen[persoonAanduiding];
    const adres: Adres = this.context.adressen[adresAanduiding];

    persoon.verblijfplaats = new VerblijfplaatsBinnenland(
      adres,
      toBrpDate(datum),
    );
    await createVerblijfPlaatsVoorPersoon(persoon);
  },
);
