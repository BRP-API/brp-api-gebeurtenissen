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
    const plId = this.context.personen[persoonAanduiding].pl_id;
    let plStatement = createSelectStatement('lo3_pl', ['pl_id'], [plId]);

    let result = await PostgresqlManager.getInstance().execute(plStatement);
    let actual = Object.fromEntries(result);

    logger.debug('Query database:', {
      statement: plStatement,
      result: actual,
    });

    expect(actual).is.not.null(
      `Er is geen persoon geregistreerd voor pl_id: ${plId}.`,
    );
    expect(actual.geheim_ind).to.equal(0);

    plStatement = createSelectStatement(
      'lo3_pl_persoon',
      ['pl_id', 'persoon_type', 'geslachtsnaam'],
      [plId, 'P', geslachtsnaam],
    );

    result = await PostgresqlManager.getInstance().execute(plStatement);
    actual = Object.fromEntries(result);

    logger.debug('Query database:', {
      statement: plStatement,
      result: actual,
    });

    expect(actual).is.not.null(
      `Er is geen persoon geregistreerd in lo3_pl_persoon voor pl_id: ${plId} met geslachtsnaam: ${geslachtsnaam} en persoon_type: P.`,
    );
  },
);

Then(
  'is het adres {string} vanaf {dd-mm-yyyy datum} geregistreerd in de BRP als verblijfplaats van de persoon {string}',
  async function (
    adresAanduiding: string,
    datumVerblijf: string,
    persoonAanduiding: string,
  ) {
    const adresId = this.context.adressen[adresAanduiding].adres_id;
    const plId = this.context.personen[persoonAanduiding].pl_id;
    const statement = createSelectStatement(
      'lo3_verblijfplaats',
      ['adres_id', 'pl_id', 'adreshouding_start_datum'],
      [adresId, plId, datumVerblijf],
    );

    const result = await PostgresqlManager.getInstance().execute(statement);
    const actual = Object.fromEntries(result);

    logger.debug('Query database:', {
      statement: statement,
      result: actual,
    });

    expect(actual).is.not.null(
      `Er is geen verblijfplaats geregistreerd voor adres_id: ${adresId} en persoonId: ${plId}.`,
    );
  },
);
