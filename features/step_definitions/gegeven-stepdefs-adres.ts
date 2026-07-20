import {Given} from '@cucumber/cucumber';
import {Adres} from './brp/adres-entity';
import {Aanduiding} from './support/aanduiding';
import {AdresBuitenland} from './brp/adres-buitenland-entity';
import {AdresFactory} from './support/adres-factory';
import {expect} from 'chai';
//import {logger} from './support/logger';

Given('het adres {string}', async function (adresAanduiding: string) {
  await AdresFactory.create(this.context, adresAanduiding);
});

Given('in gemeente {string}', async function (gemeenteOmschrijving: string) {
  const gemeenteCodeMap: {[key: string]: string} = {
    Amsterdam: '0363',
    'Den Haag': '0518',
    Hengelo: '0164',
    Roosendaal: '1674',
    Rotterdam: '0599',
    Utrecht: '0344',
  };

  await AdresFactory.update(
    this.context,
    'gemeente_code',
    gemeenteCodeMap[gemeenteOmschrijving] || gemeenteOmschrijving,
  );

  await AdresFactory.update(
    this.context,
    'woon_plaats_naam',
    gemeenteOmschrijving,
  );
});

Given(
  'met adres {string} en postcode {string}',
  async function (adresregel1, postcode) {
    const adresParts = /([a-zA-Z\.\- ]+) (\d+)/.exec(adresregel1) || [];

    expect(adresParts.length).to.be.gte(
      2,
      'Adres moet straat en huisnummer bevatten',
    );

    await AdresFactory.update(
      this.context,
      'straat_naam',
      adresParts[1].substring(0, 24),
    );
    await AdresFactory.update(this.context, 'open_ruimte_naam', adresParts[1]);
    await AdresFactory.update(this.context, 'huis_nr', adresParts[2]);
    await AdresFactory.update(this.context, 'postcode', postcode);
  },
);

Given(
  'met adresseerbaar object identificatie {string}',
  async function (adresseerbaarObjectIdentificatie: string) {
    await AdresFactory.update(
      this.context,
      'verblijf_plaats_ident_code',
      adresseerbaarObjectIdentificatie,
    );
  },
);

Given('het adres buitenland {string}', function (adresAanduiding: string) {
  if (!this.context.adressen) {
    this.context.adressen = {};
  }
  this.context.adressen[adresAanduiding] = new AdresBuitenland();
  this.huidigAanduiding = Aanduiding.adresBuitenland(adresAanduiding);
});

Given('met adres regel 1 {string}', function (adresRegel1: string) {
  if (this.huidigAanduiding?.isAdresBuitenland) {
    (
      this.context.adressen[this.huidigAanduiding.id] as AdresBuitenland
    ).vertrek_land_adres_1 = adresRegel1;
  }
});

Given('met adres regel 2 {string}', function (adresRegel2: string) {
  if (this.huidigAanduiding?.isAdresBuitenland) {
    (
      this.context.adressen[this.huidigAanduiding.id] as AdresBuitenland
    ).vertrek_land_adres_2 = adresRegel2;
  }
});

Given('met adres regel 3 {string}', function (adresRegel3: string) {
  if (this.huidigAanduiding?.isAdresBuitenland) {
    (
      this.context.adressen[this.huidigAanduiding.id] as AdresBuitenland
    ).vertrek_land_adres_3 = adresRegel3;
  }
});

Given('in land {string}', function (landCode: string) {
  const landCodeMap: {[key: string]: string} = {
    Frankrijk: '5002',
    Zwitserland: '5003',
    België: '5010',
    'Verenigde Staten van Amerika': '6014',
    Duitsland: '6029',
    Onbekend: '0000',
  };

  if (this.huidigAanduiding?.isAdresBuitenland) {
    (
      this.context.adressen[this.huidigAanduiding.id] as AdresBuitenland
    ).vertrek_land_code = landCodeMap[landCode] || landCode;
  }
});
