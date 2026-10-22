import {Command} from '../brp-api/commands.js';

class RegistreerPersoonAdres {
  adresseerbaarObjectIdentificatie?: string;
  verblijfdatum?: string;

  constructor(
    adresseerbaarObjectIdentificatie?: string,
    verblijfdatum?: string,
  ) {
    if (adresseerbaarObjectIdentificatie) {
      this.adresseerbaarObjectIdentificatie = adresseerbaarObjectIdentificatie;
    }
    if (verblijfdatum) {
      this.verblijfdatum = verblijfdatum;
    }
  }
}
export class RegistreerPersoonCommand extends Command {
  geslachtsnaam?: string;
  adres?: RegistreerPersoonAdres;

  constructor(
    geslachtsnaam?: string,
    verblijfdatum?: string,
    adresseerbaarObjectIdentificatie?: string,
  ) {
    super('RegistreerPersoon');

    if (geslachtsnaam) {
      this.geslachtsnaam = geslachtsnaam;
    }

    if (verblijfdatum || adresseerbaarObjectIdentificatie) {
      this.adres = new RegistreerPersoonAdres(
        adresseerbaarObjectIdentificatie,
        verblijfdatum,
      );
    }
  }
}
