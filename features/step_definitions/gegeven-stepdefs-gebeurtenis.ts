import {Given} from '@cucumber/cucumber';
import {PersoonFactory} from './support/persoon-factory.js';
import {
  publiceerGebeurtenis,
  raadpleegGebeurtenissenVoorAbonnee,
} from './support/gebeurtenissen-api-helpers.js';
import {AfnemerFactory} from './support/afnemer-factory.js';
import {expect} from 'chai';
import {HttpStatusCode} from 'axios';
import {DateType} from './support/date-utils.js';

Given(
  'er is een {string} gebeurtenis gepubliceerd voor persoon {string}',
  async function (gebeurtenistype: string, persoonAanduiding: string) {
    const persoon = await PersoonFactory.create(
      this.context,
      persoonAanduiding,
    );

    this.result = await publiceerGebeurtenis(gebeurtenistype, persoon);
    expect(this.result.statusCode).to.equal(HttpStatusCode.Created);
    if (!this.context.gebeurtenissen) {
      this.context.gebeurtenissen = {};
    }
    this.context.gebeurtenissen[persoonAanduiding] = this.result.body;
  },
);

Given(
  'er is een {string} gebeurtenis gepubliceerd voor persoon {string} met {string}',
  async function (
    gebeurtenistype: string,
    persoonAanduiding: string,
    datumType: string,
  ) {
    const persoon = await PersoonFactory.create(
      this.context,
      persoonAanduiding,
    );

    this.result = await publiceerGebeurtenis(
      gebeurtenistype,
      persoon,
      DateType[datumType as keyof typeof DateType],
    );
    expect(this.result.statusCode).to.equal(HttpStatusCode.Created);
    if (!this.context.gebeurtenissen) {
      this.context.gebeurtenissen = {};
    }
    this.context.gebeurtenissen[persoonAanduiding] = this.result.body;
  },
);

Given(
  'gebeurtenissen zijn gevraagd door abonnee {string} van afnemer {string}',
  async function (abonneeNaam: string, afnemerAanduiding: string) {
    const afnemer = await AfnemerFactory.create(
      this.context,
      afnemerAanduiding,
    );

    this.result = await raadpleegGebeurtenissenVoorAbonnee(
      afnemer,
      abonneeNaam,
    );
  },
);
