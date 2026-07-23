import {Then, defineParameterType, DataTable} from '@cucumber/cucumber';
import {ProblemDetails} from './support/problem-details';
import {
  createArrayFrom,
  createObjectArrayWithPersoonAanduidingenFrom,
  createObjectArrayFrom,
  createObjectFrom,
  createArrayFrom,
} from './support/dataTable2Object';
import {Persoon} from './brp/persoon-entity';
import {expect} from 'chai';

Then(
  'is de response {string}( met de volgende velden)',
  function (status: string) {
    const expectedStatus = Number(status.split(' ')[0]);
    if (expectedStatus === 201) {
      this.expected = {
        statusCode: 201,
        body: null,
      };
    }
    if (expectedStatus === 204) {
      this.expected = {
        statusCode: 204,
        body: null,
      };
    }

    if (!ProblemDetails.isSuccessFull(expectedStatus)) {
      this.expected = ProblemDetails.create(status);

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
    expect(this.result.body[objectNaam]).to.deep.equal(
      this.expected.body[objectNaam],
      `${objectNaam} is niet correct`,
    );
  },
);

Then('worden volgende gebeurtenistypes geleverd', function (dataTable) {
  this.expected = {
    statusCode: 200,
    body: {
      gebeurtenistypes: createArrayFrom(dataTable),
    },
  };
  expect(this.result.body.gebeurtenistypes).to.deep.equal(
    this.expected.body.gebeurtenistypes,
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
