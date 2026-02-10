import { Afnemer } from '../brp/afnemer-entity';
import { getClientAccessToken, setupClient } from './oauth-helpers';
import { Command } from '../brp-api/commands';
import { assert } from 'chai';

export async function registreerAbonnee(afnemer?: Afnemer, command?: Command): Promise<any> {
  assert(afnemer, 'Afnemer is vereist');
  assert(command, 'Command is vereist');

  if (!afnemer.clientSetup) {
    await setupClient(afnemer!);
    afnemer.setupCompleted();
  }

  const accessToken = afnemer ? await getClientAccessToken(afnemer) : '';

  return await fetch(`${process.env.ABONNEMENT_BASE_URL}/abonnees`, {
    method: 'POST',
    headers: {
      Authorization: `Bearer ${accessToken}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(command),
  });
}

export async function abonneerOpgebeurtenisTypeVanPersoon(afnemer?: Afnemer, command?: Command): Promise<any> {
  assert(afnemer, 'Afnemer is vereist');
  assert(command, 'Command is vereist');

  if (!afnemer.clientSetup) {
    await setupClient(afnemer!);
    afnemer.setupCompleted();
  }

  const accessToken = afnemer ? await getClientAccessToken(afnemer) : '';

  return await fetch(`${process.env.ABONNEMENT_BASE_URL}/abonnees/mijn/abonnementen`, {
    method: 'POST',
    headers: {
      Authorization: `Bearer ${accessToken}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(command),
  });
}
