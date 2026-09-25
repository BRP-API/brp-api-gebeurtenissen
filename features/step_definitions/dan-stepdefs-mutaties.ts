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
