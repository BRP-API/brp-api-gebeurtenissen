import {DataTable, Then} from '@cucumber/cucumber';
import {createSelectStatement} from './support/sql-statements-factory.js';
import {PostgresqlManager} from './support/postgresql-manager.js';
import {stringifyValues} from './support/object-utils.js';
import {expect} from 'chai';

function entiteitAanduidingenVervangen(expected: any, eniteiten: any) {
  for (const [column, value] of Object.entries(expected)) {
    if (Object.keys(eniteiten).includes(value as string)) {
      expected[column] = eniteiten[value as string][column];
    }
  }
}

function entiteitAanduidingenInDataTableRijVervangen(
  tabel: string,
  dataTableHash: any,
  context: any,
) {
  if (tabel === 'lo3_adres') {
    entiteitAanduidingenVervangen(dataTableHash, context.adressen);
  }
  if (tabel === 'lo3_pl' || tabel === 'lo3_pl_persoon') {
    entiteitAanduidingenVervangen(dataTableHash, context.personen);
  }
  if (tabel === 'lo3_pl_verblijfplaats') {
    entiteitAanduidingenVervangen(dataTableHash, context.personen);
    entiteitAanduidingenVervangen(dataTableHash, context.adressen);
  }
}

Then(
  'heeft tabel {string} de volgende rij',
  async function (tabel: string, dataTable: DataTable) {
    for (const expected of dataTable.hashes()) {
      entiteitAanduidingenInDataTableRijVervangen(
        tabel,
        expected,
        this.context,
      );

      const statement = createSelectStatement(
        tabel,
        Object.keys(expected),
        Object.values(expected),
      );

      const result = await PostgresqlManager.getInstance().execute(statement);

      const actual = Object.fromEntries(result);
      if (actual['burger_service_nr']) {
        actual['burger_service_nr'] = actual['burger_service_nr'].padStart(
          9,
          '0',
        );
      }

      expect(stringifyValues(actual)).to.deep.equal(stringifyValues(expected));
    }
  },
);
