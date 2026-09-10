import {Then} from '@cucumber/cucumber';
import {createSelectStatement} from './support/sql-statements-factory.js';
import {PostgresqlManager} from './support/postgresql-manager.js';
import {logger} from './support/logger.js';
import {ProblemDetails, InvalidParam} from './support/problem-details.js';
import {expect} from 'chai';

const adressenEndpoint = '/api/brp/adressen';

function createinValidParamsBadRequest(invalidParams: InvalidParam[]) {
  return ProblemDetails.createBadRequestProblemDetails(
    'Een of meerdere parameters zijn niet correct.',
    `De foutieve parameter(s) zijn: ${invalidParams.map(p => p.name).join(', ')}.`,
    adressenEndpoint,
    invalidParams,
  );
}

Then(
  'is de response een problemdetails met de melding dat de gemeentecode verplicht is',
  function () {
    this.expected = createinValidParamsBadRequest([
      new InvalidParam('required', 'gemeentecode', 'Parameter is verplicht.'),
    ]);
  },
);

Then(
  'is de response een problemdetails response met een invalidParams object met de melding dat de gemeentecode niet bestaat',
  function () {
    this.expected = createinValidParamsBadRequest([
      new InvalidParam('notFound', 'gemeentecode', 'Gemeente bestaat niet.'),
    ]);
  },
);

Then(
  'is de response een problemdetails response met de melding dat de gemeentecode ongeldig is',
  function () {
    this.expected = createinValidParamsBadRequest([
      new InvalidParam(
        'pattern',
        'gemeentecode',
        String.raw`Waarde voldoet niet aan patroon ^\d{4}$.`,
      ),
    ]);
  },
);

Then('is de response een AdresGeregistreerd response', function () {
  this.expected = null;

  expect(this.result.type).to.equal('AdresGeregistreerd');
});

Then('is het adres geregisteerd in de BRP', async function () {
  const statement = createSelectStatement(
    'lo3_adres',
    ['adres_id', 'verblijf_plaats_ident_code'],
    [this.result.adresId, this.result.adresseerbaarObjectIdentificatie],
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
});
