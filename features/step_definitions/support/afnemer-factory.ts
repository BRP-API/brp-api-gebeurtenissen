import {Afnemer} from '../brp/afnemer-entity';
import {setupClient} from './oauth-helpers';

const gemeenteCodes = new Map<string, string>([
  ['Gemeente Amsterdam', '0363'],
  ['Gemeente Rotterdam', '0599'],
]);

export class AfnemerFactory {
  static async create(context: any, aanduiding: string): Promise<Afnemer> {
    if (!context.afnemers) {
      context.afnemers = {};
    }

    let afnemer = context.afnemers[aanduiding];
    if (!afnemer) {
      afnemer = new Afnemer(aanduiding);
      afnemer.afnemerId = (Object.keys(context.afnemers).length + 1)
        .toString()
        .padStart(6, '0');
      afnemer.oin = `00000009900${afnemer.afnemerId}0000`;
      if (gemeenteCodes.has(aanduiding)) {
        afnemer.gemeenteCode = gemeenteCodes.get(aanduiding);
      }
      context.afnemers[aanduiding] = afnemer;

      await setupClient(afnemer);
    }

    return afnemer;
  }
}
