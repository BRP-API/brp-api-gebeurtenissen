import { Before, BeforeStep, AfterStep, After, AfterAll } from '@cucumber/cucumber';
import { ICustomWorld } from './support/custom-world';
import { expect } from 'chai';
import { PostgresqlManager } from './support/postgresql-manager';
import { poolConfig } from './support/postgresql-config';
import { createAdres, createPersoon } from './support/repository';

Before(async function(this: ICustomWorld, { pickle }) {
    this.init(pickle);

    PostgresqlManager.setup(poolConfig, this.logger);

    this.logger.info(`Scenario: ${pickle.name}`);
});

AfterAll(async function() {
    await PostgresqlManager.getInstance().close();
});

BeforeStep({tags: '@integratie'}, async function(this: ICustomWorld, { pickleStep }) {
    switch(pickleStep.type) {
        case 'Context':
            break;
        case 'Action':
            break;
        case 'Outcome':
            if(this.huidigAanduiding?.isAdres) {
                await createAdres(this.context.adressen[this.huidigAanduiding.id!]);
                this.huidigAanduiding = null;
            }
            if(this.huidigAanduiding?.isPersoon) {
                await createPersoon(this.context.personen[this.huidigAanduiding.id!]);
                this.huidigAanduiding = null;
            }
            break;
        default:
            if(pickleStep.text.startsWith('de persoon')) {
                if(this.huidigAanduiding?.isAdres) {
                    await createAdres(this.context.adressen[this.huidigAanduiding.id!]);
                    this.huidigAanduiding = null;
                }
                if(this.huidigAanduiding?.isPersoon) {
                    await createPersoon(this.context.personen[this.huidigAanduiding.id!]);
                    this.huidigAanduiding = null;
                }
            }
    }
});

AfterStep(function(this: ICustomWorld, { pickleStep }) {
    switch(pickleStep.type) {
        case 'Context':
            this.stepContext = "given";
            this.logger.info(`Gegeven ${pickleStep.text}`, { context: this.context });
            break;
        case 'Action':
            this.stepContext = "when"
            this.logger.info(`Als ${pickleStep.text}`, { command: this.command });
            break;
        case 'Outcome':
            this.stepContext = "then"
            this.logger.info(`Dan ${pickleStep.text}`, { context: this.context, command: this.command, result: this.result, expected: this.expected });
            break;
        default:
            if(this.stepContext === "given") {
                this.logger.info(`Gegeven ${pickleStep.text}`, { context: this.context });
            }
            else if(this.stepContext === "when") {
                this.logger.info(`Als ${pickleStep.text}`, { command: this.command });
            }
            else if(this.stepContext === "then") {
                this.logger.info(`Dan ${pickleStep.text}`, { context: this.context, command: this.command, result: this.result, expected: this.expected });
            }
            else {
                this.logger.info(`onbekende stap type: ${JSON.stringify(pickleStep)}`);
            }
    }
});

After(function(this: ICustomWorld, { pickle }) {
    this.logger.info(`Scenario: ${pickle.name} -----------`);

    expect(this.result).to.deep.equal(this.expected);
});
