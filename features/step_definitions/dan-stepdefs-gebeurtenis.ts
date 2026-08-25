import {Then} from '@cucumber/cucumber';
import {CloudEvent} from './support/cloud-events.js';
import {setNestedProperty} from './support/object-utils.js';
import {VerhuisdIntergemeentelijkEvent} from './brp/verhuisd-intergemeentelijk-event.js';
import {PersoonFactory} from './support/persoon-factory.js';
import {createObjectArrayFrom} from './support/dataTable2Object.js';
import {maakGebeurtenis} from './support/gebeurtenissen-api-helpers.js';
import {logger} from './support/logger.js';
import {expect} from 'chai';
import {expectEventuallyWithRetry} from './support/custom-assertions/expectEventually.js';
import 'chai-exclude';

Then(
  'is een {string} gebeurtenis geleverd( met de volgende velden)( met de volgende data)',
  function (gebeurtenisType: string) {
    this.expected =
      gebeurtenisType === 'verhuisd.intergemeentelijk'
        ? new VerhuisdIntergemeentelijkEvent(false)
        : new CloudEvent(`nl.brp.${gebeurtenisType}`);
  },
);

Then(
  '{string} met de afnemer id van {string}',
  function (veld: string, aanduidingAfnemer: string) {
    setNestedProperty(this.expected, `data.${veld}`, aanduidingAfnemer);
  },
);

Then(
  'de vanaf datum van de opgave van verhuizing van {string}',
  function (persoonAanduiding: string) {
    if (this.expected instanceof VerhuisdIntergemeentelijkEvent) {
      this.expected.setVerhuisdatum(this.command.verhuisdatum);
      return;
    }
    logger.debug(`TODO: Implement this and use ${persoonAanduiding})`);
  },
);

Then(
  'de adresseerbaar object identificatie van het adres {string}',
  function (adresAanduiding: string) {
    if (this.expected instanceof VerhuisdIntergemeentelijkEvent) {
      this.expected.setAdresseerbaarObjectIdentificatie(
        this.context.adressen[adresAanduiding].verblijf_plaats_ident_code,
      );
    }
  },
);

Then(
  'het burgerservicenummer van {string}',
  function (aanduidingPersoon: string) {
    if (this.expected instanceof VerhuisdIntergemeentelijkEvent) {
      this.expected.setBurgerservicenummer(
        this.context.personen[aanduidingPersoon].burger_service_nr,
      );
    }
  },
);

Then('wordt er geen gebeurtenis geleverd', async function () {
  this.expected = null;

  await expectEventuallyWithRetry(
    this.result,
    async () => (await this.resultProducer()).body,
    result => {
      this.result = result;
      expect(result).to.deep.equal({gebeurtenissen: []});
    },
  );
});

Then(
  'wordt de {string} gebeurtenis van {string} geleverd',
  async function (gebeurtenistype: string, persoonAanduiding: string) {
    const persoon = await PersoonFactory.create(
      this.context,
      persoonAanduiding,
    );

    const expected = {
      gebeurtenissen: [maakGebeurtenis(gebeurtenistype, persoon)],
    };

    await expectEventuallyWithRetry(
      this.result,
      async () => (await this.resultProducer()).body,
      result => {
        this.result = result;
        expect(result).excludingEvery('id').to.deep.equal(expected);
      },
    );

    this.expected = null;
  },
);

Then('worden de volgende gebeurtenissen geleverd', async function (dataTable) {
  const gebeurtenissen = createObjectArrayFrom(dataTable);

  const expectedGebeurtenissen = [];

  for (const gebeurtenis of gebeurtenissen) {
    const persoon = await PersoonFactory.create(
      this.context,
      gebeurtenis['burgerservicenummer'],
    );
    let datum = undefined;
    if (gebeurtenis['datum']) {
      datum = gebeurtenis['datum'];
    }
    expectedGebeurtenissen.push(
      maakGebeurtenis(gebeurtenis['gebeurtenistype'], persoon, datum),
    );
  }
  const expected = {gebeurtenissen: expectedGebeurtenissen};
  await expectEventuallyWithRetry(
    this.result,
    async () => (await this.resultProducer()).body,
    result => {
      this.result = result;
      expect(result).excludingEvery('id').to.deep.equal(expected);
    },
  );
  this.expected = null;
});

Then(
  'worden {int} gebeurtenissen geleverd',
  {timeout: 60000},
  async function (aantal: number) {
    await expectEventuallyWithRetry(
      this.result,
      async () => (await this.resultProducer()).body,
      result => {
        this.result = result;
        expect(this.result.gebeurtenissen.length).to.equal(aantal);
      },
      {timeout: 60000},
    );
    this.expected = null;
  },
);
