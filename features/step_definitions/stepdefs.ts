import { Before, BeforeStep, AfterStep, After, AfterAll } from '@cucumber/cucumber';
import { ICustomWorld } from './support/custom-world';
import { expect } from 'chai';
import { PostgresqlManager } from './support/postgresql-manager';
import { poolConfig } from './support/postgresql-config';
import { createAdres, createPersoon } from './support/repository';
import { setupClient, tearDownClient } from './support/oauth-helpers';
import { logger } from './support/logger';

Before(async function(this: ICustomWorld, { pickle }) {
    this.init(pickle);

    PostgresqlManager.setup(poolConfig);

    logger.info(`Scenario: ${pickle.name}`);
});

AfterAll(async function() {
    await PostgresqlManager.getInstance().close();
});

async function createHuidigAanduiding(this: ICustomWorld) {
    if(this.huidigAanduiding?.isAfnemer) {
        await setupClient(this.context.afnemers[this.huidigAanduiding.id!]);
        this.huidigAanduiding = null;
    }
    if(this.huidigAanduiding?.isAdres) {
        await createAdres(this.context.adressen[this.huidigAanduiding.id!]);
        this.huidigAanduiding = null;
    }
    if(this.huidigAanduiding?.isPersoon) {
        await createPersoon(this.context.personen[this.huidigAanduiding.id!]);
        this.huidigAanduiding = null;
    }
}

BeforeStep({tags: '@integratie'}, async function(this: ICustomWorld, { pickleStep }) {
    switch(pickleStep.type) {
        case 'Context':
        case 'Action':
        case 'Outcome':
            await createHuidigAanduiding.call(this);
            break;
        default:
            if(pickleStep.text.startsWith('de persoon')) {
                await createHuidigAanduiding.call(this);
            }
    }
});

AfterStep(function(this: ICustomWorld, { pickleStep }) {
    switch(pickleStep.type) {
        case 'Context':
            this.stepContext = "given";
            logger.info(`Gegeven ${pickleStep.text}`, { context: this.context });
            break;
        case 'Action':
            this.stepContext = "when"
            logger.info(`Als ${pickleStep.text}`, { command: this.command });
            break;
        case 'Outcome':
            this.stepContext = "then"
            logger.info(`Dan ${pickleStep.text}`, { context: this.context, command: this.command, result: this.result, expected: this.expected });
            break;
        default:
            if(this.stepContext === "given") {
                logger.info(`Gegeven ${pickleStep.text}`, { context: this.context });
            }
            else if(this.stepContext === "when") {
                logger.info(`Als ${pickleStep.text}`, { command: this.command });
            }
            else if(this.stepContext === "then") {
                logger.info(`Dan ${pickleStep.text}`, { context: this.context, command: this.command, result: this.result, expected: this.expected });
            }
            else {
                logger.info(`onbekende stap type: ${JSON.stringify(pickleStep)}`);
            }
    }
});

After(async function(this: ICustomWorld, { pickle }) {
    logger.info(`Scenario: ${pickle.name} -----------`);

    expect(this.result).to.deep.equal(this.expected);
});

After({tags: '@integratie'}, async function(this: ICustomWorld) {
    if(this.context.afnemers) {
        for (const key of Object.keys(this.context.afnemers))
        {
            await tearDownClient(this.context.afnemers[key]);
        }
    }
});
