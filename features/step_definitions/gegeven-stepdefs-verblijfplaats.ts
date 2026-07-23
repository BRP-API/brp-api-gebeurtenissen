import {Given} from '@cucumber/cucumber';
import {toBrpDate} from './support/date-utils';
import {Adres} from './brp/adres-entity';
import {Persoon} from './brp/persoon-entity';
import {VerblijfplaatsBinnenland} from './brp/verblijfplaats-entity';
import {createVerblijfPlaatsVoorPersoon} from './support/repository';
import {PersoonFactory} from './support/persoon-factory';

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
