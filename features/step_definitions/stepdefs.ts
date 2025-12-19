import { Before, BeforeStep, AfterStep, After, AfterAll } from '@cucumber/cucumber';
import { ICustomWorld } from './support/custom-world';
import { expect } from 'chai';
import { PostgresqlManager } from './support/postgresql-manager';
import { poolConfig } from './support/postgresql-config';
import { createAdres, createPersoon, deleteAdres } from './support/repository';
import { setupClient, tearDownClient } from './support/oauth-helpers';
import { logger } from './support/logger';
import { sendCommand } from './support/mutatie-api-helpers';
import { getLastEventFrom } from './support/axon-api-helpers';
import { Event } from './brp/verhuisd-intergemeentelijk-event';

Before(async function(this: ICustomWorld, { pickle }) {
    this.init(pickle);

    PostgresqlManager.setup(poolConfig);

    logger.debug(`Scenario: ${pickle.name}. Start`);
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
    if(this.huidigAanduiding?.isCommand) {
        const response = await sendCommand(this.command!);
        if(response.status === 201) {
            this.result = await getLastEventFrom(this.context.personen[this.huidigAanduiding.id!].a_nr);
        }
        this.huidigAanduiding = null;
    }
}

BeforeStep(async function(this: ICustomWorld, { pickleStep }) {
    if(this.isStapDocumentatieScenario) {
        return;
    }

    switch(pickleStep.type) {
        case 'Context':
        case 'Action':
        case 'Outcome':
            await createHuidigAanduiding.call(this);
            break;
        default:
            if(pickleStep.text.startsWith('het adres') ||
             pickleStep.text.startsWith('de persoon') ||
             pickleStep.text.startsWith('de aangifte')) {
                await createHuidigAanduiding.call(this);
            }
    }
});

AfterStep(function(this: ICustomWorld, { pickleStep }) {
    switch(pickleStep.type) {
        case 'Context':
            this.stepContext = "given";
            logger.info(`Gegeven ${pickleStep.text}`);
            break;
        case 'Action':
            this.stepContext = "when"
            logger.info(`Als ${pickleStep.text}`);
            break;
        case 'Outcome':
            this.stepContext = "then"
            logger.info(`Dan ${pickleStep.text}`);
            break;
        default:
            if(this.stepContext === "given") {
                logger.info(`Gegeven ${pickleStep.text}`);
            }
            else if(this.stepContext === "when") {
                logger.info(`Als ${pickleStep.text}`);
            }
            else if(this.stepContext === "then") {
                logger.info(`Dan ${pickleStep.text}`);
            }
            else if(pickleStep.text.startsWith('het adres') || pickleStep.text.startsWith('de persoon') || pickleStep.text.startsWith('de aangifte')) {
                this.stepContext = "given";
                logger.info(`Gegeven ${pickleStep.text}`);
            }
            else {
                logger.warn(`onbekende stap type: ${JSON.stringify(pickleStep)}`);
            }
    }
});

function copyIdIfExpectedIsExternalEventAndResultHasId(expected: any, result: any) {
    if (expected instanceof Event &&
        !expected.intern &&
        result && result.id) {
            expected.id = result.id;
    }
}

After(async function(this: ICustomWorld, { pickle }) {
    logger.info(`Scenario ${pickle.name}. End`, { context: this.context, command: this.command, result: this.result, expected: this.expected });

    copyIdIfExpectedIsExternalEventAndResultHasId(this.expected, this.result);

    expect(this.result).to.deep.equal(this.expected);
});

After(async function(this: ICustomWorld) {
    if(this.isStapDocumentatieScenario) {
        return;
    }

    if(this.context.afnemers) {
        for (const key of Object.keys(this.context.afnemers))
        {
            await tearDownClient(this.context.afnemers[key]);
        }
    }
    if(this.context.adressen) {
        for (const key of Object.keys(this.context.adressen))
        {
            await deleteAdres(this.context.adressen[key]);
        }
    }
});
