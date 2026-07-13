import {Then, defineParameterType} from '@cucumber/cucumber';
import {ProblemDetails} from './support/problem-details';
import {createObjectArrayFrom} from './support/dataTable2Object';
import {expect} from 'chai';

Then(
  'is de response {string}( met de volgende velden)',
  function (status: string) {
    this.expected = ProblemDetails.create(status);
    const expectedStatus = this.expected.status;

    expect(expectedStatus).to.equal(ProblemDetails.getStatusCode(status));
    if (!ProblemDetails.isSuccessFull(expectedStatus)) {
      expect(this.result.body.status).to.equal(
        expectedStatus,
        'http statuscode is niet correct',
      );
      expect(this.result.body.type).to.equal(
        this.expected.type,
        'type is niet correct',
      );
    }
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
    this.expected = {
      [objectNaam]: createObjectArrayFrom(dataTable),
    };
    expect(this.result[objectNaam]).to.deep.equal(
      this.expected[objectNaam],
      `${objectNaam} is niet correct`,
    );
  },
);
