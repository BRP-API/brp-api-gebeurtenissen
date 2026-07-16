import {Adres} from '../brp/adres-entity';
import {createAdres, updateAdres} from './repository';
import {logger} from './logger';

export class AdresFactory {
  static async create(context: any, aanduiding: string) {
    if (!context.adressen) {
      context.adressen = {};
    }

    context.actueelAdres = aanduiding;

    let adres = context.adressen[aanduiding];
    if (!adres) {
      adres = new Adres();
      context.adressen[aanduiding] = adres;
      await createAdres(adres);
    }
    
    return adres;
  }

  static async update(context: any, property: string, value: string) {
    context.adressen[context.actueelAdres][property] = value;
    logger.debug('update het adres', context.adressen[context.actueelAdres]);
    await updateAdres(context.adressen[context.actueelAdres], property, value);
  }


}