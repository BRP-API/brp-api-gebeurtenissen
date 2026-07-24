import {Then, defineParameterType, DataTable} from '@cucumber/cucumber';
import {ProblemDetails} from './support/problem-details';
import {
  createArrayFrom,
  createObjectArrayWithPersoonAanduidingenFrom,
  createObjectArrayFrom,
  createObjectFrom,
} from './support/dataTable2Object';
import {Persoon} from './brp/persoon-entity';
import {expect} from 'chai';

Then(
  'is de response {string}( met de volgende velden)',
  function (status: string) {
    const expectedStatus = Number(status.split(' ')[0]);
    expect(this.responseStatusCode).to.equal(
      expectedStatus,
      'http statuscode is niet correct',
    );

    if (expectedStatus === 201) {
      this.expected = null;
    }
    if (expectedStatus === 204) {
      this.expected = null;
    }

    if (!ProblemDetails.isSuccessFull(expectedStatus)) {
      this.expected = ProblemDetails.create(status);

      expect(this.result.status).to.equal(
        expectedStatus,
        'http statuscode is niet correct',
      );
      expect(this.result.type).to.equal(
        this.expected.type,
        'type is niet correct',
      );
      expect(this.result).to.have.property('instance').that.is.a('string');
      expect(this.result).to.have.property('title').that.is.a('string');
      expect(this.result).to.have.property('code').that.is.a('string');
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
  expect(this.result[veld]).to.equal(
    this.expected[veld],
    `${veld} is niet correct`,
  );
});

defineParameterType({
  name: 'objectNaam',
  regexp: /(abonnees|groepen|abonnementen|gebeurtenissen)/,
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

Then('worden volgende gebeurtenistypes geleverd', function (dataTable) {
  this.expected = {
    gebeurtenistypes: createArrayFrom(dataTable),
  };
  expect(this.result.gebeurtenistypes).to.deep.equal(
    this.expected.gebeurtenistypes,
    'gebeurtenistypes is niet correct',
  );
});

Then(
  'heeft {string} de volgende {string} gegevens',
  function (persoonaanduiding, propertyNaam, dataTable) {
    // dit betreft gegevens van een persoon zoals die uit de personen API komt.
    // dit werkt alleen bij vragen (en ontvangen) van exact 1 persoon in de response

    if (this.expected === undefined || this.expected.personen === undefined) {
      this.expected.personen = [{}];
    }
    this.expected.personen[0][propertyNaam] = createObjectFrom(dataTable);
  },
);

Then(
  'heeft de response een verblijfplaats voorkomen met de volgende gegevens',
  function (dataTable) {
    if (
      this.expected === undefined ||
      this.expected.verblijfplaatsen === undefined
    ) {
      this.expected.verblijfplaatsen = [];
    }
    this.expected.verblijfplaatsen.push(createObjectFrom(dataTable));
  },
);

Then('heeft de response de volgende gegevens', function (dataTable) {
  if (this.expected === undefined) {
    this.expected = {};
  }

  this.expected = Object.assign(this.expected, createObjectFrom(dataTable));
});
