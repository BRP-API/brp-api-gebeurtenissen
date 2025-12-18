import { Command } from '../brp-api/commands';
import { logger } from './logger';

export async function sendCommand(command: Command) : Promise<Response> {
    const response = await fetch(`${process.env.MUTATIE_BASE_URL}/personen/aangiftes`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(command)
    });

    logger.debug(`sendCommand`, { command: command, response: response });
    
    return response;
}
