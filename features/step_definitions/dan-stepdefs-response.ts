import {Then, defineParameterType} from '@cucumber/cucumber';
import {ProblemDetails} from './support/problem-details';
import {createObjectArrayFrom} from './support/dataTable2Object';
import {expect} from 'chai';

Then(
  'is de response {string}( met de volgende velden)',
  function (status: string) {
    this.expected = ProblemDetails.create(status);
    expect(this.responseStatusCode).to.equal(
      ProblemDetails.getStatusCode(status),
    );
    if (!ProblemDetails.isSuccessFull(this.responseStatusCode)) {
      expect(this.result.status).to.equal(this.expected.status, 'http statuscode is niet correct');
      expect(this.result.type).to.equal(this.expected.type, 'type is niet correct');
    }
  },
);

Then('{string} met tekst {string}', function (veld: string, waarde: string) {
  this.expected[veld] = waarde;
  expect(this.result[veld]).to.equal(this.expected[veld], `${veld} is niet correct`);
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
    expect(this.result[objectNaam]).to.deep.equal(this.expected[objectNaam], `${objectNaam} is niet correct`);
  },
);
