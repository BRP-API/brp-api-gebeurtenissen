import {Given, Then} from '@cucumber/cucumber';
import {ProblemDetails, InvalidParam} from './support/problem-details.js';

const adressenEndpoint = '/api/brp/adressen';

function createinValidParamsBadRequest(
  invalidParams: InvalidParam[],
): ProblemDetails {
  return ProblemDetails.createBadRequestProblemDetails(
    'Een of meerdere parameters zijn niet correct.',
    `De foutieve parameter(s) zijn: ${invalidParams.map(p => p.name).join(', ')}.`,
    adressenEndpoint,
    'paramsValidation',
    invalidParams,
  );
}

function gemeenteCodeVerplichtBadRequest(): ProblemDetails {
  return createinValidParamsBadRequest([
    new InvalidParam('required', 'gemeentecode', 'Parameter is verplicht.'),
  ]);
}

function gemeenteBestaatNietBadRequest(): ProblemDetails {
  return createinValidParamsBadRequest([
    new InvalidParam('notFound', 'gemeentecode', 'Gemeente bestaat niet.'),
  ]);
}

function gemeenteCodeOngeldigBadRequest(): ProblemDetails {
  return createinValidParamsBadRequest([
    new InvalidParam(
      'pattern',
      'gemeentecode',
      String.raw`Waarde voldoet niet aan patroon ^\d{4}$.`,
    ),
  ]);
}

Given(
  'de response is een problemdetails met de melding dat de gemeentecode verplicht is',
  function () {
    this.result = gemeenteCodeVerplichtBadRequest();
  },
);

Given(
  'de response is een problemdetails met de melding dat een gemeente met de opgegeven gemeentecode niet bestaat',
  function () {
    this.result = gemeenteBestaatNietBadRequest();
  },
);

Given(
  'de response is een problemdetails met de melding dat de opgegeven gemeentecode ongeldig is',
  function () {
    this.result = gemeenteCodeOngeldigBadRequest();
  },
);

Then(
  'is de response een problemdetails met de melding dat de gemeentecode verplicht is',
  function () {
    this.expected = gemeenteCodeVerplichtBadRequest();
  },
);

Then(
  'is de response een problemdetails response met een invalidParams object met de melding dat de gemeentecode niet bestaat',
  function () {
    this.expected = gemeenteBestaatNietBadRequest();
  },
);

Then(
  'is de response een problemdetails response met de melding dat de gemeentecode ongeldig is',
  function () {
    this.expected = gemeenteCodeOngeldigBadRequest();
  },
);

Then('is de response in json formaat', function (docString) {
  this.expected = JSON.parse(docString);
});
