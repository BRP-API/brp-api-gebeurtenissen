#!/usr/bin/env node

/**
 * Setup Keycloak Client Script
 *
 * Gebruik: node scripts/setup-keycloak-client.mjs <clientId> [gemeenteCode] of node scripts/setup-keycloak-client.mjs <--client-id <clientId>] [--gemeente-code <gemeenteCode>]
 *
 * Voorbeelden:
 *   node scripts/setup-keycloak-client.mjs 'burgerzaken'
 *   node scripts/setup-keycloak-client.mjs 'gemeente amsterdam' 0363
 *   node scripts/setup-keycloak-client.mjs --client-id 'burgerzaken'
 *   node scripts/setup-keycloak-client.mjs --client-id 'gemeente amsterdam' --gemeente-code 0363
 */

import {Afnemer} from '../features/step_definitions/brp/afnemer-entity.js';
import {randomInt} from 'node:crypto';
import {PostgresqlManager} from '../features/step_definitions/support/postgresql-manager.js';
import {poolConfig} from '../features/step_definitions/support/postgresql-config.js';
import {
  setupClient,
  getClientAccessToken,
} from '../features/step_definitions/support/oauth-helpers.js';
import {createAutorisatie} from '../features/step_definitions/support/repository.js';

interface ParsedArgs {
  clientId?: string;
  gemeenteCode?: string;
}

function generateClientSecret(): string {
  const uppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  const lowercase = 'abcdefghijklmnopqrstuvwxyz';
  const numbers = '0123456789';
  const allChars = uppercase + lowercase + numbers;

  const randomChar = (characters: string): string =>
    characters[randomInt(characters.length)];

  // secret bevat minimaal 1 hoofdletter, 1 kleine letter en 1 cijfer
  let secret = '';
  secret += randomChar(uppercase);
  secret += randomChar(lowercase);
  secret += randomChar(numbers);

  // voeg willekeurig hoofdletters, kleine letters of cijfers toe voor een secret van 10 tekens
  for (let i = secret.length; i < 10; i++) {
    secret += randomChar(allChars);
  }

  // orden de tekens willekeurig in de secret
  const characters = secret.split('');
  for (let i = characters.length - 1; i > 0; i--) {
    const j = randomInt(i + 1);
    [characters[i], characters[j]] = [characters[j], characters[i]];
  }

  return characters.join('');
}

function parseArgs(argv: string[]): ParsedArgs {
  const values: ParsedArgs = {
    clientId: undefined,
    gemeenteCode: undefined,
  };

  const positional: string[] = [];

  for (let i = 0; i < argv.length; i++) {
    const arg = argv[i];

    if (arg === '--client-id' || arg === '-c') {
      values.clientId = argv[i + 1];
      i += 1;
      continue;
    }

    if (arg === '--gemeente-code' || arg === '-g') {
      values.gemeenteCode = argv[i + 1];
      i += 1;
      continue;
    }

    if (arg.startsWith('--client-id=')) {
      values.clientId = arg.split('=')[1];
      continue;
    }

    if (arg.startsWith('--gemeente-code=')) {
      values.gemeenteCode = arg.split('=')[1];
      continue;
    }

    positional.push(arg);
  }

  if (!values.clientId && positional[0]) {
    values.clientId = positional[0];
  }

  if (!values.gemeenteCode && positional[1]) {
    values.gemeenteCode = positional[1];
  }

  return values;
}

async function main(): Promise<void> {
  try {
    const args = parseArgs(process.argv.slice(2));

    if (!args.clientId) {
      console.error('Fout: clientId moet worden opgegeven.');
      console.error(
        'Gebruik: node scripts/setup-keycloak-client.mjs [--client-id <clientId>] [--gemeente-code <gemeenteCode>]',
      );
      console.error(
        "Voorbeeld: node scripts/setup-keycloak-client.mjs --client-id 'burgerzaken'",
      );
      console.error(
        "Voorbeeld: node scripts/setup-keycloak-client.mjs --client-id 'gemeente amsterdam' --gemeente-code 0363",
      );
      console.error(
        'of Gebruik (legacy): node scripts/setup-keycloak-client.mjs <clientId> [gemeenteCode]',
      );
      console.error(
        "Voorbeeld (legacy): node scripts/setup-keycloak-client.mjs 'burgerzaken'",
      );
      console.error(
        "Voorbeeld (legacy): node scripts/setup-keycloak-client.mjs 'gemeente amsterdam' 0363",
      );
      process.exit(1);
    }

    const clientId = args.clientId;
    const gemeenteCode = args.gemeenteCode || undefined;

    const clientSecret = generateClientSecret();

    const afnemer = new Afnemer(clientId);
    afnemer.clientSecret = clientSecret;
    afnemer.gemeenteCode = gemeenteCode;

    PostgresqlManager.setup(poolConfig);
    await createAutorisatie(afnemer);

    // afnemer id is automatisch gegenereerd in de createAutorisatie functie, genereer oin op basis van dit id
    afnemer.oin = `${afnemer.afnemerId}-00000009900000000000`;

    console.log('Aanmaken Keycloak client...');

    await setupClient(afnemer);

    await getClientAccessToken(afnemer);

    console.log('Keycloak client succesvol aangemaakt!');
    console.log(`  Client ID: ${afnemer.aanduiding}`);
    console.log(`  Client Secret: ${afnemer.clientSecret}`);
    console.log(`  Afnemer ID: ${afnemer.afnemerId}`);
    console.log(`  Scope: ${afnemer.oin}`);
  } catch (error) {
    const message = error instanceof Error ? error.message : String(error);
    console.error('Fout bij het aanmaken van de Keycloak client:', message);
    process.exit(1);
  } finally {
    try {
      await PostgresqlManager.getInstance().close();
    } catch {
      // no-op: setup may not have been called yet
    }
  }
}

// Run the script
void main();
