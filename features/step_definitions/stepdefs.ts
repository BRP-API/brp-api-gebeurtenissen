import { Before, AfterStep, After } from '@cucumber/cucumber';
import { ICustomWorld } from './support/custom-world';

Before(async function(this: ICustomWorld, { pickle }) {
    this.init(pickle);

    this.logger.info(`Scenario: ${pickle.name}`);
});

AfterStep(function(this: ICustomWorld, { pickleStep }) {
    switch(pickleStep.type) {
        case 'Context':
            this.stepContext = "given"
            this.logger.info(`Gegeven ${pickleStep.text}`, { context: this.context });
            break;
        case 'Action':
            this.stepContext = "when"
            this.logger.info(`Als ${pickleStep.text}`, { context: this.context });
            break;
        case 'Outcome':
            this.stepContext = "then"
            this.logger.info(`Dan ${pickleStep.text}`, { expected: this.expected });
            break;
        default:
            if(this.stepContext === "given") {
                this.logger.info(`${pickleStep.text}`, { context: this.context });
            }
            else if(this.stepContext === "when") {
                this.logger.info(`${pickleStep.text}`, { context: this.context });
            }
            else if(this.stepContext === "then") {
                this.logger.info(`${pickleStep.text}`, { expected: this.expected });
            }
            else {
                this.logger.info(`onbekende stap type: ${JSON.stringify(pickleStep)}`);
            }
    }
});

After(function(this: ICustomWorld, { pickle }) {
    this.logger.info(`Scenario: ${pickle.name} -----------`);
});