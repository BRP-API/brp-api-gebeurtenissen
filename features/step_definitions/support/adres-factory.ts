import {Adres} from '../brp/adres-entity';
import {createAdres, updateAdres} from './repository';
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

      const adresParts =
        /([a-zA-Z_]+)_(\d+)(_\d{4}[A-Z]{2})?_([a-zA-Z_]+)/.exec(aanduiding) ||
        [];

      if (adresParts !== null && adresParts.length > 4) {
        adres.straat_naam = adresParts[1].replaceAll('_', ' ').substring(0, 24);
        adres.open_ruimte_naam = adresParts[1].replaceAll('_', ' ');
        adres.huis_nr = adresParts[2];
        if (adresParts[3] !== undefined) {
          adres.postcode = adresParts[3].substring(1);
        }
        adres.woon_plaats_naam = adresParts[4];
      }

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
