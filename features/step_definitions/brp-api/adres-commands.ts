import {Command} from '../brp-api/commands.js';

export class RegistreerAdresCommand extends Command {
  gemeentecode?: string;

  constructor(gemeentecode?: string) {
    super('RegistreerAdres');

    if (gemeentecode) {
      this.gemeentecode = gemeentecode;
    }
  }
}
