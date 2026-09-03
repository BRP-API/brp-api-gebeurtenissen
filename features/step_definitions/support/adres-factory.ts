import {Adres} from '../brp/adres-entity.js';
import {createAdres, updateAdres} from './repository.js';
//import {logger} from './logger';

export class AdresFactory {
  static async create(context: any, aanduiding: string): Promise<Adres> {
    if (!context.adressen) {
      context.adressen = {};
    }

    context.actueelAdres = aanduiding;

    let adres = context.adressen[aanduiding];

    if (!adres) {
      adres = new Adres();

      context.adressen[aanduiding] = adres;
      adres = await createAdres(adres);
    }

    return adres;
  }

  static async update(context: any, property: string, value: string) {
    context.adressen[context.actueelAdres][property] = value;

    await updateAdres(context.adressen[context.actueelAdres], property, value);
  }
}
