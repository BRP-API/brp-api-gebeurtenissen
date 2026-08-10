import {Afnemer} from '../brp/afnemer-entity.js';
import {setupClient} from './oauth-helpers.js';

const gemeenteCodes = new Map<string, string>([
  ['Gemeente Amsterdam', '0363'],
  ['Gemeente Rotterdam', '0599'],
  ['Gemeente Hengelo', '0164'],
]);

export class AfnemerFactory {
  static async create(
    context: any,
    aanduiding: string,
    isGemeente = true,
  ): Promise<Afnemer> {
    if (!context.afnemers) {
      context.afnemers = {};
    }

    let afnemer = context.afnemers[aanduiding];
    if (!afnemer) {
      afnemer = new Afnemer(aanduiding);
      afnemer.afnemerId = crypto.randomUUID();
      afnemer.oin = `00000009900${afnemer.afnemerId}0000`;
      if (gemeenteCodes.has(aanduiding)) {
        afnemer.gemeenteCode = gemeenteCodes.get(aanduiding);
      } else if (isGemeente) {
        afnemer.gemeenteCode = afnemer.afnemerId.slice(-3);
      }

      context.afnemers[aanduiding] = afnemer;

      await setupClient(afnemer);
    }

    return afnemer;
  }
}
