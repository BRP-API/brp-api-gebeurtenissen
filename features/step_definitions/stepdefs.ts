import {
  Before,
  BeforeStep,
  AfterStep,
  After,
  AfterAll,
} from '@cucumber/cucumber';
import {ICustomWorld} from './support/custom-world.js';
import {expect} from 'chai';
import {PostgresqlManager} from './support/postgresql-manager.js';
import {poolConfig} from './support/postgresql-config.js';
import {
  createAdres,
  createPersoon,
  deleteAdres,
  deletePersoon,
} from './support/repository.js';
import {tearDownClient} from './support/oauth-helpers.js';
import {logger} from './support/logger.js';
import {sendCommand} from './support/mutatie-api-helpers.js';
import {getLastEventFrom} from './support/axon-api-helpers.js';
import {Event} from './brp/verhuisd-intergemeentelijk-event.js';
import {deregistreerAbonneeVoorAfnemer} from './support/abonnement-api-helpers.js';
import {Afnemer} from './brp/afnemer-entity.js';
import {ProblemDetails} from './support/problem-details.js';
import {use} from 'chai';
import chaiExclude from 'chai-exclude';

Before(async function (this: ICustomWorld, {pickle}) {
  this.init(pickle);
  use(chaiExclude);
  PostgresqlManager.setup(poolConfig);

  logger.debug(`Scenario: ${pickle.name}. Start`);
});

AfterAll(async () => {
  await PostgresqlManager.getInstance().close();
});

async function createHuidigAanduiding(this: ICustomWorld) {
  if (this.huidigAanduiding?.isAdres) {
    await createAdres(this.context.adressen[this.huidigAanduiding.id!]);
    this.huidigAanduiding = null;
  }
  if (this.huidigAanduiding?.isPersoon) {
    await createPersoon(this.context.personen[this.huidigAanduiding.id!]);
    this.huidigAanduiding = null;
  }
  if (this.huidigAanduiding?.isCommand) {
    const response = await sendCommand(this.command);
    if (response.status === 201) {
      this.result = await getLastEventFrom(
        this.context.personen[this.huidigAanduiding.id!].a_nr,
      );
    }
    this.huidigAanduiding = null;
  }
}

BeforeStep(async function (this: ICustomWorld, {pickleStep}) {
  if (this.isStapDocumentatieScenario) {
    return;
  }

  switch (pickleStep.type) {
    case 'Context':
    case 'Action':
    case 'Outcome':
      await createHuidigAanduiding.call(this);
      break;
    default:
      if (
        pickleStep.text.startsWith('het adres') ||
        pickleStep.text.startsWith('de persoon') ||
        pickleStep.text.startsWith('de aangifte')
      ) {
        await createHuidigAanduiding.call(this);
      }
  }
});

AfterStep(function (this: ICustomWorld, {pickleStep}) {
  switch (pickleStep.type) {
    case 'Context':
      this.stepContext = 'given';
      logger.info(`Gegeven ${pickleStep.text}`);
      break;
    case 'Action':
      this.stepContext = 'when';
      logger.info(`Als ${pickleStep.text}`);
      break;
    case 'Outcome':
      this.stepContext = 'then';
      logger.info(`Dan ${pickleStep.text}`);
      break;
    default:
      if (this.stepContext === 'given') {
        logger.info(`Gegeven ${pickleStep.text}`);
      } else if (this.stepContext === 'when') {
        logger.info(`Als ${pickleStep.text}`);
      } else if (this.stepContext === 'then') {
        logger.info(`Dan ${pickleStep.text}`);
      } else if (
        pickleStep.text.startsWith('het adres') ||
        pickleStep.text.startsWith('de persoon') ||
        pickleStep.text.startsWith('de aangifte')
      ) {
        this.stepContext = 'given';
        logger.info(`Gegeven ${pickleStep.text}`);
      } else {
        logger.warn(`onbekende stap type: ${JSON.stringify(pickleStep)}`);
      }
  }

  logger.debug(this.context);
});

function copyIdIfExpectedIsExternalEventAndResultHasId(
  expected: any,
  result: any,
) {
  if (
    expected instanceof Event &&
    !expected.intern &&
    result?.id !== undefined
  ) {
    expected.id = result.id;
  }
}

function assertProblemDetailsResult(expected: any, actual: any) {
  expect(actual).to.be.an(
    'object',
    `Response is geen (ProblemDetails) object. Response: ${JSON.stringify({actual: actual, expected: expected}, null, 2)}`,
  );

  const body = actual;
  expect(body)
    .to.have.property('type')
    .that.equals(
      expected.type,
      JSON.stringify({actual: actual, expected: expected}, null, 2),
    );
  expect(body)
    .to.have.property('status')
    .that.equals(
      expected.status,
      JSON.stringify({actual: actual, expected: expected}, null, 2),
    );
  if (expected.title) {
    expect(body)
      .to.have.property('title')
      .that.equals(
        expected.title,
        JSON.stringify({actual: actual, expected: expected}, null, 2),
      );
  }
  if (expected.detail) {
    expect(body)
      .to.have.property('detail')
      .that.equals(
        expected.detail,
        JSON.stringify({actual: actual, expected: expected}, null, 2),
      );
  }
  if (expected.instance) {
    expect(body)
      .to.have.property('instance')
      .that.equals(
        expected.instance,
        JSON.stringify({actual: actual, expected: expected}, null, 2),
      );
  }
}

After(async function (this: ICustomWorld, {pickle}) {
  logger.info(`Scenario ${pickle.name}. End`, {
    context: this.context,
    command: this.command,
    result: this.result,
    expected: this.expected,
  });

  copyIdIfExpectedIsExternalEventAndResultHasId(this.expected, this.result);

  if (this.expected === null) {
    return;
  }
  if (this.expected instanceof ProblemDetails) {
    assertProblemDetailsResult(this.expected, this.result);
  } else {
    expect(this.result)
      .excludingEvery('id')
      .to.deep.equal(this.expected, JSON.stringify(this.result, null, 2));
  }
});

After(async function (this: ICustomWorld) {
  if (this.isStapDocumentatieScenario) {
    return;
  }

  if (this.context.afnemers) {
    for (const key of Object.keys(this.context.afnemers)) {
      const afnemer = this.context.afnemers[key] as Afnemer;
      for (const abonneeNaam of afnemer.abonnees) {
        await deregistreerAbonneeVoorAfnemer(afnemer, abonneeNaam);
      }
      await tearDownClient(afnemer);
      delete this.context.afnemers[key];
    }
  }
  if (this.context.adressen) {
    for (const key of Object.keys(this.context.adressen)) {
      await deleteAdres(this.context.adressen[key]);
    }
  }

  if (this.context.personen) {
    for (const key of Object.keys(this.context.personen)) {
      await deletePersoon(this.context.personen[key]);
    }
  }
});
