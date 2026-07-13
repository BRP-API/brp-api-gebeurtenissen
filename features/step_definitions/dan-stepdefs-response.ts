import {Then, defineParameterType, DataTable} from '@cucumber/cucumber';
import {ProblemDetails} from './support/problem-details';
import {
  createObjectArrayWithPersoonAanduidingenFrom,
  createObjectArrayFrom,
} from './support/dataTable2Object';
import {Persoon} from './brp/persoon-entity';
import {expect} from 'chai';

Then(
  'is de response {string}( met de volgende velden)',
  function (status: string) {
    this.expected = ProblemDetails.create(status);

    expect(this.responseStatusCode).to.equal(
      ProblemDetails.getStatusCode(status),
    );
    if (!ProblemDetails.isSuccessFull(this.responseStatusCode)) {
      expect(this.result.status).to.equal(
        this.expected.status,
        'http statuscode is niet correct',
      );
      expect(this.result.type).to.equal(
        this.expected.type,
        'type is niet correct',
      );
    }
  },
);

Then(
  'heeft de response invalidParams met de volgende gegevens',
  function (dataTable: DataTable) {
    if (!this.expected.invalidParams) {
      this.expected.invalidParams = [];
    }

    this.expected.invalidParams.push(createObjectArrayFrom(dataTable));
  },
);

Then('{string} met tekst {string}', function (veld: string, waarde: string) {
  this.expected[veld] = waarde;
  expect(this.result.body[veld]).to.equal(
    this.expected[veld],
    `${veld} is niet correct`,
  );
});

defineParameterType({
  name: 'objectNaam',
  regexp: /(abonnees|groepen|gebeurtenistypes|abonnementen|gebeurtenissen)/,
});

Then(
  'worden volgende {objectNaam} geleverd',
  function (objectNaam: string, dataTable) {
    const personen: Record<string, Persoon> = this.context.personen || {};

    this.expected = {
      [objectNaam]: createObjectArrayWithPersoonAanduidingenFrom(
        dataTable,
        personen,
      ),
    };
    expect(this.result[objectNaam]).to.deep.equal(
      this.expected[objectNaam],
      `${objectNaam} is niet correct`,
    );
  },
);

Then('wordt er geen abonnement geleverd', function () {
  this.expected = {
    ['abonnementen']: [],
  };

  expect(this.result['abonnementen']).to.deep.equal(
    this.expected['abonnementen'],
  );
});
