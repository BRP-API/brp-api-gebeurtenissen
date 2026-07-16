import {DataTable, Then} from '@cucumber/cucumber';
import {CloudEvent} from './support/cloud-events';
import {setNestedProperty} from './support/object-utils';
//import {Aanduiding} from './support/aanduiding';
import {VerhuisdIntergemeentelijkEvent} from './brp/verhuisd-intergemeentelijk-event';
//import {AangifteVanAdreswijzigingCommand} from './brp-api/commands';
//import {Persoon} from './brp/persoon-entity';
import {PersoonFactory} from './support/persoon-factory';
import {createObjectArrayFrom} from './support/dataTable2Object';
import {maakGebeurtenis} from './support/gebeurtenissen-api-helpers';
import {logger} from './support/logger';
import {WiremockManager} from './support/wiremock-manager';
import {expect} from 'chai';
import {PostgresqlManager} from './support/postgresql-manager';
import {
  selectAllFromTableForPlid,
  selectAllFromTableForPlidAndVolgNr,
  selectFieldFromTableForPlid,
} from './support/sql-statements-factory';
import {registerCustomAssertions} from './support/custom-assertions/custom-assertions';
import {
  convertNumericStrings,
  createObjectFrom,
} from './support/dataTable2Object';

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

Then('het A-nummer van {string}', async function (aanduidingPersoon: string) {
  const anummer = this.context.personen[aanduidingPersoon].a_nr;
  if (this.expected instanceof VerhuisdIntergemeentelijkEvent) {
    this.expected.setAnummer(anummer);
  }
  const lastRequestBody = await WiremockManager.getLastRequestBody();
  expect(lastRequestBody.data.c01.e0110).equal(anummer);
});

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

Then('wordt er geen gebeurtenis geleverd', function () {
  this.expected = {
    ['gebeurtenissen']: [],
  };
});

Then(
  'wordt de {string} gebeurtenis van {string} geleverd',
  async function (gebeurtenistype: string, persoonAanduiding: string) {
    const persoon = await PersoonFactory.create(
      this.context,
      persoonAanduiding,
    );

    this.expected.gebeurtenissen = [maakGebeurtenis(gebeurtenistype, persoon)];
  },
);

Then('worden de volgende gebeurtenissen geleverd', async function (dataTable) {
  const gebeurtenissen = createObjectArrayFrom(dataTable);

  this.expected.gebeurtenissen = [];

  for (const gebeurtenis of gebeurtenissen) {
    const persoon = await PersoonFactory.create(
      this.context,
      gebeurtenis['burgerservicenummer'],
    );
    this.expected.gebeurtenissen.push(
      maakGebeurtenis(gebeurtenis['gebeurtenistype'], persoon),
    );
  }
});
