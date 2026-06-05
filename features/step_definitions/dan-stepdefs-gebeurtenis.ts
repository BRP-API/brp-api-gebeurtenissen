import {DataTable, Then} from '@cucumber/cucumber';
import {CloudEvent} from './support/cloud-events';
import {setNestedProperty} from './support/object-utils';
import {Aanduiding} from './support/aanduiding';
import {VerhuisdIntergemeentelijkEvent} from './brp/verhuisd-intergemeentelijk-event';
import {AangifteVanAdreswijzigingCommand} from './brp-api/commands';
import {Persoon} from './brp/persoon-entity';
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

Then('zijn er geen gebeurtenissen gepubliceerd', () => {});

function getPersoonByBsn(personen: any, bsn: string): Persoon | undefined {
  const key = Object.keys(personen).find(key => {
    return personen[key].burger_service_nr === bsn;
  });
  return key ? personen[key] : undefined;
}

Then(
  'is een {string} gebeurtenis gepubliceerd( met de volgende velden)( met de volgende data)',
  async function (gebeurtenisType: string) {
    this.expected =
      gebeurtenisType === 'verhuisd.intergemeentelijk'
        ? new VerhuisdIntergemeentelijkEvent(true)
        : new CloudEvent(`nl.brp.${gebeurtenisType}`);
    this.aanduiding = Aanduiding.gepubliceerdGebeurtenis();

    if (this.command instanceof AangifteVanAdreswijzigingCommand) {
      const persoon: Persoon | undefined = getPersoonByBsn(
        this.context.personen,
        this.command.burgerservicenummer!,
      );
      if (persoon) {
        this.expected.setAnummer(persoon.a_nr);
      }
      this.expected.setVerhuisdatum(this.command.verhuisdatum);
      this.expected.setAdresseerbaarObjectIdentificatie(
        this.command.adresseerbaarObjectIdentificatie,
      );
    }

    const lastRequestBody = await WiremockManager.getLastRequestBody();
    this.result.type = lastRequestBody.type;
    expect(lastRequestBody.type).to.equal(this.expected.type);
  },
);

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

Then(
  'is het {string} van de {string} rijen van {string} opgehoogd met 1',
  async function (veld: string, table: string, perssoonAanduiding: string) {
    registerCustomAssertions();
    const plId = this.context.personen[perssoonAanduiding].pl_id;
    const results = await PostgresqlManager.getInstance().listExecute(
      selectFieldFromTableForPlid(table, veld, plId),
    );
    const fieldValues = results.map(result => Number(result.get(veld))).sort();

    expect(fieldValues).to.be.consecutiveNumbers();
    expect(fieldValues).length.to.be.greaterThanOrEqual(2);
  },
);

Then(
  'is een {string} rij toegevoegd',
  async function (tabel: string, dataTable: DataTable) {
    let dataTableObject = createObjectFrom(dataTable);
    const perssoonAanduiding = dataTableObject.pl_id;
    const plId = this.context.personen[perssoonAanduiding].pl_id;
    dataTableObject = convertNumericStrings(dataTableObject);
    dataTableObject.pl_id = plId;
    const result = await PostgresqlManager.getInstance().execute(
      selectAllFromTableForPlidAndVolgNr(tabel, plId, 0),
    );
    const resultObject = Object.fromEntries(result);
    expect(resultObject).to.deep.equal(dataTableObject);
  },
);

Then(
  'heeft de {string} rij voor {string} opschorting bijhouding met datum {string} en reden {string}',
  async function (
    tabel: string,
    perssonAanduiding: string,
    datum: string,
    reden: string,
  ) {
    const plId = this.context.personen[perssonAanduiding].pl_id;
    const result = await PostgresqlManager.getInstance().execute(
      selectAllFromTableForPlid(tabel, plId),
    );
    // Write code here that turns the phrase above into concrete actions
    expect(result.get('bijhouding_opschort_reden')).to.be.equal(reden);
    expect(result.get('bijhouding_opschort_datum')).to.be.equal(Number(datum));
  },
);
