import {Persoon} from '../brp/persoon-entity.js';
import {Adres} from '../brp/adres-entity.js';
import {
  createPersoon,
  createVerblijfPlaatsVoorPersoonOpAdres,
  updatePersoon,
  updatePersoonLijst,
} from './repository.js';

//import {logger} from './logger';

export class PersoonFactory {
  static async create(context: any, aanduiding: string): Promise<Persoon> {
    if (!context.personen) {
      context.personen = {};
    }

    let persoon = context.personen[aanduiding];
    context.actuelePersoon = aanduiding;

    if (!persoon) {
      persoon = new Persoon(undefined, undefined, aanduiding);
      context.personen[aanduiding] = persoon;

      await createPersoon(persoon);
    }

    return persoon;
  }

  static async update(
    context: any,
    persoon: Persoon,
    persoonTableArgs: string[] | undefined,
    persoonlijstTableArgs: string[] | undefined
  ): Promise<Persoon> {
    if (!context.personen) {
      context.personen = {};
    }

    if (persoon) {

      if (persoonTableArgs !== undefined) {
        await updatePersoon(persoon, persoonTableArgs[0], persoonTableArgs[1]);
      }

      if (persoonlijstTableArgs !== undefined) {
        await updatePersoonLijst(persoon, persoonlijstTableArgs[0], persoonlijstTableArgs[1]);
      }
    }

    return persoon;
  }

  static async verhuisNaarAdres(
    persoon: Persoon,
    adres: Adres,
    datumVan: string,
  ): Promise<void> {
    await createVerblijfPlaatsVoorPersoonOpAdres(persoon, adres, datumVan);
  }
}
