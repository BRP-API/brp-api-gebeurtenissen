import {Given, Then, defineParameterType} from '@cucumber/cucumber';
import {ProblemDetails, InvalidParam} from './support/problem-details.js';
import {logger} from './support/logger.js';

function createinValidParamsBadRequest(
  invalidParams: InvalidParam[],
  instanceUri?: string,
): ProblemDetails {
  return ProblemDetails.createBadRequestProblemDetails(
    'Een of meerdere parameters zijn niet correct.',
    `De foutieve parameter(s) zijn: ${invalidParams.map(p => p.name).join(', ')}.`,
    instanceUri ?? '',
    'paramsValidation',
    invalidParams,
  );
}

function parameterVerplichtBadRequest(
  parameterNaam: string[],
  instanceUri?: string,
): ProblemDetails {
  return createinValidParamsBadRequest(
    parameterNaam.map(
      name => new InvalidParam('required', name, 'Parameter is verplicht.'),
    ),
    instanceUri,
  );
}

function resourceBestaatNietBadRequest(
  resourceNaam: string,
  parameterNaam: string,
  instanceUri?: string,
): ProblemDetails {
  return createinValidParamsBadRequest(
    [
      new InvalidParam(
        'notFound',
        parameterNaam,
        `${resourceNaam.charAt(0).toUpperCase() + resourceNaam.slice(1)} bestaat niet.`,
      ),
    ],
    instanceUri,
  );
}

function parameterOngeldigBadRequest(
  parameterNaam: string,
  instanceUri?: string,
): ProblemDetails {
  const patroon =
    parameterNaam === 'gemeentecode' ? '^[0-9]{4}$' : '^[0-9]{16}$';
  return createinValidParamsBadRequest(
    [
      new InvalidParam(
        'pattern',
        parameterNaam,
        `Waarde voldoet niet aan patroon ${patroon}.`,
      ),
    ],
    instanceUri,
  );
}

function datumParameterOngeldigBadRequest(
  parameterNaam: string,
  instanceUri?: string,
): ProblemDetails {
  return createinValidParamsBadRequest(
    [new InvalidParam('date', parameterNaam, 'Waarde is geen geldige datum.')],
    instanceUri,
  );
}

function datumInToekomstBadRequest(
  parameterNaam: string,
  instanceUri?: string,
): ProblemDetails {
  return createinValidParamsBadRequest(
    [
      new InvalidParam(
        'date',
        parameterNaam,
        'Waarde mag niet in de toekomst liggen.',
      ),
    ],
    instanceUri,
  );
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
  'de response is een problemdetails met de melding dat de {parameterNaam} en {parameterNaam} verplicht zijn',
  function (parameterNaam: string, parameterNaam2: string) {
    this.result = parameterVerplichtBadRequest(
      [parameterNaam, parameterNaam2],
      this.context.instanceUri,
    );
  },
);

Given(
  'de response is een problemdetails met de melding dat de {parameterNaam} verplicht is',
  function (parameterNaam: string) {
    this.result = parameterVerplichtBadRequest(
      [parameterNaam],
      this.context.instanceUri,
    );
  },
);

Given(
  'de response is een problemdetails met de melding dat een {resourceNaam} met de opgegeven {parameterNaam} niet bestaat',
  function (resourceNaam: string, parameterNaam: string) {
    this.result = resourceBestaatNietBadRequest(
      resourceNaam,
      parameterNaam,
      this.context.instanceUri,
    );
  },
);

Given(
  'de response is een problemdetails met de melding dat de opgegeven {parameterNaam} ongeldig is',
  function (parameterNaam: string) {
    this.result =
      parameterNaam.search(/datum/) >= 0
        ? datumParameterOngeldigBadRequest(
            parameterNaam,
            this.context.instanceUri,
          )
        : parameterOngeldigBadRequest(parameterNaam, this.context.instanceUri);
  },
);

Then(
  'is de response een problemdetails met de melding dat de {parameterNaam} en {parameterNaam} verplicht zijn',
  function (parameterNaam: string, parameterNaam2: string) {
    this.expected = parameterVerplichtBadRequest(
      [parameterNaam, parameterNaam2],
      this.context.instanceUri,
    );
  },
);

Then(
  'is de response een problemdetails met de melding dat de {parameterNaam} verplicht is',
  function (parameterNaam: string) {
    this.expected = parameterVerplichtBadRequest([parameterNaam]);
  },
);

Then(
  'is de response een problemdetails met de melding dat er geen {resourceNaam} bestaat voor de opgegeven {parameterNaam}',
  function (resourceNaam: string, parameterNaam: string) {
    this.expected = resourceBestaatNietBadRequest(
      resourceNaam,
      parameterNaam,
      this.context.instanceUri,
    );
  },
);

Then(
  'is de response een problemdetails met de melding dat de opgegeven {parameterNaam} ongeldig is',
  function (parameterNaam: string) {
    logger.debug(
      `Parameter naam: ${parameterNaam}, is datum: ${parameterNaam.search(/datum/) >= 0}`,
    );
    this.expected =
      parameterNaam.search(/datum/) >= 0
        ? datumParameterOngeldigBadRequest(
            parameterNaam,
            this.context.instanceUri,
          )
        : parameterOngeldigBadRequest(parameterNaam, this.context.instanceUri);
  },
);

Then(
  'is de response een problemdetails met de melding dat de opgegeven {parameterNaam} in de toekomst ligt',
  function (parameterNaam: string) {
    this.expected = datumInToekomstBadRequest(
      parameterNaam,
      this.context.instanceUri,
    );
  },
);

Then('is de response in json formaat', function (docString) {
  this.expected = JSON.parse(docString);
});
