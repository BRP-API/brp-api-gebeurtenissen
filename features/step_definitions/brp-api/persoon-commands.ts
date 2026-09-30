import {Command} from '../brp-api/commands.js';

class RegistreerPersoonAdres {
  adresseerbaarObjectIdentificatie?: string;
  datumInschrijving?: string;

  constructor(
    adresseerbaarObjectIdentificatie?: string,
    datumInschrijving?: string,
  ) {
    if (adresseerbaarObjectIdentificatie) {
      this.adresseerbaarObjectIdentificatie = adresseerbaarObjectIdentificatie;
    }
    if (datumInschrijving) {
      this.datumInschrijving = datumInschrijving;
    }
  }
}
export class RegistreerPersoonCommand extends Command {
  geslachtsnaam?: string;
  adres?: RegistreerPersoonAdres;

  constructor(
    geslachtsnaam?: string,
    datumInschrijving?: string,
    adresseerbaarObjectIdentificatie?: string,
  ) {
    super('RegistreerPersoon');

    if (geslachtsnaam) {
      this.geslachtsnaam = geslachtsnaam;
    }

    if (datumInschrijving || adresseerbaarObjectIdentificatie) {
      this.adres = new RegistreerPersoonAdres(
        adresseerbaarObjectIdentificatie,
        datumInschrijving,
      );
    }
  }
}
