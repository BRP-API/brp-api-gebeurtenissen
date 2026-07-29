import {Persoon} from '../brp/persoon-entity.js';
import {Adres} from '../brp/adres-entity';
import {
  createPersoon,
  createVerblijfPlaatsVoorPersoonOpAdres,
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

  static async verhuisNaarAdres(
    persoon: Persoon,
    adres: Adres,
    datumVan: string,
  ): Promise<void> {
    await createVerblijfPlaatsVoorPersoonOpAdres(persoon, adres, datumVan);
  }
}
