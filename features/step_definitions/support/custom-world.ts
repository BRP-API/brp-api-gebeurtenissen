import { setWorldConstructor, World, IWorldOptions } from "@cucumber/cucumber";
import { Pickle } from "@cucumber/messages";
import { Logger } from "winston";
import { createWinstonLogger } from './logger';
import { Aanduiding } from "./aanduiding";

export interface ICustomWorld extends World {
    logger: Logger;
    tags: string[];
    stepContext: string;
    context: any;
    command: any;
    expected: any;
    result: any;
    huidigAanduiding: Aanduiding | null;
    init(pickle: Pickle): void;
}

export class CustomWorld extends World implements ICustomWorld {
    logger: Logger;
    tags: string[];
    stepContext: string;
    context: any;
    command: any;
    expected: any;
    result: any;
    huidigAanduiding: Aanduiding | null;

    constructor(options: IWorldOptions) {
        super(options);

        this.logger = createWinstonLogger(options.parameters?.logger?.level || 'warn');
        this.tags = [];
        this.stepContext = "";
        this.context = {};
        this.command = {};
        this.expected = {};
        this.result = {};
        this.huidigAanduiding = null;
    }

    init(pickle: Pickle) {
        this.tags = pickle.tags.map(tag => tag.name);
    }
}

setWorldConstructor(CustomWorld);
