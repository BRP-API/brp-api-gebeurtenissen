import {Given} from '@cucumber/cucumber';
import {toBrpDate} from './support/date-utils.js';
import {toIsoDate} from './support/date-utils.js';
import {Adres} from './brp/adres-entity.js';
import {AdresBuitenland} from './brp/adres-buitenland-entity.js';
import {Persoon} from './brp/persoon-entity';
import {VerblijfplaatsBinnenland} from './brp/verblijfplaats-entity.js';
import {createVerblijfPlaatsVoorPersoon} from './support/repository.js';
import {PersoonFactory} from './support/persoon-factory.js';

function handleVerhuizing(persoon: any, adres: any, datum: string) {
  if (adres instanceof Adres) {
    persoon.verhuistNaarAdres(adres, datum);
  }
  if (adres instanceof AdresBuitenland) {
    persoon.verhuistNaarAdresBuitenland(adres, datum);
  }
}

function handleAangifteVanAdreswijzigingCommand(
  command: any,
  adres: Adres,
  datum: string,
) {
  command.adresseerbaarObjectIdentificatie = adres.verblijf_plaats_ident_code;
  command.verhuisdatum = toIsoDate(datum);
}

function handleAangifteVanVertrekCommand(
  command: any,
  adres: AdresBuitenland,
  datum: string,
) {
  command.adres = {};

  if (adres.vertrek_land_adres_1) {
    command.adres.regel1 = adres.vertrek_land_adres_1;
  }
  if (adres.vertrek_land_adres_2) {
    command.adres.regel2 = adres.vertrek_land_adres_2;
  }
  if (adres.vertrek_land_adres_3) {
    command.adres.regel3 = adres.vertrek_land_adres_3;
  }
  command.adres.land = adres.vertrek_land_code;
  command.verhuisdatum = toIsoDate(datum);
}

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
