import {Then} from '@cucumber/cucumber';
import {createSelectStatement} from './support/sql-statements-factory.js';
import {PostgresqlManager} from './support/postgresql-manager.js';
import {logger} from './support/logger.js';
import {expect} from 'chai';
import {gemeenteCodeMap} from './support/gemeente-codes.js';

Then('is de response een AdresGeregistreerd response', function () {
  this.expected = null;

  expect(this.result.type).to.equal('AdresGeregistreerd');
});

Then(
  'is het adres geregisteerd in de BRP met een unieke adresseerbaar object identificatie en de gemeentecode van {string}',
  async function (gemeente: string) {
    const gemeentecode = gemeenteCodeMap[gemeente] || gemeente;
    const statement = createSelectStatement(
      'lo3_adres',
      ['adres_id', 'verblijf_plaats_ident_code', 'gemeente_code'],
      [
        this.result.adresId,
        this.result.adresseerbaarObjectIdentificatie,
        gemeentecode,
      ],
    );

    const result = await PostgresqlManager.getInstance().execute(statement);
    const actual = Object.fromEntries(result);

    logger.debug('Query database:', {
      statement: statement,
      result: actual,
    });

    expect(Number(actual.adres_id)).to.equal(this.result.adresId);
    expect(actual.verblijf_plaats_ident_code).to.equal(
      this.result.adresseerbaarObjectIdentificatie,
    );
    expect(actual.gemeente_code).to.equal(Number(gemeentecode));
  },
);

Then('is de response een PersoonGeregistreerd response', function () {
  this.expected = null;

  expect(this.result.type).to.equal('PersoonGeregistreerd');
});

Then(
  'is de persoon {string} geregistreerd in de BRP met geslachtsnaam {string}, een unieke anummer en burgerservicenummer',
  async function (persoonAanduiding: string, geslachtsnaam: string) {
    const plStatement = createSelectStatement(
      'lo3_pl',
      ['pl_id', 'geheim_ind'],
      [this.result.persoonId, 0],
    );

    const result = await PostgresqlManager.getInstance().execute(plStatement);
    const actual = Object.fromEntries(result);

    logger.debug('Query database:', {
      statement: plStatement,
      result: actual,
    });
  },
);

Then(
  'is het adres {string} vanaf {dd-mm-yyyy datum} geregistreerd in de BRP als verblijfplaats van de persoon {string}',
  async function (
    adresAanduiding: string,
    datumVerblijf: string,
    persoonAanduiding: string,
  ) {
    const statement = createSelectStatement(
      'lo3_verblijfplaats',
      ['adres_id', 'pl_id', 'adreshouding_start_datum'],
      [
        this.context.adressen[adresAanduiding].adres_id,
        this.context.personen[persoonAanduiding].pl_id,
        datumVerblijf,
      ],
    );

    const result = await PostgresqlManager.getInstance().execute(statement);
    const actual = Object.fromEntries(result);

    logger.debug('Query database:', {
      statement: statement,
      result: actual,
    });
  },
);
