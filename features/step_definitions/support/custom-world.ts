import { setWorldConstructor, World, IWorldOptions } from '@cucumber/cucumber';
import { Pickle } from '@cucumber/messages';
import { setupLogger } from './logger';
import { Aanduiding } from './aanduiding';

export interface ICustomWorld extends World {
  tags: string[];
  stepContext: string;
  context: any;
  command: any;
  expected: any;
  result: any;
  huidigAanduiding: Aanduiding | null;
  isStapDocumentatieScenario: boolean;
  isStapDocumentatieIntegratieScenario: boolean;
  init(pickle: Pickle): void;
}

export class CustomWorld extends World implements ICustomWorld {
  tags: string[];
  stepContext: string;
  context: any;
  command: any;
  expected: any;
  result: any;
  huidigAanduiding: Aanduiding | null;
  isStapDocumentatieScenario: boolean = false;
  isStapDocumentatieIntegratieScenario: boolean = false;

  constructor(options: IWorldOptions) {
    super(options);

    setupLogger(options.parameters?.logger?.level || 'warn');
    this.tags = [];
    this.stepContext = '';
    this.context = {};
    this.command = {};
    this.expected = {};
    this.result = {};
    this.huidigAanduiding = null;
  }

  init(pickle: Pickle) {
    this.tags = pickle.tags.map((tag) => tag.name);

    this.isStapDocumentatieScenario = this.tags.includes('@stap-documentatie') && !this.tags.includes('@integratie');
    this.isStapDocumentatieIntegratieScenario = this.tags.includes('@stap-documentatie') && this.tags.includes('@integratie');
  }
}

setWorldConstructor(CustomWorld);
