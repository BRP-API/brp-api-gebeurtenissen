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

export async function sendMuteerAdresCommand(command: Command): Promise<any> {
  return await sendCommand2(
    command,
    `${process.env.MUTATIE_BASE_URL}/api/brp/adressen`,
  );
}

export async function sendMuteerPersoonCommand(command: Command): Promise<any> {
  return await sendCommand2(
    command,
    `${process.env.MUTATIE_BASE_URL}/api/brp/personen`,
  );
}
