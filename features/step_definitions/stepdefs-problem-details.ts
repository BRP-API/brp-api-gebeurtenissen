import {Given, Then, defineParameterType} from '@cucumber/cucumber';
import {ProblemDetails, InvalidParam} from './support/problem-details.js';
import { logger } from './support/logger.js';

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

function parameterVerplichtBadRequest(parameterNaam: string): ProblemDetails {
  return createinValidParamsBadRequest([
    new InvalidParam('required', parameterNaam, 'Parameter is verplicht.'),
  ]);
}

function resourceBestaatNietBadRequest(resourceNaam: string, parameterNaam: string): ProblemDetails {
  return createinValidParamsBadRequest([
    new InvalidParam(
      'notFound',
      parameterNaam,
      `${resourceNaam.charAt(0).toUpperCase() + resourceNaam.slice(1)} bestaat niet.`,
    ),
  ]);
}

function parameterOngeldigBadRequest(parameterNaam: string): ProblemDetails {
  const patroon = parameterNaam === 'gemeentecode' ? '^[0-9]{4}$' : '^[0-9]{16}$';
  return createinValidParamsBadRequest([
    new InvalidParam(
      'pattern',
      parameterNaam,
      `Waarde voldoet niet aan patroon ${patroon}.`,
    ),
  ]);
}

function datumParameterOngeldigBadRequest(parameterNaam: string): ProblemDetails {
  return createinValidParamsBadRequest([
    new InvalidParam(
      'date',
      parameterNaam,
      'Waarde is geen geldige datum.',
    ),
  ]);
}

function datumInToekomstBadRequest(parameterNaam: string): ProblemDetails {
  return createinValidParamsBadRequest([
    new InvalidParam(
      'date',
      parameterNaam,
      `Waarde mag niet in de toekomst liggen.`,
    ),
  ]);
}

defineParameterType({
  name: 'parameterNaam',
  regexp: /(gemeentecode|adresseerbaar object identificatie|verblijfdatum)/,
});

defineParameterType({
  name: 'resourceNaam',
  regexp: /(gemeente|adres)/,
});

Given(
  'de response is een problemdetails met de melding dat de {parameterNaam} verplicht is',
  function (parameterNaam: string) {
    this.result = parameterVerplichtBadRequest(parameterNaam);
  },
);

Given(
  'de response is een problemdetails met de melding dat een {resourceNaam} met de opgegeven {parameterNaam} niet bestaat',
  function (resourceNaam: string, parameterNaam: string) {
    this.result = resourceBestaatNietBadRequest(resourceNaam, parameterNaam);
  },
);

Given(
  'de response is een problemdetails met de melding dat de opgegeven {parameterNaam} ongeldig is',
  function (parameterNaam: string) {
    this.result = parameterNaam.search(/datum/) >= 0
      ? datumParameterOngeldigBadRequest(parameterNaam)
      : parameterOngeldigBadRequest(parameterNaam);
  },
);

Then(
  'is de response een problemdetails met de melding dat de {parameterNaam} verplicht is',
  function (parameterNaam: string) {
    this.expected = parameterVerplichtBadRequest(parameterNaam);
  },
);

Then(
  'is de response een problemdetails met de melding dat er geen {resourceNaam} bestaat voor de opgegeven {parameterNaam}',
  function (resourceNaam: string, parameterNaam: string) {
    this.expected = resourceBestaatNietBadRequest(resourceNaam, parameterNaam);
  }
);

Then(
  'is de response een problemdetails met de melding dat de opgegeven {parameterNaam} ongeldig is',
  function (parameterNaam: string) {
    logger.debug(`Parameter naam: ${parameterNaam}, is datum: ${parameterNaam.search(/datum/) >= 0}`)
    this.expected = parameterNaam.search(/datum/) >= 0
      ? datumParameterOngeldigBadRequest(parameterNaam)
      : parameterOngeldigBadRequest(parameterNaam);
  },
);

Then(
  'is de response een problemdetails met de melding dat de opgegeven {parameterNaam} in de toekomst ligt',
  function (parameterNaam: string) {
    this.expected = datumInToekomstBadRequest(parameterNaam);
  },
);

Then('is de response in json formaat', function (docString) {
  this.expected = JSON.parse(docString);
});
