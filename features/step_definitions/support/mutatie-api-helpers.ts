import {Command} from '../brp-api/commands.js';
import {logger} from './logger.js';
import {parseResponse} from './response-helpers.js';

export async function sendCommand(command: Command): Promise<Response> {
  try {
    const response = await fetch(
      `${process.env.MUTATIE_BASE_URL}/api/brp/personen/aangiftes`,
      {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(command),
      },
    );
    logger.debug('sendCommand', {command: command, response: response});
    return response;
  } catch (error) {
    logger.error('sendCommand failed', {command: command, error: error});
    throw error;
  }
}

async function sendCommand2(command: Command, endpoint: string): Promise<any> {
  try {
    const response = await fetch(endpoint, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(command),
    });
    logger.debug('sendCommand2', {
      command: command,
      response: response,
    });
    return parseResponse(response);
  } catch (error) {
    logger.error('sendCommand2 failed', {
      command: command,
      error: error,
    });
    throw error;
  }
}

/**
 * Stuur een muteer adres command naar de mutatie API.
 * @param context De context van de huidige test. De instanceUri property van de context wordt gezet naar '/api/brp/adressen', zodat deze kan worden gebruikt voor de instance URI bij het opbouwen van de verwachte ProblemDetails.
 * @param command Het command object dat naar de API wordt gestuurd.
 * @returns De response van de API.
 */
export async function sendMuteerAdresCommand(
  context: any,
  command: Command,
): Promise<any> {
  context.instanceUri = '/api/brp/adressen';

  return await sendCommand2(
    command,
    `${process.env.MUTATIE_BASE_URL}${context.instanceUri}`,
  );
}

/**
 * Stuur een muteer persoon command naar de mutatie API.
 * @param context De context van de huidige test. De instanceUri property van de context wordt gezet naar '/api/brp/personen', zodat deze kan worden gebruikt voor de instance URI bij het opbouwen van de verwachte ProblemDetails.
 * @param command Het command object dat naar de API wordt gestuurd.
 * @returns De response van de API.
 */
export async function sendMuteerPersoonCommand(
  context: any,
  command: Command,
): Promise<any> {
  context.instanceUri = '/api/brp/personen';

  return await sendCommand2(
    command,
    `${process.env.MUTATIE_BASE_URL}${context.instanceUri}`,
  );
}
