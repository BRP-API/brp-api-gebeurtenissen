import {Command} from '../brp-api/commands.js';
import {logger} from './logger.js';

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
