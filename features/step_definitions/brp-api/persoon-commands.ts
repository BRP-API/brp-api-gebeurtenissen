import {Command} from '../brp-api/commands.js';

export class RegistreerPersoonCommand extends Command {
  geslachtsnaam?: string;
  constructor(geslachtsnaam?: string) {
    super('RegistreerPersoon');

    if (geslachtsnaam) {
      this.geslachtsnaam = geslachtsnaam;
    }
  }
}
