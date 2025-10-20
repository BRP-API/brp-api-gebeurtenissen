import { setWorldConstructor, World, IWorldOptions } from "@cucumber/cucumber";
import { Pickle } from "@cucumber/messages";
import { Logger } from "winston";
import { createWinstonLogger } from './logger';

export interface ICustomWorld extends World {
    logger: Logger;
    tags: string[];
    stepContext: string;
    context: any;
    expected: any;
    result: any;
    init(pickle: Pickle): void;
}

export class CustomWorld extends World implements ICustomWorld {
    logger: Logger;
    tags: string[];
    stepContext: string;
    context: any;
    expected: any;
    result: any;

    constructor(options: IWorldOptions) {
        super(options);

        this.logger = createWinstonLogger(options.parameters?.logger?.level || 'warn');
        this.tags = [];
        this.stepContext = "";
        this.context = {};
        this.expected = {};
        this.result = {};
    }

    init(pickle: Pickle) {
        this.tags = pickle.tags.map(tag => tag.name);
    }
}

setWorldConstructor(CustomWorld);
