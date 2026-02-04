#!/usr/bin/env node

/**
 * Setup Keycloak Client Script
 * 
 * Gebruik: node scripts/setup-keycloak-client.js <clientId> <afnemerId> [gemeenteCode]
 * 
 * Voorbeelden:
 *   node scripts/setup-keycloak-client.js 'burgerzaken' 000001
 *   node scripts/setup-keycloak-client.js 'gemeente amsterdam' 000001 0363
 */

require('ts-node').register({
  project: 'tsconfig.json',
  transpileOnly: true,
});

const { setupClient, getClientAccessToken } = require('../features/step_definitions/support/oauth-helpers.ts');

function generateClientSecret() {
  const uppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  const lowercase = 'abcdefghijklmnopqrstuvwxyz';
  const numbers = '0123456789';
  const allChars = uppercase + lowercase + numbers;

  // secret bevat minimaal 1 hoofdletter, 1 kleine letter en 1 cijfer
  let secret = '';
  secret += uppercase[Math.floor(Math.random() * uppercase.length)];
  secret += lowercase[Math.floor(Math.random() * lowercase.length)];
  secret += numbers[Math.floor(Math.random() * numbers.length)];

  // voeg willekeurig hoofdletters, kleine letters of cijfers toe voor een secret van 10 tekens
  for (let i = secret.length; i < 10; i++) {
    secret += allChars[Math.floor(Math.random() * allChars.length)];
  }

  // orden de tekens willekeurig in de secret
  return secret.split('').sort(() => Math.random() - 0.5).join('');
}

async function main() {
  try {
    const args = process.argv.slice(2);

    if (args.length === 0) {
      console.error('Fout: clientId en afnemerId moet worden opgegeven.');
      console.error('Gebruik: node scripts/setup-keycloak-client.js <clientId> <afnemerId> [gemeenteCode]');
      console.error('Voorbeeld: node scripts/setup-keycloak-client.js \'burgerzaken\' 000001');
      console.error('Voorbeeld: node scripts/setup-keycloak-client.js \'gemeente amsterdam\' 000001 0363');
      process.exit(1);
    }

    const clientId = args[0];
    const afnemerId = args[1];
    const gemeenteCode = args[2] || undefined;

    const clientSecret = generateClientSecret();

    const afnemer = {
      aanduiding: clientId,
      afnemerId: afnemerId,
      oin: `000000099000000${afnemerId}`,
      gemeenteCode: gemeenteCode,
      clientSecret: clientSecret,
    };

    console.log('Aanmaken Keycloak client...');

    await setupClient(afnemer);

    await getClientAccessToken(afnemer);

    console.log('Keycloak client succesvol aangemaakt!');
    console.log(`  Client ID: ${afnemer.aanduiding}`);
    console.log(`  Client Secret: ${afnemer.clientSecret}`);
    console.log(`  Scope: ${afnemer.oin}`);
  } catch (error) {
    console.error('Fout bij het aanmaken van de Keycloak client:', error.message);
    process.exit(1);
  }
}

// Run the script
main();
